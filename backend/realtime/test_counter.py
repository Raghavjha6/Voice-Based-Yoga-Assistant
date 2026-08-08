import time

from backend.realtime.pranayama_counter import (
    PranayamaCounter
)

counter = PranayamaCounter()

# Om 1
counter.update("Om")
time.sleep(2)

counter.update(None)
counter.update(None)

# Om 2
counter.update("Om")
time.sleep(2)

counter.update(None)
counter.update(None)

# Om 3
counter.update("Om")
time.sleep(2)

counter.update(None)
counter.update(None)

# Bhramari 1
counter.update("Bhramari")
time.sleep(3)

counter.update(None)
counter.update(None)

# Bhramari 2
counter.update("Bhramari")
time.sleep(4)

counter.update(None)
counter.update(None)

print("\nSummary\n")
print(counter.summary())
# import time

# from backend.realtime.pranayama_counter import (
#     PranayamaCounter
# )

# counter = PranayamaCounter()


# # Om starts

# counter.update("Om")

# time.sleep(3)

# counter.update("Om")

# time.sleep(2)

# counter.update("Om")


# # Silence

# counter.update(None)

# counter.update(None)

# counter.update(None)


# # Bhramari starts

# counter.update("Bhramari")

# time.sleep(4)

# counter.update("Bhramari")


# # Silence

# counter.update(None)

# counter.update(None)

# counter.update(None)


# print("\nSummary\n")

# print(
#     counter.summary()
# )