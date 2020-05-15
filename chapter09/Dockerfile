FROM ubuntu

RUN apt-get update && apt-get install -y python-pip jq vim

RUN pip install anchorecli

ENV PATH="$HOME/.local/bin/:$PATH"

COPY ./demo.sh /demo.sh
