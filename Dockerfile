FROM node:12.14.1 as node
FROM ruby:2.6.3

# Install app dependencies (package.json and package-lock.json)
#COPY package*.json ./
ENV NODEJS_VERSION 12.14.1

RUN apt-get update && apt-get upgrade -y 
RUN apt-get install -y nodejs npm && npm install n -g && n 12.14.1 \
    npm \
    vim

COPY package*.json ./

RUN npm install

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y yarn

COPY yarn.lock ./

RUN yarn install



RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
ENV BUNDLER_VERSION 2.2.16
RUN gem install bundler -v $BUNDLER_VERSION
RUN bundle install
ADD . /app
RUN mkdir -p tmp/sockets

