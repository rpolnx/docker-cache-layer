# Builder image
FROM node:17.1.0-buster-slim as builder

WORKDIR /usr/app

COPY package* .
COPY yarn* .

RUN yarn install --frozen-lockfile --inline-builds
RUN yarn install --frozen-lockfile --production --inline-builds --modules-folder node-modules-production
COPY . .
RUN yarn prebuild && yarn build


# Final image
FROM node:17.1.0-buster-slim as final

ARG USER=master
ARG GROUP=master

ENV APP_ROOT=/usr/app

WORKDIR $APP_ROOT

RUN apt update && apt install build-essential ca-certificates -y

RUN groupadd -g 1001 $GROUP && \
    adduser --system --no-create-home --uid 1001 --ingroup $GROUP --disabled-password $USER && \
    chown 1001:1001 $APP_ROOT

USER $USER

COPY --chown=1001:1001 --from=builder /usr/app/node-modules-production ./node-modules
COPY --chown=1001:1001 package.json .
COPY --chown=1001:1001 --from=builder /usr/app/dist ./dist

CMD [ "npm", "run", "start:prod" ]