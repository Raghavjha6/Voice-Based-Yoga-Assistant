class SessionManager:

    def __init__(self):

        self.data = {

            "Om": {
                "count": 0,
                "duration": 0
            },

            "Bhramari": {
                "count": 0,
                "duration": 0
            }
        }

    def add_session(
        self,
        pranayama,
        duration
    ):

        self.data[
            pranayama
        ]["count"] += 1

        self.data[
            pranayama
        ]["duration"] += duration

        print(f"\nCompleted : {pranayama}")

        print(
            f"Duration : {duration:.2f} sec"
        )

    def get_summary(self):

        return self.data