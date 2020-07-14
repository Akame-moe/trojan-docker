FROM alpine:latest

LABEL maintainer="everyone <love@freedom.com>" version="1.0" desp="gfw is evil"
# latest version info: https://api.github.com/repos/trojan-gfw/trojan/releases/latest
# tag(v1.16.0) = curl https://api.github.com/repos/trojan-gfw/trojan/releases/latest | grep tag_name | cut -d "\"" -f4
# version number(1.16.0) = echo $tag | cut -d "v" -f2
# RUN set -ex \
#     && apk --no-cache add --update tzdata ca-certificates curl tar \
#     && mkdir -p /tmp/trojan \
#     && mkdir -p /var/log/trojan/ \
#     && curl -L -H "Cache-Control: no-cache" -o /tmp/trojan/trojan.tar.xz "https://github.com/trojan-gfw/trojan/releases/download/v1.16.0/trojan-1.16.0-linux-amd64.tar.xz" \
#     && tar xvf /tmp/trojan/trojan.tar.xz -C /usr/bin/ \
#     && chmod +x '/usr/bin/trojan/trojan' \
#     && rm -rf /tmp/trojan

RUN apt install trojan

COPY trojan-server.json /etc/trojan/
ENV TZ=Asia/Shanghai
VOLUME [ "/var/log/trojan","/etc/trojan" ]
EXPOSE 443
ENTRYPOINT [ "/usr/bin/trojan/trojan" ]
CMD ["-c", "/etc/trojan/trojan-server.json", "-l", "/var/log/trojan/trojan.log"]


#build image.
#`docker build -t trojan .`

#create server side container.
#`docker create --name trojan-server -v /var/log/trojan/:/var/log/trojan/ -p 444:444 --restart always trojan -c /etc/trojan/trojan-server.json`

#start server
#`docker [start|stop] trojan-server`