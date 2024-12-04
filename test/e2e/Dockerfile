FROM cypress/base:22.12.0@sha256:227d72382d53081dd326e79c5a51acd219f26400a72705d59e83b3208fcd65a3

RUN apt update \
    && apt install --no-install-recommends --yes \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /e2e
COPY package.json /e2e/package.json
COPY package-lock.json /e2e/package-lock.json

RUN npm install

COPY . /e2e
