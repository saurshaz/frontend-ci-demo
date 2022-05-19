# Need to remote into this image and debug some flow? 
# docker run -it --rm node:12.22.1-alpine3.12 /bin/ash
FROM node:lts-buster AS build
ARG ODBC_ENABLED=false
RUN apt-get update && apt-get install -y \
    python3 make g++ python3-dev  \
    && ( \
        if [ "$ODBC_ENABLED" = "true" ] ; \
        then \
         echo "Installing ODBC build dependencies." 1>&2 ;\
         apt-get install -y unixodbc-dev ;\
         npm install -g node-gyp ;\
        fi\
       ) \
    && rm -rf /var/lib/apt/lists/*
RUN npm config set python /usr/bin/python3

WORKDIR /frontend-app


COPY ./package* ./
COPY ./lerna* ./
COPY ./packages/cra/package* ./packages/cra/

# Install dependencies
RUN npm i
RUN npm i -g lerna
RUN lerna bootstrap
RUN lerna run build
RUN cp packages/cra/public/index.html packages/cra/build/
RUN npm i -g http-server

ENV NODE_ENV production
RUN http-server packages/cra/build -p 3002
EXPOSE 3002