# gRPC Goat

[gRPC Goat](https://github.com/rootxjs/grpc-goat) by rootxjs: a vulnerable-by-design playground
for gRPC security, nine labs with one flag each (server reflection, plaintext gRPC, insecure TLS,
arbitrary mTLS, mTLS subject validation, a world-writable Unix socket, SQL injection, command
injection, SSRF). This repository runs it with [Isoloom](https://www.isoloom.com):
[`isoloom.yml`](isoloom.yml) describes one machine per lab, each built by upstream's own
Dockerfile from the vendored source, with the final image pinned.

| Machine | Service |
| --- | --- |
| grpc-001 | Lab 001, reflection enabled: gRPC on 8001 |
| grpc-002 | Lab 002, plaintext gRPC: gRPC on 8002 |
| grpc-003 | Lab 003, insecure TLS: gRPC over TLS on 8003 |
| grpc-004 | Lab 004, arbitrary mTLS: gRPC over mTLS on 8004 |
| grpc-005 | Lab 005, mTLS subject validation: gRPC over mTLS on 8005 |
| grpc-006 | Lab 006, world-writable Unix socket: `/tmp/grpc-admin.sock` inside the machine |
| grpc-007 | Lab 007, SQL injection: gRPC on 8007 |
| grpc-008 | Lab 008, command injection: gRPC on 8008 |
| grpc-009 | Lab 009, SSRF: gRPC on 8009 |

Each port is published on the same number on localhost.

## Run it

```bash
isoloom generate
isoloom up docker
```

Then start with `grpcurl -plaintext localhost:8001 list`. The `.proto` files for labs 002 to 009
are in [`app/protos/`](app/protos). Lab 006 has no port: open a shell on its machine with
`isoloom connect grpc-006` (upstream mounts its `/tmp` on the host instead). The same spec runs
as Docker on a local VM (`docker-vm`), on a cloud VM (`cloud-docker`) or on Kubernetes. Lab
guide: the [gRPC Goat documentation](https://rootxjs.github.io/docs/grpc_goat_docs/getting-started/)
and each lab's `Readme.md` in `build/grpc-00N/app/`.

Upstream version and commit: [UPSTREAM.md](UPSTREAM.md).

## Licence

MIT, as gRPC Goat ([LICENSE](LICENSE)). These services are deliberately vulnerable: keep them
isolated.
