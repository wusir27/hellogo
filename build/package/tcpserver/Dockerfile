FROM golang:alpine as builder
RUN apk --no-cache add make git

WORKDIR /opt/hellogo
COPY . .

RUN make clean && make build

# ---

FROM alpine:latest

WORKDIR /opt/hellogo

COPY build/package/tcpserver/entrypoint.sh /
COPY --from=builder /opt/hellogo/bin/ /opt/hellogo/bin/

RUN apk --no-cache add tini tzdata && \
        chmod +x /entrypoint.sh /opt/hellogo/bin/*
ENV PATH /opt/hellogo/bin:$PATH

#ENTRYPOINT ["/sbin/tini", "--", "ls"]
ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]