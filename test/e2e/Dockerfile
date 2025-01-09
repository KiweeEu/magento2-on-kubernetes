FROM cypress/base:22.13.0@sha256:38eef52043285bae30a0f0af103e0429c9714a671da3b67c30d35ced7460e50c

RUN apt update \
    && apt install --no-install-recommends --yes \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /e2e
COPY package.json /e2e/package.json
COPY package-lock.json /e2e/package-lock.json

RUN npm install

COPY . /e2e
