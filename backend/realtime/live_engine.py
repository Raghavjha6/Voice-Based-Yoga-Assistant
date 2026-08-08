from backend.realtime.live_predictor import predict_audio_file


class LiveEngine:

    def __init__(self):

        self.reset()

    def reset(self):

        self.om_count = 0
        self.om_duration = 0.0

        self.bhramari_count = 0
        self.bhramari_duration = 0.0

    def process(self, audio_file):

        prediction, confidence, duration = predict_audio_file(audio_file)

        if prediction is None:

            return {
                "success": False,
                "message": "Silence"
            }

        if confidence < 0.70:

            return {
                "success": False,
                "message": "Low Confidence"
            }

        if prediction == "Om":

            self.om_count += 1
            self.om_duration += duration

        elif prediction == "Bhramari":

            self.bhramari_count += 1
            self.bhramari_duration += duration

        return {

            "success": True,

            "prediction": prediction,

            "confidence": confidence,

            "duration": duration,

            "summary": {

                "Om": {

                    "count": self.om_count,
                    "duration": round(self.om_duration, 2)
                },

                "Bhramari": {

                    "count": self.bhramari_count,
                    "duration": round(self.bhramari_duration, 2)
                }
            }
        }