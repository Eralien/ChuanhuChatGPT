FROM python:3.9 as builder
RUN apt-get update && apt-get install -y build-essential
COPY requirements.txt .
COPY llama_index-0.5.9.tar.gz .
RUN python3 -m pip install --user llama_index-0.5.9.tar.gz && python3 -m pip install --user -r requirements.txt -i https://mirrors.bfsu.edu.cn/pypi/web/simple

FROM python:3.9
MAINTAINER iskoldt
COPY --from=builder /root/.local /root/.local
ENV PATH=/root/.local/bin:$PATH
COPY . /app
WORKDIR /app
ENV dockerrun yes
CMD ["python3", "-u", "ChuanhuChatbot.py", "2>&1", "|", "tee", "/var/log/application.log"]
