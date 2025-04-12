# specify the node base image with your desired version node:<version>
FROM node:latest

RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app

WORKDIR /home/node/app

ENV USER=node

COPY --chown=${USER}:${USER} package*.json ./

USER "${USER}"

RUN npm install --save-exact --save-dev esbuild
#RUN npm --global config set user "${USER}" \
#    && npm --global --quiet --no-progress install \
#    && npm cache clean --force

COPY --chown=${USER}:${USER} . .
RUN npm run build

EXPOSE 8000
CMD [ "npm", "run", "start" ]
