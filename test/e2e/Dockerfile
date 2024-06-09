FROM cypress/base:20.14.0@sha256:025c8297893ba33a92619ab7849a3b03fbacbc7c0d4fef1c46f9c6dcfa7649e1

WORKDIR /e2e
COPY package.json /e2e/package.json
COPY package-lock.json /e2e/package-lock.json

RUN npm install

COPY . /e2e
