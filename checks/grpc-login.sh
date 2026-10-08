#!/bin/sh
# Lab 002 answers a real gRPC call: auth.AuthService/Login over plaintext HTTP/2 with a wrong
# password (a hand-encoded LoginRequest{username: "x", password: "y"}), and says why it failed.
set -e
body=$(mktemp) out=$(mktemp)
printf '\000\000\000\000\006\012\001x\022\001y' > "$body"
curl -sS --http2-prior-knowledge -H 'content-type: application/grpc' -H 'te: trailers' \
  --data-binary @"$body" -o "$out" http://grpc-002:8002/auth.AuthService/Login
grep -q "Invalid credentials" "$out"
