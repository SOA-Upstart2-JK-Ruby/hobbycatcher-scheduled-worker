FROM alpine:latest

RUN apk --no-cache add curl

COPY scheduler/scheduler.sh /usr/local/bin/scheduler.sh

CMD sh /usr/local/bin/scheduler.sh