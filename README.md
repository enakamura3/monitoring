# Monitoring sample project

Project using Prometheus to monitoring Mongodb using Mongodb-Exporter

## Getting Started

Define $IP_ADDRESS

```sh
export IP_ADDRESS=YOUR_IP_HERE 
```

## mongodb

```sh
docker run --rm -d -e MONGO_INITDB_ROOT_USERNAME=mongoadmin -e MONGO_INITDB_ROOT_PASSWORD=secret -p 27017:27017 mongo
```

## mongodb-exporter

Clone the repo: https://github.com/percona/mongodb_exporter

Create a docker-export image (mongodb-exporter:master):

```sh
make docker
```

```sh
docker run --rm -d -e MONGODB_URI=mongodb://mongoadmin:secret@$IP_ADDRESS:27017 -p 9216:9216 mongodb-exporter:master
```

## prometheus

Build image:

```sh
# --build-arg is used to override ARG IP_ADDRESS 
docker build -t prom/test --build-arg IP_ADDRESS=$IP_ADDRESS .
```

To run:

```sh
docker run --rm -d --name prom-test -p 9090:9090 prom/test
```

Access:

> http://localhost:9090

## TODO

- Create a docker-composer file
