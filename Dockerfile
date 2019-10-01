FROM ubuntu:19.04 AS build
WORKDIR /root
RUN apt update && apt install wget -y
RUN wget http://mirror.novg.net/apache/hadoop/common/hadoop-3.1.2/hadoop-3.1.2.tar.gz
RUN wget http://mirror.novg.net/apache/spark/spark-2.4.4/spark-2.4.4-bin-hadoop2.7.tgz
RUN tar xf hadoop-3.1.2.tar.gz
RUN tar xf spark-2.4.4-bin-hadoop2.7.tgz

FROM openjdk:8

COPY --from=build /root/hadoop-3.1.2 /opt/hadoop/
COPY --from=build /root/spark-2.4.4-bin-hadoop2.7 /opt/spark/

ENV PATH /opt/spark/bin:/opt/hadoop/bin:${PATH}
ENV HADOOP_CONF_DIR /etc/hadoop