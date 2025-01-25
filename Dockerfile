FROM debian:bookworm

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    build-essential python3-dev python3-venv python3-pip libsqlcipher-dev \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /adhesive
WORKDIR /adhesive/
RUN python3 -m venv venv

ADD requirements.txt /adhesive/
RUN . venv/bin/activate && pip install -r requirements.txt

COPY adhesive/ \
    config.example.toml \
    schema.sql \
    /adhesive/

CMD ["/bin/bash"]
