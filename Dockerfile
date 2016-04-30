FROM node:6.0-slim

ENV NPM_CONFIG_LOGLEVEL warn

WORKDIR /opt

COPY . .

RUN ["npm", "install"]

ENTRYPOINT ["npm"]

CMD ["run", "build"]
