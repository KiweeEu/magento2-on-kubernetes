FROM cypress/base:22.14.0@sha256:b5ee6f4a54c2966a2d855693bd12a063b9fcf7159930e2c4d57ab138d36a8a51

RUN apt update \
    && apt install --no-install-recommends --yes \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /e2e
COPY package.json /e2e/package.json
COPY package-lock.json /e2e/package-lock.json

RUN npm install

COPY . /e2e
