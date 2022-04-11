FROM ruby:2.7.2

ARG WORKDIR
ENV HOME=/${WORKDIR}

RUN apt-get update -qq && apt-get install -y \
    nodejs \
    postgresql-client \
    vim
RUN mkdir ${WORKDIR}
WORKDIR ${HOME}
COPY Gemfile ${HOME}/Gemfile
COPY Gemfile.lock ${HOME}/Gemfile.lock
RUN bundle install

ADD . ./

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
