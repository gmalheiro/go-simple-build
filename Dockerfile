ARG GO_VERSION=1.24

# Build stage
FROM golang:${GO_VERSION}-alpine as builder
WORKDIR /app
COPY . .
RUN go build -o builds/server cmd/http/server/main.go

# Run stage
FROM alpine:3.18
WORKDIR /app
COPY --from=builder /app/builds/server .
EXPOSE 8080
CMD ["./server"]

LABEL authors="gmalheiro"