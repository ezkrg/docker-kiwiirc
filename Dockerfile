FROM node:lts-alpine AS builder

COPY kiwiirc /tmp/kiwiirc

RUN cd /tmp/kiwiirc \
 && yarn install \
 && yarn run build

 # ---

FROM nginx:stable-alpine AS kiwiirc

COPY --from=builder /tmp/kiwiirc/dist/ /usr/share/nginx/html/ 