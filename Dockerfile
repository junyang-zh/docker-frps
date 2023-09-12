FROM amd64/alpine:3.18

LABEL maintainer="junyang <user@junyang.me>"

ENV FRP_VERSION 0.51.3

RUN cd /root \
    && wget --no-check-certificate -c https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz \
    && tar zxvf frp_${FRP_VERSION}_linux_amd64.tar.gz  \
    && cd frp_${FRP_VERSION}_linux_amd64/ \
    && cp frps /usr/bin/ \
    && cd /root \
    && rm frp_${FRP_VERSION}_linux_amd64.tar.gz \
    && rm -rf frp_${FRP_VERSION}_linux_amd64/ \
    && mkdir -p /etc/frp

ARG BIND_PORT
ARG DASHBOARD_PORT
ARG DASHBOARD_USER
ARG DASHBOARD_PWD
ARG TOKEN

RUN echo "[common]" > /etc/frp/frps.ini \
    && echo "bind_port = ${BIND_PORT}" >> /etc/frp/frps.ini \
    && echo "dashboard_port = ${DASHBOARD_PORT}" >> /etc/frp/frps.ini \
    && echo "dashboard_user = ${DASHBOARD_USER}" >> /etc/frp/frps.ini \
    && echo "dashboard_pwd = ${DASHBOARD_PWD}" >> /etc/frp/frps.ini \
    && echo "token = ${TOKEN}" >> /etc/frp/frps.ini \
    && echo "enable_prometheus = true" >> /etc/frp/frps.ini

ENTRYPOINT /usr/bin/frps -c /etc/frp/frps.ini

