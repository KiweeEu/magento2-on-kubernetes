FROM cypress/browsers:node16.14.0-chrome99-ff97@sha256:2e1e118f02b148fe1281882b966c65e38901c5fd541c81916b4a1639bdff88d8

WORKDIR /e2e
COPY package.json /e2e/package.json
COPY package-lock.json /e2e/package-lock.json

RUN npm install

COPY . /e2e
