from backend.database.session_repository import (
    SessionRepository
)

repo = SessionRepository()

repo.save_session(
    "Om",
    5.42,
    0.98
)

repo.save_session(
    "Bhramari",
    6.85,
    0.96
)

print("Saved Successfully\n")

print("History\n")

for row in repo.get_all_sessions():

    print(dict(row))

print("\nStatistics\n")

for row in repo.get_statistics():

    print(dict(row))