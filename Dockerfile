FROM node:lts-alpine as builder

WORKDIR /opt/app
RUN date > date.txt
RUN sleep 3
RUN date >> date.txt

FROM node:lts-alpine

WORKDIR /opt/app

RUN apk add --no-cache \
    udev \
    ttf-freefont \
    git \
    chromium

COPY --from=builder /opt/app/date.txt ./
RUN cat date.txt

ENTRYPOINT tail -f date.txt
