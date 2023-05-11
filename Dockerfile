FROM python:3.11.0

WORKDIR /app

COPY pyproject.toml poetry.lock ./

RUN apt-get update &&\
    apt-get -y install locales &&\
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8

RUN pip install --no-cache-dir poetry && \
    poetry config virtualenvs.create false && \
    poetry install

EXPOSE 8000

CMD ["poetry", "run", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]