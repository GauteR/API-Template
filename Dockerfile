FROM node:20-alpine as build
LABEL org.opencontainers.image.authors="rnngau@gmail.com"

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./
COPY yarn.lock ./

# Install dependencies
RUN yarn install --network-timeout 100000

# Bundle app source
COPY . .

# Only use the bundled app from build image
FROM node:20-alpine as serve
WORKDIR /usr/src/app
COPY --from=build /usr/src/app .
EXPOSE 443
EXPOSE 80
HEALTHCHECK --interval=30s --timeout=10s --start-period=1m CMD http_proxy="" https_proxy="" curl --fail http://${HOST-0.0.0.0}:${PORT:-443}/health || exit 1
CMD [ "node", "--trace-warnings", "src/app.js"]