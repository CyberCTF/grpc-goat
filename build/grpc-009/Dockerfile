# Upstream's Dockerfile (app/Dockerfile, from labs/grpc-009-*/ upstream) with two changes: the
# source is copied from app/server/, and the final stage is pinned to alpine:3.22 (upstream:
# alpine:latest).
FROM golang:1.23-alpine AS builder

# Set Go environment
ENV GOTOOLCHAIN=go1.23.4

# Install protoc and plugins
RUN apk add --no-cache protobuf-dev
RUN go version
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.31.0
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.3.0

WORKDIR /app
COPY app/server/ .

# Generate protobuf code
RUN protoc --go_out=. --go_opt=paths=source_relative \
    --go-grpc_out=. --go-grpc_opt=paths=source_relative \
    proto/image_preview.proto

# Build the application
RUN go mod tidy
RUN CGO_ENABLED=0 go build -o image-preview main.go

# Final stage
FROM alpine:3.22
RUN apk --no-cache add ca-certificates

WORKDIR /root/

COPY --from=builder /app/image-preview .

EXPOSE 8009

CMD ["./image-preview"]

