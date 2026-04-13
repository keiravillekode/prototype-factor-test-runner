FROM debian:bookworm-slim AS builder

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash curl git g++ make wget ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN git clone https://github.com/factor/factor.git && \
    cd factor && \
    git checkout cd14ceed53f6f9a43bbd3aec3950d8beb5439ed8
WORKDIR /opt/factor
RUN ./build.sh update

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash jq coreutils libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /opt/factor /opt/factor
ENV PATH="/opt/factor:${PATH}"

WORKDIR /opt/test-runner
COPY . .
ENTRYPOINT ["/opt/test-runner/bin/run.sh"]
