from backend.realtime.session_manager import (
    SessionManager
)


class PranayamaCounter:

    def __init__(self):

        self.manager = SessionManager()

    def update(
        self,
        prediction,
        duration=0.0
    ):

        # Ignore silence
        if prediction is None:
            return

        self.manager.add_session(
            prediction,
            duration
        )

    def summary(self):

        return self.manager.get_summary()