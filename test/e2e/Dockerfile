FROM cypress/base:22.13.1@sha256:29998b50be0644359f54d011770de743aab75ec35f8568f353b7f53ae17ad3d5

RUN apt update \
    && apt install --no-install-recommends --yes \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /e2e
COPY package.json /e2e/package.json
COPY package-lock.json /e2e/package-lock.json

RUN npm install

COPY . /e2e
