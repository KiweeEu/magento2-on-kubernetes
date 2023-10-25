FROM cypress/base:18.16.1@sha256:5e6533cbf1ccabce058edeb5532e0619e777283ed38119fc6de327925b3fb1e7

WORKDIR /e2e
COPY package.json /e2e/package.json
COPY package-lock.json /e2e/package-lock.json

RUN npm install

COPY . /e2e
