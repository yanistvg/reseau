# sudo docker build -t pwn_chall .
# sudo docker run -d -p 3000:9999 pwn_chall:latest
# sudo docker stop $(docker ps -aq)
# FROM ubuntu:16.04
FROM ubuntu:22.04

RUN apt-get update -y && apt-get install -y \
    lib32z1 \
    xinetd \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m ctf

WORKDIR /ctf

RUN echo "Connection blocked" > /etc/banner_fail
COPY ctf.xinetd /etc/xinetd.d/ctf
COPY start.sh .
COPY . .

RUN chmod -R 755 /ctf

ENTRYPOINT []
CMD ["./start.sh"]

EXPOSE 9999

# RUN git clone https://github.com/niklasb/libc-database
# RUN cd libc-database && ./get debian