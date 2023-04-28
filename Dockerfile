FROM ruby:3.0.6-alpine

RUN apk update \
&& apk upgrade \
&& apk add --update --no-cache build-base curl-dev nodejs

COPY . /usr/src/app/

WORKDIR /usr/src/app

RUN bundle 

CMD ["rails", "s", "-b", "0.0.0.0"]
