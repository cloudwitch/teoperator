FROM ubuntu:rolling as builder

RUN apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
    golang-go \
    git \
    imagemagick \
    python3-pip \
    ffmpeg \
    software-properties-common \
    &&\
    add-apt-repository -y ppa:chris-needham/ppa &&\
    apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get -y install audiowaveform &&\
    python3 -m pip install youtube-dl

RUN git clone https://github.com/schollz/teoperator.git &&\
    cd teoperator &&\
    go build

WORKDIR /teoperator

ENTRYPOINT [ "./teoperator", "--serve", "--debug" ]
