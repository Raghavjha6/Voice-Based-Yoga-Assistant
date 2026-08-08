import queue
import wave
import numpy as np
import sounddevice as sd
import webrtcvad


class VADRecorder:

    def __init__(self):

        self.sample_rate = 16000          # Required for WebRTC
        self.frame_duration = 30          # milliseconds
        self.channels = 1

        self.frame_size = int(
            self.sample_rate *
            self.frame_duration / 1000
        )

        self.vad = webrtcvad.Vad(2)       # 0–3 (3 = most aggressive)

        self.audio_queue = queue.Queue()

    def callback(self, indata, frames, time, status):

        if status:
            print(status)

        self.audio_queue.put(indata.copy())

    def listen(self):

        print("\nListening...")

        recording = False

        silence_frames = 0

        voiced_frames = []

        with sd.InputStream(
            samplerate=self.sample_rate,
            channels=self.channels,
            dtype='int16',
            blocksize=self.frame_size,
            callback=self.callback
        ):

            while True:

                frame = self.audio_queue.get()

                pcm = frame.tobytes()

                speech = self.vad.is_speech(
                    pcm,
                    self.sample_rate
                )

                if speech:

                    if not recording:

                        print("Voice Detected")

                        recording = True

                    voiced_frames.append(frame)

                    silence_frames = 0

                elif recording:

                    voiced_frames.append(frame)

                    silence_frames += 1

                    # ~0.9 second silence
                    if silence_frames >= 30:

                        break

        audio = np.concatenate(voiced_frames)

        filename = "temp.wav"

        with wave.open(filename, "wb") as wf:

            wf.setnchannels(1)

            wf.setsampwidth(2)

            wf.setframerate(self.sample_rate)

            wf.writeframes(audio.tobytes())

        duration = len(audio) / self.sample_rate

        print("Recording Saved")
        print(f"Duration : {duration:.2f} sec")

        return filename, duration