import os
from flask import request
import tempfile

from backend.realtime.live_predictor import predict_audio_file
from backend.database.session_repository import SessionRepository
from backend.utils.audio_converter import convert_to_wav
from backend.realtime.session_manager import SessionManager

from backend.utils.audio_preprocessor import preprocess_audio

from flask import send_file

from backend.export.exporter import (

    export_excel,

    export_csv

)

from flask import jsonify, render_template

from backend.database.session_repository import (

    SessionRepository

)

# Global Live Practice Session

live_session = SessionManager()

repo = SessionRepository()


# --------------------------------

def home():

    return jsonify(

        {

            "project":

                "Voice-Based Yoga Assistant",

            "status":

                "Running"

        }

    )


# --------------------------------

def dashboard():

    history = repo.get_all_sessions()

    statistics = repo.get_statistics()

    latest = repo.get_latest_session()

    today = repo.get_today_summary()

    total_sessions = 0

    total_duration = 0

    om_count = 0

    bhramari_count = 0

    average_confidence = 0

    confidence_sum = 0

    confidence_count = 0

    for row in statistics:

        total_sessions += row["total_count"]

        total_duration += row["total_duration"]

        confidence_sum += row["average_confidence"]

        confidence_count += 1

        if row["pranayama"] == "Om":

            om_count = row["total_count"]

        elif row["pranayama"] == "Bhramari":

            bhramari_count = row["total_count"]

    if confidence_count > 0:

        average_confidence = round(

            confidence_sum / confidence_count,

            2

        )

    return render_template(

        "dashboard.html",

        history=history,

        statistics=statistics,

        latest=latest,

        today=today,

        total_sessions=total_sessions,

        total_duration=round(total_duration,2),

        om_count=om_count,

        bhramari_count=bhramari_count,

        average_confidence=average_confidence

    )


def download_excel():

    filepath = export_excel()

    print(filepath)

    return send_file(

        os.path.abspath(filepath),

        as_attachment=True,

        download_name="session_history.xlsx"

    )


def download_csv():

    filepath = export_csv()

    print(filepath)

    return send_file(

        os.path.abspath(filepath),

        as_attachment=True,

        download_name="session_history.csv"

    )


def history():

    rows = repo.get_all_sessions()

    result = []

    for row in rows:

        result.append(

            dict(row)

        )

    return jsonify(result)


def history_page():

    history = repo.get_all_sessions()

    return render_template(

        "history.html",

        history=history

    )


def statistics_page():

    statistics = repo.get_statistics()

    om_count = 0
    bhramari_count = 0

    om_duration = 0
    bhramari_duration = 0

    for row in statistics:

        if row["pranayama"] == "Om":
            om_count = row["total_count"]
            om_duration = row["total_duration"]

        elif row["pranayama"] == "Bhramari":
            bhramari_count = row["total_count"]
            bhramari_duration = row["total_duration"]

    return render_template(
        "statistics.html",
        statistics=statistics,
        om_count=om_count,
        bhramari_count=bhramari_count,
        om_duration=round(om_duration, 2),
        bhramari_duration=round(bhramari_duration, 2)
    )

def about_page():

    return render_template(

        "about.html"

    )


# --------------------------------

def statistics():

    rows = repo.get_statistics()

    result = []

    for row in rows:

        result.append(

            dict(row)

        )

    return jsonify(result)


# --------------------------------

def clear_history():

    repo.delete_history()

    return jsonify(

        {

            "message":

                "History Deleted Successfully"

        }

    )

# --------------------------------
def dashboard_api():

    statistics = repo.get_statistics()

    latest = repo.get_latest_session()

    today = repo.get_today_summary()

    total_sessions = 0
    total_duration = 0

    om_count = 0
    bhramari_count = 0

    average_confidence = 0
    confidence_sum = 0
    confidence_count = 0

    for row in statistics:

        total_sessions += row["total_count"]
        total_duration += row["total_duration"]

        confidence_sum += row["average_confidence"]
        confidence_count += 1

        if row["pranayama"] == "Om":
            om_count = row["total_count"]

        elif row["pranayama"] == "Bhramari":
            bhramari_count = row["total_count"]

    if confidence_count > 0:

        average_confidence = round(
            confidence_sum / confidence_count,
            2
        )

    # --------------------------------
    # Latest Detection
    # --------------------------------

    last_detection = None

    if latest:
        last_detection = latest["pranayama"]

    # --------------------------------
    # Today's Summary
    # --------------------------------

    today_sessions = 0
    today_duration = 0

    if today:
        today_sessions = today["total"] or 0
        today_duration = today["duration"] or 0

    return jsonify({

        "om_count": om_count,

        "bhramari_count": bhramari_count,

        "total_sessions": total_sessions,

        "total_duration": round(
            total_duration,
            2
        ),

        "average_confidence": average_confidence,

        "last_detection": last_detection,

        "today_sessions": today_sessions,

        "today_duration": round(
            today_duration,
            2
        )

    })


