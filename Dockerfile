FROM python:3.9 as builder
COPY bfsu-sources.list /etc/apt/sources.list
RUN apt-get update && apt-get install -y build-essential
COPY requirements.txt .
COPY requirements_advanced.txt .
RUN python3 -m pip install --user -r requirements.txt -i https://mirrors.bfsu.edu.cn/pypi/web/simple
# RUN pip install --user -r requirements_advanced.txt

FROM python:3.9
MAINTAINER iskoldt
COPY --from=builder /root/.local /root/.local
ENV PATH=/root/.local/bin:$PATH
COPY . /app
WORKDIR /app
ENV dockerrun yes
CMD ["python3", "-u", "ChuanhuChatbot.py", "2>&1", "|", "tee", "/var/log/application.log"]
