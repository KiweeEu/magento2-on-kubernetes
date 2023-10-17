FROM cypress/base:18.15.0

WORKDIR /e2e
COPY package.json /e2e/package.json
COPY package-lock.json /e2e/package-lock.json

RUN npm install

COPY . /e2e
