FROM trenpixster/elixir:latest

RUN apt-get upgrade && apt-get update && apt-get install -qy \
	nodejs \
	libwww-perl \
	python2.7 \
	postgresql-client \
	sqlite3 \
	python-pip \
	--no-install-recommends && rm -rf /var/lib/apt/lists/*

ENV VERSION 0.0.1
ENV MIX_HOST 8000
EXPOSE $MIX_HOST

RUN mkdir /phoenixapp
WORKDIR /phoenixapp

COPY ./mix.exs /phoenixapp/mix.exs
COPY ./mix.lock /phoenixapp/mix.lock

RUN yes | mix deps.get
RUN pip install --upgrade requests

COPY ./ /phoenixapp

RUN mix local.hex --force
RUN mix deps.get
RUN mix compile

CMD ["/bin/bash", "start_service.sh", "admin-gateway.pow.tf"]
