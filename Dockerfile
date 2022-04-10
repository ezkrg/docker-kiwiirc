FROM node:lts-alpine AS builder

ARG VERSION

RUN apk add --update --no-cache git python3 make g++ \
 && cd /tmp \
 && git clone -n https://github.com/kiwiirc/kiwiirc.git \
 && cd kiwiirc \
 && git checkout ${VERSION} \
 && yarn install \
 && yarn run build

 # ---

FROM nginx:stable-alpine AS kiwiirc

COPY --from=builder /tmp/kiwiirc/dist/ /usr/share/nginx/html/ 