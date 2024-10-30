FROM cypress/base:22.11.0@sha256:d8168b757f16fa9276f5319909dad171916d4163dbe440a1747f0eaad65f543e

RUN apt update \
    && apt install --no-install-recommends --yes \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /e2e
COPY package.json /e2e/package.json
COPY package-lock.json /e2e/package-lock.json

RUN npm install

COPY . /e2e
