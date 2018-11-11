FROM golang as builder
COPY . /go/src/github.com/bruno-nascimento/docker-plugin-authz
WORKDIR /go/src/github.com/bruno-nascimento/docker-plugin-authz
RUN set -ex && go get ./... && go install --ldflags '-extldflags "-static"'

#CMD ["/go/bin/docker-plugin-authz"]
FROM alpine
RUN mkdir -p /run/docker/plugins
COPY --from=builder /go/bin/docker-plugin-authz .
CMD ["docker-plugin-authz"]