# sudo docker build -t pwn_chall .
# sudo docker run --privileged -d -p 3000:9999 pwn_chall:latest
# sudo docker stop $(docker ps -aq)
# sudo docker rm $(docker ps -aq)

FROM ubuntu:16.04

RUN apt-get update -y && apt-get install -y \
    lib32z1 xinetd vim xclip

RUN useradd -m ctf

WORKDIR /home/ctf

RUN cp -R /lib* /home/ctf && \
    cp -R /usr/lib* /home/ctf

RUN mkdir /home/ctf/dev && \
    mknod /home/ctf/dev/null c 1 3 && \
    mknod /home/ctf/dev/zero c 1 5 && \
    mknod /home/ctf/dev/random c 1 8 && \
    mknod /home/ctf/dev/urandom c 1 9 && \
    chmod 666 /home/ctf/dev/*

RUN mkdir /home/ctf/bin && \
    cp /bin/sh /home/ctf/bin && \
    cp /bin/ls /home/ctf/bin && \
    cp /bin/cat /home/ctf/bin

COPY ./ctf.xinetd /etc/xinetd.d/ctf
COPY ./start.sh /start.sh
COPY ./code /code
RUN echo "Blocked by ctf_xinetd" > /etc/banner_fail

RUN chmod +x /start.sh
RUN chown root:root /code
RUN chmod 755 /code
RUN chmod +s /code

COPY ./bin/ /home/ctf/
RUN chown -R root:ctf /home/ctf && \
    chmod -R 750 /home/ctf 

CMD ["/start.sh"]

EXPOSE 9999

# RUN git clone https://github.com/niklasb/libc-database
# RUN cd libc-database && ./get debian
