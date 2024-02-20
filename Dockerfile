FROM cgr.dev/chainguard/go:latest AS builder
WORKDIR  /go/src/github.com/openshift/eventrouter
COPY *.go go.mod go.sum ./
COPY sinks ./sinks

RUN CGO_ENABLED=0 go build -mod=mod -o eventrouter
RUN chmod +x eventrouter

FROM cgr.dev/chainguard/static:latest
COPY --from=builder /go/src/github.com/openshift/eventrouter/eventrouter /eventrouter
CMD ["/eventrouter", "-v", "3", "-logtostderr"]
LABEL version=release-5.8
