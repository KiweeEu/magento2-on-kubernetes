FROM cypress/base:20.10.0@sha256:ab02591843fde5f5669d5d98284a087ad3f10466d99554204a8334366ed817a0

WORKDIR /e2e
COPY package.json /e2e/package.json
COPY package-lock.json /e2e/package-lock.json

RUN npm install

COPY . /e2e
