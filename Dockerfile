FROM docker.io/library/golang:1.16
ENV CGO_ENABLED=0 GOARCH=amd64
ADD ./ /app
WORKDIR /app
RUN go build -tags netgo -o /build/adapter github.com/kubernetes-sigs/prometheus-adapter/cmd/adapter

FROM docker.io/library/busybox:1.33.1
COPY --from=0 /build/adapter /
ENTRYPOINT ["/adapter"]
