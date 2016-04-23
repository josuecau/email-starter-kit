FROM node:5.11

ENV NPM_CONFIG_LOGLEVEL warn

WORKDIR /opt

COPY . .

RUN ["npm", "install"]

ENTRYPOINT ["npm"]

CMD ["run", "build"]
