# Upstream

| | |
| --- | --- |
| Project | gRPC Goat |
| Repository | https://github.com/rootxjs/grpc-goat |
| Version | main (no releases) |
| Commit | 4aefc57e9df44d75fb92c0f8a2537b54213c51b7 |
| Licence | MIT |

That commit is vendored unchanged, without its Git history, split so each lab's folder can be
its machine's Docker build context (an Isoloom build is one folder holding its `Dockerfile`):

| Upstream path | Here |
| --- | --- |
| `labs/grpc-001-reflection-enabled/` | `build/grpc-001/app/` |
| `labs/grpc-002-plaintext-grpc/` | `build/grpc-002/app/` |
| `labs/grpc-003-insecure-tls/` | `build/grpc-003/app/` |
| `labs/grpc-004-arbitary-mtls/` | `build/grpc-004/app/` |
| `labs/grpc-005-arbitary-mtls-withsubject/` | `build/grpc-005/app/` |
| `labs/grpc-006-pipe-world-read-write/` | `build/grpc-006/app/` |
| `labs/grpc-007-sql-injection/` | `build/grpc-007/app/` |
| `labs/grpc-008-grpc-command-injection/` | `build/grpc-008/app/` |
| `labs/grpc-009-ssrf/` | `build/grpc-009/app/` |
| everything else (README, docs, protos, docker-compose.yaml) | `app/` |

Each `build/grpc-00N/Dockerfile` is that lab's upstream Dockerfile with the source copied from
`app/server/` and the final stage pinned to `alpine:3.22` (upstream: `alpine:latest`); the
builder stage is upstream's (`golang:1.23-alpine`, toolchain go1.23.4, protoc plugins pinned, the
dependencies pinned by each lab's `go.mod`). Upstream's compose file mounts lab 006's `/tmp` on
the host; here the socket stays inside its machine. To update, replace the folders with a newer
commit as mapped above, then change this table.
