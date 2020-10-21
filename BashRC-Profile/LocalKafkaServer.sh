function startKafka() {
	originalDirectory=$PWD
	cd /home/$USER/Application/kafka

	if [ -f ".kafka-pid" ]; then
		echo "Server was already started! Please run stop server and start again!"
		return 1
	fi

	nohup bin/zookeeper-server-start.sh config/zookeeper.properties &> zookeeper-startup.log &
	echo $! > .kafka-pid
	nohup bin/kafka-server-start.sh config/server.properties &> kafka-server-startup.log &
	echo $! >> .kafka-pid
	echo "Zookeeper and Kafka as started on localhost:9092"
	cd ${orignalDirectory}
	return 0
}


function stopKafka() {
	originalDirectory=$PWD
	cd /home/$USER/Application/kafka
	bin/kafka-server-stop.sh &> kafka-server-startup.log 
	bin/zookeeper-server-stop.sh &> zookeeper-startup.log 
	rm -f .kafka-pid
	echo "Stopped Zookeeper and Kafka Server"
	return 0
}
