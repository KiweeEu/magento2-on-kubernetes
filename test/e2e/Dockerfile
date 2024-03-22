FROM cypress/base:20.11.1@sha256:434f95b9acb10c41957554f1cac868a6a006d65cceb77e1f02c75f41f616d69a

WORKDIR /e2e
COPY package.json /e2e/package.json
COPY package-lock.json /e2e/package-lock.json

RUN npm install

COPY . /e2e
