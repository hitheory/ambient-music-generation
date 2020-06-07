FROM python:3.7.7-stretch
# RUN apt-get install wget curl zip -y

RUN pip3 install tensorflow==1.15
RUN apt-get update -qq && apt-get install -qq libfluidsynth1 fluid-soundfont-gm build-essential libasound2-dev libjack-dev ffmpeg 
RUN pip3 install pyfluidsynth pretty_midi
RUN pip3 install -qU magenta
RUN apt autoremove -y
RUN apt-get install --fix-broken
RUN pip3 install librosa==0.6.2

######### Jupyter #########
RUN mkdir /notebooks && chmod a+rwx /notebooks

RUN mkdir -p /notebooks/onsets-frames
RUN mkdir /notebooks/onsets-frames/maestro
RUN wget https://storage.googleapis.com/magentadata/models/onsets_frames_transcription/maestro_checkpoint.zip
RUN unzip maestro_checkpoint.zip -d /notebooks/onsets-frames/maestro
RUN rm maestro_checkpoint.zip


RUN mkdir /logs && chmod 777 /logs
RUN mkdir /.local && chmod a+rwx /.local
WORKDIR /notebooks
EXPOSE 8888

# COPY src /notebooks/src
ADD https://api.github.com/repos/thekevinscott/onsets-and-frames-transcription/git/refs/heads/master /version.json
RUN git clone https://github.com/thekevinscott/onsets-and-frames-transcription.git /src/transcription
RUN rm /version.json


CMD ["python3", "/src/transcription/transcribe.py"]
