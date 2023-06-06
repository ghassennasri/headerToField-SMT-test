if $(docker-compose ps | grep -q "broker"); then
    echo "Restarting docker-compose"
    docker-compose down
    docker-compose up -d --build
fi
docker-compose up -d --build
echo "Waiting for Kafka Connect to start listening on localhost ⏳"
while : ; do
  curl_status=$(curl -s -o /dev/null -w %{http_code} http://localhost:8083/connectors)
  echo -e $(date) " Kafka Connect listener HTTP state: " $curl_status " (waiting for 200)"
  if [ $curl_status -eq 200 ] ; then
    break
  fi
  sleep 5
done
# "value.converter.schemas.enable" need to be set to "true" otherwise records
# will be considered schema-less and fields will be mapped by connect into a HashMap
# SMT headerToField does only support STRUCT schemas
# refer to https://github.com/jcustenborder/connect-utils/blob/0db1df260fd7c17a314c19269a2327cff0bc6c2a/connect-utils/src/main/java/com/github/jcustenborder/kafka/connect/utils/transformation/BaseKeyValueTransformation.java#L112
# and https://github.com/jcustenborder/kafka-connect-transform-common/blob/master/src/main/java/com/github/jcustenborder/kafka/connect/transform/common/HeaderToField.java#L105
curl -X POST -H "Content-Type: application/vnd.schemaregistry.v1+json" \
    --data '{
    "schema": " {\"$schema\":\"http:\/\/json-schema.org\/draft-07\/schema#\",\"title\":\"Test Object\",\"type\":\"object\",\"additionalProperties\":false,\"properties\":{\"mavalue\":{\"oneOf\":[{\"type\":\"null\",\"title\":\"Not included\"},{\"type\":\"string\"}]}}}",
    "schemaType":"JSON"
 }' \
http://localhost:8081/subjects/test-elasticsearch-sink-value/versions




echo -e "\n--\n+> Creating Data Generator source"
 curl -X PUT \
          -H "Content-Type: application/json" \
          --data '{
               "connector.class": "io.confluent.connect.elasticsearch.ElasticsearchSinkConnector",
               "tasks.max": "1",
               "topics": "test-elasticsearch-sink",
               "key.ignore": "true",
               "connection.url": "http://elasticsearch:9200",
               "value.converter": "io.confluent.connect.json.JsonSchemaConverter",
               "value.converter.schema.registry.url": "http://schema-registry:8081",
               "value.converter.schemas.enable": "false",
               "transforms": "headerToField",
               "transforms.headerToField.type" : "com.github.jcustenborder.kafka.connect.transform.common.HeaderToField$Value",
               "transforms.headerToField.header.mappings" : "monheader:STRING"
               }' \
          http://localhost:8083/connectors/elasticsearch-sink/config | jq .

echo "Sending messages to topic test-elasticsearch-sink"
#./gradlew jar
java -jar ./build/libs/headerToField-1.0-SNAPSHOT.jar
#echo "{\"mavalue\": \"test-v-7\"}" | docker exec -i kcat kcat -b broker:9092 -t test-elasticsearch-sink -P -H "monheader=test-h-7" -k "{\"makey\": \"test-k-7\"}"


sleep 10

echo  "Check that the data is available in Elasticsearch"
curl -X GET 'http://localhost:9200/test-elasticsearch-sink/_search?pretty' > /tmp/result.log  2>&1
cat /tmp/result.log
grep "monheader" /tmp/result.log | grep "test-h-7"
grep "mavalue" /tmp/result.log | grep "test-k-7"