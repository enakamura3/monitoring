FROM ubuntu as builder
# default IP_ADDRESS value 
ARG IP_ADDRESS=localhost:9090
ENV MONGODB_ADDRESS=$IP_ADDRESS:9216
RUN apt update && apt install gettext-base -y
RUN mkdir /tmp/builder
WORKDIR /tmp/builder
COPY ./prometheus.yaml prometheus.yaml
RUN envsubst < prometheus.yaml > prometheus.yml
RUN cat prometheus.yml

FROM prom/prometheus
# original dockerfile already expose the port 9090 - https://hub.docker.com/layers/prom/prometheus/latest/images/sha256-e13550c4680834dbbc84d8bc2661e6b9dc10ee184ed8c846a2092e1929c2de8e?context=explore
#EXPOSE 9090
COPY --from=builder /tmp/builder/prometheus.yml /etc/prometheus/prometheus.yml
