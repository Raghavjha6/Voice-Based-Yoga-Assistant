import numpy as np


class AudioBuffer:

    def __init__(self):

        self.frames = []

    def add(self, frame):

        self.frames.append(frame.copy())

    def clear(self):

        self.frames = []

    def get_audio(self):

        if len(self.frames) == 0:

            return np.array([])

        return np.concatenate(self.frames)