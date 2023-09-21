FROM alpine

RUN apk add \
    curl \
    docker-cli \
    ;

COPY --from=alpine/helm:3.12.3@sha256:64d217dbc9d6734c1a37ae0927e3f33177c2292b9a7370b88a2c89bdb41405cb /usr/bin/helm /usr/bin/helm

RUN curl -Lo ./kubectl https://dl.k8s.io/release/v1.21.10/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/bin/kubectl \
    ;

RUN curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.14.0/kind-linux-amd64 && \
    chmod +x ./kind && \
    mv ./kind /usr/bin/kind \
    ;

RUN curl -Lo ./skaffold https://storage.googleapis.com/skaffold/builds/latest/skaffold-linux-amd64 && \
    chmod +x ./skaffold && \
    mv ./skaffold /usr/bin/skaffold \
    ;

RUN curl -L https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv4.5.4/kustomize_v4.5.4_linux_amd64.tar.gz | tar -xz && \
    chmod +x ./kustomize && \
    mv ./kustomize /usr/bin/kustomize \
    ;
