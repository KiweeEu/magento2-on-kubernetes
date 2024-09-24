FROM cypress/base:20.17.0@sha256:70f9c3c60529ea5f98c472d5bbc40c470fd116830788c8a1bc246e9502a4d86e

RUN apt update \
    && apt install --no-install-recommends --yes \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /e2e
COPY package.json /e2e/package.json
COPY package-lock.json /e2e/package-lock.json

RUN npm install

COPY . /e2e