def process_uploaded_audio(audio):

    extension = os.path.splitext(audio.filename)[1].lower()

    if extension == "":
        extension = ".m4a"

    uploaded_file = tempfile.NamedTemporaryFile(
        delete=False,
        suffix=extension
    )

    uploaded_file.close()

    wav_file = None
    processed_file = None

    try:

        audio.save(uploaded_file.name)

        print("Uploaded size:", os.path.getsize(uploaded_file.name))

        print("=" * 60)
        print(f"Uploaded File : {uploaded_file.name}")

        # Convert to WAV
        wav_file = convert_to_wav(uploaded_file.name)

        print(f"Converted WAV : {wav_file}")

        # Preprocess
        processed_file = preprocess_audio(wav_file)

        # AI Prediction
        prediction, confidence, duration = predict_audio_file(
            processed_file
        )

        return {
            "success": True,
            "prediction": prediction,
            "confidence": confidence,
            "duration": duration
        }

    finally:

        if os.path.exists(uploaded_file.name):
            os.remove(uploaded_file.name)

        if (
            wav_file
            and os.path.exists(wav_file)
        ):
            os.remove(wav_file)

        if (
            processed_file
            and os.path.exists(processed_file)
        ):
            os.remove(processed_file)


def predict():

    if "audio" not in request.files:
        return jsonify({
            "success": False,
            "message": "No audio file uploaded"
        }), 400

    audio = request.files["audio"]

    result = process_uploaded_audio(audio)

    if result["prediction"] is None:

        return jsonify({
            "success": False,
            "message": "Silence detected"
        })

    repo.save_session(
        result["prediction"],
        result["duration"],
        result["confidence"]
    )

    return jsonify({
        "success": True,
        "prediction": result["prediction"],
        "confidence": round(
            result["confidence"] * 100,
            2
        ),
        "duration": result["duration"]
    })


def start_live_session():

    global live_session
    live_session = SessionManager()

    print("\n===================================")
    print("LIVE SESSION STARTED")
    print("===================================\n")

    return jsonify({
        "success": True,
        "message": "Live session started"
    })

def stop_live_session():

    global live_session
    summary = live_session.get_summary()

    print("\n========== FINAL SUMMARY ==========")
    print(summary)
    print("===================================")

    return jsonify({
        "success": True,
        "summary": summary
    })

def live_chunk():

    global live_session
    if live_session is None:
        return jsonify({
            "success": False,
            "message": "Live session not started"
        }), 400

    if "audio" not in request.files:

        return jsonify({
            "success": False,
            "message": "No audio uploaded"
        }), 400

    audio = request.files["audio"]

    result = process_uploaded_audio(audio)

    if not result["success"]:
        return jsonify(result)

    if result["prediction"] is None:
        return jsonify({
            "success": False,
            "message": "Silence"
        })

    prediction = result["prediction"]
    confidence = result["confidence"]
    duration = result["duration"]

    # Update live counter

    live_session.add_session(
        prediction,
        duration
    )

    # Save accepted prediction

    repo.save_session(
        prediction,
        duration,
        confidence
    )

    return jsonify({
        "success": True,
        "prediction": prediction,
        "confidence": round(
            confidence * 100,
            2
        ),
        "duration": round(
            duration,
            2
        ),
        "summary": live_session.get_summary()
    })

def delete_selected_history():

    data = request.get_json()

    if not data:

        return jsonify({

            "success": False,

            "message": "Invalid request"

        }), 400

    session_ids = data.get(
        "session_ids",
        []
    )

    if not session_ids:

        return jsonify({

            "success": False,

            "message": "No sessions selected"

        }), 400

    repo.delete_sessions(
        session_ids
    )

    return jsonify({

        "success": True,

        "message": "Selected sessions deleted"

    })


def delete_all_history():

    repo.delete_history()

    return jsonify({

        "success": True,

        "message": "All sessions deleted"

    })