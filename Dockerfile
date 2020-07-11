FROM python:3.8-alpine
ENV PYTHONUNBUFFERED 1
RUN apk update \
    && apk add --virtual build-deps gcc musl-dev \
    && apk add --no-cache mariadb-dev
RUN mkdir /app
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
RUN apk del build-deps
COPY . .
EXPOSE 8000
ENTRYPOINT ["python", "manage.py"]
CMD ["runserver", "0:8000"]