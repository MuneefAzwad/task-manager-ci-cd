FROM python:3.9-slim

WORKDIR /app


RUN apt-get update && \
    apt-get install -y git python3-pip && \
    rm -rf /var/lib/apt/lists/*

#
COPY . /app


RUN chmod +x /app/scripts/entrypoint.sh


ENV PYTHONPATH=/app/scripts:$PYTHONPATH

ENTRYPOINT ["/app/scripts/entrypoint.sh"]
