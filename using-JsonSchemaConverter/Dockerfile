FROM confluentinc/cp-kafka-connect:latest
ENV CONNECT_PLUGIN_PATH: "/usr/share/java,/usr/share/confluent-hub-components"
RUN confluent-hub install --no-prompt jcustenborder/kafka-connect-transform-common:latest
RUN confluent-hub install --no-prompt confluentinc/kafka-connect-elasticsearch:14.0.6
RUN confluent-hub install --no-prompt confluentinc/kafka-connect-json-schema-converter:7.4.0