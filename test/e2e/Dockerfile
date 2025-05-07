FROM cypress/base:24.0.0@sha256:a12dd7ba6c42601ba02328491320f04fede8b652f6da27247897b9a6d413c2b9

RUN apt update \
    && apt install --no-install-recommends --yes \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /e2e
COPY package.json /e2e/package.json
COPY package-lock.json /e2e/package-lock.json

RUN npm install

COPY . /e2e
