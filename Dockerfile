FROM golang:1.11-alpine3.8 AS builder

RUN apk add --no-cache make curl git \
    && curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
WORKDIR /go/src/app
COPY . .
RUN make ensure && make build


FROM alpine:3.8

COPY --from=builder /go/src/app/app /usr/local/bin/clair-scanner
EXPOSE 9279
ENTRYPOINT ["/usr/local/bin/clair-scanner"]
