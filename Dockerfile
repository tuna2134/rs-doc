FROM python:3.15 AS builder

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

RUN mkdocs build

FROM caddy

WORKDIR /srv

COPY --from=builder /app/site /srv

CMD ["caddy", "file-server", "--root", "/srv", "--listen", ":80"]