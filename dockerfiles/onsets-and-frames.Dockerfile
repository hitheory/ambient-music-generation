FROM tensorflow/tensorflow:2.2.0-gpu
RUN apt-get update \
    && apt-get install wget curl zip git -y
#   && apt-get install -y python3-pip python3-dev \
#   && cd /usr/local/bin \
#   && ln -s /usr/bin/python3 python \
#   && pip3 install --upgrade pip
# RUN apt-get install wget curl zip git -y

# RUN pip3 install tensorflow==2.2.0
RUN apt-get update && \
    apt-get install -y libfluidsynth1 \
    fluid-soundfont-gm build-essential libasound2-dev \
    libjack-dev ffmpeg sox
RUN pip3 install pyfluidsynth pretty_midi
RUN pip3 install -qU magenta
RUN apt autoremove -y
RUN apt-get install --fix-broken
RUN pip3 install librosa

WORKDIR /src

RUN mkdir -p /src/onsets-frames/maestro
RUN wget https://storage.googleapis.com/magentadata/models/onsets_frames_transcription/maestro_checkpoint.zip
RUN unzip maestro_checkpoint.zip -d /src/onsets-frames/maestro
RUN rm maestro_checkpoint.zip

RUN git clone https://github.com/thekevinscott/onsets-and-frames-transcription.git /src/transcription
