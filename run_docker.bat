@echo off

docker stop chatgpt & docker rm chatgpt & docker build -t chuanhuchatgpt:latest .

docker run -d --name chatgpt ^
	-v %cd%/history:/app/history ^
    -p 7860:7860 ^
    --restart unless-stopped ^
	chuanhuchatgpt:latest