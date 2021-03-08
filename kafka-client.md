### Install kafka in EC2

```
yum update -y
yum install java -y
wget https://archive.apache.org/dist/kafka/2.2.1/kafka_2.11-2.2.1.tgz
tar zxvf kafka_2.11-2.2.1.tgz 
cd kafka_2.11-2.2.1/bin
```


### Confirm Java is installed

```
java -version
```

### Useful Kafka commands

Create topic

```
./kafka-topics.sh --create --topic demo-topic --bootstrap-server [brokers] --partitions 10 --replication-factor 2
```

Send message to topic
```
./kafka-console-producer.sh --topic demo-topic --broker-list [brokers]
```

Consume message from topic

```
./kafka-console-consumer.sh --topic demo-topic --from-beginning --bootstrap-server [brokers]
```
