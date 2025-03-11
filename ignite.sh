#!/bin/bash

sudo chmod -R 777 $(pwd)/signal-data
sudo chmod -R 777 $HOME/file-storage
mkdir -p $(pwd)/signal-data
mkdir -p $HOME/file-storage/compacted/
docker rm -f monitoring-agent
docker run -d --name monitoring-agent \
  -p 4317:4317 \
  -p 4318:4318 \
  --user=1003 \
  -v $(pwd)/otel-collector-config.yaml:/etc/otel/config.yaml \
  -v $HOME/logs/apisix:/var/log/apisix \
  -v $(pwd)/signal-data:/tmp/signal-data:rw,z \
  -v $HOME/file-storage:/tmp/file-storage \
  otel/opentelemetry-collector-contrib:latest --config=/etc/otel/config.yaml