from datetime import datetime

from backend.database.database import (
    get_connection
)


class SessionRepository:

    def save_session(
        self,
        pranayama,
        duration,
        confidence
    ):

        conn = get_connection()

        cursor = conn.cursor()

        now = datetime.now()

        cursor.execute(

            """
            INSERT INTO session_history
            (
                date,
                time,
                pranayama,
                duration,
                confidence
            )
            VALUES
            (?, ?, ?, ?, ?)
            """,

            (

                now.strftime("%Y-%m-%d"),

                now.strftime("%H:%M:%S"),

                pranayama,

                duration,

                confidence

            )

        )

        conn.commit()

        conn.close()

    # -----------------------------------

    def get_all_sessions(self):

        conn = get_connection()

        cursor = conn.cursor()

        cursor.execute(

            """
            SELECT *
            FROM session_history
            ORDER BY id DESC
            """

        )

        rows = cursor.fetchall()

        conn.close()

        return rows

    # -----------------------------------

    def get_today_sessions(self):

        conn = get_connection()

        cursor = conn.cursor()

        today = datetime.now().strftime("%Y-%m-%d")

        cursor.execute(

            """
            SELECT *
            FROM session_history
            WHERE date = ?
            ORDER BY id DESC
            """,

            (today,)

        )

        rows = cursor.fetchall()

        conn.close()

        return rows

    # -----------------------------------

    def delete_history(self):

        conn = get_connection()

        cursor = conn.cursor()

        cursor.execute(

            """
            DELETE FROM session_history
            """

        )

        conn.commit()

        conn.close()

    # -----------------------------------

    def delete_sessions(self,session_ids):

        if not session_ids:
            return

        conn = get_connection()

        cursor = conn.cursor()

        placeholders = ",".join(
            "?" for _ in session_ids
        )

        cursor.execute(

            f"""
            DELETE FROM session_history
            WHERE id IN ({placeholders})
            """,
            session_ids
        )
        conn.commit()
        conn.close()
        

    def get_statistics(self):

        conn = get_connection()

        cursor = conn.cursor()

        cursor.execute("""

            SELECT

                pranayama,

                COUNT(*) AS total_count,

                ROUND(SUM(duration),2) AS total_duration,

                ROUND(AVG(duration),2) AS average_duration,

                ROUND(MAX(duration),2) AS longest_duration,

                ROUND(MIN(duration),2) AS shortest_duration,

                ROUND(AVG(confidence)*100,2) AS average_confidence

            FROM session_history

            GROUP BY pranayama

        """)

        rows = cursor.fetchall()

        conn.close()

        return rows
    
    # Latest Session
    def get_latest_session(self):

        conn = get_connection()

        cursor = conn.cursor()

        cursor.execute("""

            SELECT *

            FROM session_history

            ORDER BY id DESC

            LIMIT 1

        """)

        row = cursor.fetchone()

        conn.close()

        return row
    
    # Today's Session Count

    def get_today_summary(self):

        conn = get_connection()

        cursor = conn.cursor()

        today = datetime.now().strftime("%Y-%m-%d")

        cursor.execute("""

            SELECT

                COUNT(*) AS total,

                ROUND(SUM(duration),2) AS duration

            FROM session_history

            WHERE date=?

        """,(today,))

        row=cursor.fetchone()

        conn.close()

        return row