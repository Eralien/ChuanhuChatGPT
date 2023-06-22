#!/bin/bash

docker stop chatgpt && docker rm chatgpt && docker build -t chuanhuchatgpt:latest .

docker run -d --name chatgpt \
	-v `pwd`/history:/app/history \
    --add-host=host.docker.internal:host-gateway \
    -p 7860:7860 \
    --restart unless-stopped \
	chuanhuchatgpt:latest
