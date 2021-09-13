FROM python:3.9-alpine3.14 AS build

RUN apk update && apk add --virtual build-deps postgresql-dev gcc python3-dev musl-dev

RUN mkdir /install && pip3 install --prefix=/install Flask Psycopg2 ConfigParser

FROM python:3.9-alpine3.14
RUN apk add libpq
COPY --from=build /install /usr/local

COPY . /srv/app/
WORKDIR /srv/app/

CMD ["python3", "web.py"]
