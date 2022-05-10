FROM alpine

RUN apk add \
    curl \
    docker-cli \
    ;

COPY --from=alpine/helm:3.8.2 /usr/bin/helm /usr/bin/helm

RUN curl -Lo ./kubectl https://dl.k8s.io/release/v1.21.10/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/bin/kubectl \
    ;

RUN curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.12.0/kind-linux-amd64 && \
    chmod +x ./kind && \
    mv ./kind /usr/bin/kind \
    ;
