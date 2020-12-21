FROM ruby:2.7.2 
RUN apt-get update -qq
RUN apt-get install -y build-essential libpq-dev
COPY ./package.json /home/app/package.json
RUN apt-get update
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash \
 && apt-get update && apt-get install -y nodejs && rm -rf /var/lib/apt/lists/* \
 && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
 && apt-get update && apt-get install -y yarn npm && rm -rf /var/lib/apt/lists/*
RUN npm install


WORKDIR /app
#RUN bundle config --global frozen 1
COPY Gemfile ./
RUN bundle install

COPY . .

