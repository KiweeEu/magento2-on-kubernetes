FROM cypress/base:22.15.0@sha256:dcca936f59362209da3d29acd9e01b299d3ab72bcf32a22c2949ba4210f9b92f

RUN apt update \
    && apt install --no-install-recommends --yes \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /e2e
COPY package.json /e2e/package.json
COPY package-lock.json /e2e/package-lock.json

RUN npm install

COPY . /e2e
