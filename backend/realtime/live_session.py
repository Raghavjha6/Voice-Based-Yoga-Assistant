from backend.database.session_repository import (
    SessionRepository
)

from backend.realtime.vad_recorder import (
    VADRecorder
)

from backend.realtime.live_predictor import (
    predict_audio_file
)

from backend.realtime.pranayama_counter import (
    PranayamaCounter
)


counter = PranayamaCounter()

recorder = VADRecorder()

repository = SessionRepository()

print("=" * 60)
print("      Voice-Based Yoga Assistant")
print("=" * 60)
print("Automatic Voice Detection Enabled")
print("Press CTRL + C to stop the session\n")


try:

    while True:

        # ----------------------------------
        # Wait until a complete chant
        # has been recorded automatically
        # ----------------------------------

        file_path, duration = recorder.listen()

        print("\nProcessing Audio...\n")

        prediction, confidence, predicted_duration = predict_audio_file(
            file_path
        )

        if duration <= 0:
            duration = predicted_duration

        # ----------------------------------
        # Silence
        # ----------------------------------

        if prediction is None:

            print("Silence Detected")

            counter.update(None, 0)

            continue

        # ----------------------------------
        # Prediction
        # ----------------------------------

        print(
            f"Detected : {prediction}"
        )

        print(
            f"Confidence : {confidence:.2f}"
        )

        # ----------------------------------
        # Ignore uncertain predictions
        # ----------------------------------

        if confidence < 0.70:

            print(
                "Low Confidence - Ignored"
            )

            counter.update(None, 0)

            continue

        # ----------------------------------
        # Update Counter
        # ----------------------------------

        counter.update(
            prediction,
            duration
        )

        repository.save_session(
            prediction,
            duration,
            confidence
        )

        print("\nSession Saved Successfully")

        summary = counter.summary()

        print("\n========== SESSION SUMMARY ==========")

        print(
            f"Om        : "
            f"{summary['Om']['count']} "
            f"({summary['Om']['duration']:.2f} sec)"
        )

        print(
            f"Bhramari : "
            f"{summary['Bhramari']['count']} "
            f"({summary['Bhramari']['duration']:.2f} sec)"
        )

        print("=====================================\n")


except KeyboardInterrupt:

    print("\nSession Stopped")

    summary = counter.summary()

    print("\n========== FINAL SUMMARY ==========")

    print(
        f"Om"
    )

    print(
        f"   Count    : {summary['Om']['count']}"
    )

    print(
        f"   Duration : {summary['Om']['duration']:.2f} sec\n"
    )

    print(
        f"Bhramari"
    )

    print(
        f"   Count    : {summary['Bhramari']['count']}"
    )

    print(
        f"   Duration : {summary['Bhramari']['duration']:.2f} sec"
    )

    print("===================================")