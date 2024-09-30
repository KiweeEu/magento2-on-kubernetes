FROM cypress/base:22.7.0@sha256:b8405939d0ae47caf4fe5f1c7fb8e2edd234e96e1e96a0a8c2c22f7a3035969e

RUN apt update \
    && apt install --no-install-recommends --yes \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /e2e
COPY package.json /e2e/package.json
COPY package-lock.json /e2e/package-lock.json

RUN npm install

COPY . /e2e
