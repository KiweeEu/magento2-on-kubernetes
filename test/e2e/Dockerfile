FROM cypress/base:20.9.0@sha256:49a74e7a4a31aab275403da62f78f3d85a8fd6abace28c417e32c9ecd4dded3b

WORKDIR /e2e
COPY package.json /e2e/package.json
COPY package-lock.json /e2e/package-lock.json

RUN npm install

COPY . /e2e
