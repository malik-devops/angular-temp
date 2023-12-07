FROM node:14.16.0-buster as node
ARG ENVIRONMENT=dev
WORKDIR /usr/src/app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build:${ENVIRONMENT}

FROM nginx:1.24.0-alpine3.17
ARG GIT_COMMIT_ID
LABEL git_commit=$GIT_COMMIT_ID
WORKDIR /usr/src/app
COPY --from=node /usr/src/app/dist/cno-ui /usr/share/nginx/html
COPY ./nginx.conf  /etc/nginx/conf.d/default.template
COPY ./cmd.sh  /usr/src/app
RUN sed -e "s/\r//g" /usr/src/app/cmd.sh > /usr/src/app/cmd-unix.sh
RUN mv /usr/src/app/cmd-unix.sh /usr/src/app/cmd.sh
RUN chmod +x /usr/src/app/cmd.sh
CMD ["/bin/sh", "-c", "/usr/src/app/cmd.sh"]
