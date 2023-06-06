import io.confluent.kafka.serializers.AbstractKafkaSchemaSerDeConfig;
import io.confluent.kafka.serializers.json.KafkaJsonSchemaSerializer;
import io.confluent.kafka.serializers.json.KafkaJsonSchemaSerializerConfig;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.Producer;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.common.header.Header;
import org.apache.kafka.common.header.internals.RecordHeader;

import java.nio.charset.StandardCharsets;
import java.util.Collections;
import java.util.Properties;

public class JsonSchemaProducer {
    public static void main(String[] args) {
        // Create the Properties class to instantiate the Producer with the required configuration.
        Properties props = new Properties();
        props.put("bootstrap.servers", "localhost:29092");
        props.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer");
        props.put("value.serializer", KafkaJsonSchemaSerializer.class);
        props.put(KafkaJsonSchemaSerializerConfig.SCHEMA_REGISTRY_URL_CONFIG, "http://localhost:8081");  // Replace with your Schema Registry URL
        props.put(AbstractKafkaSchemaSerDeConfig.AUTO_REGISTER_SCHEMAS, false);
        props.put(AbstractKafkaSchemaSerDeConfig.USE_LATEST_VERSION, true);

        // Create an instance of the Kafka producer.
        Producer<String, TestObject> producer = new KafkaProducer<String, TestObject>(props);

        // Define the data you want to send.
        String key = "{\"makey\": \"test-k-7\"}";
        TestObject recordValue=new TestObject("test-v-7");
        String topic = "test-elasticsearch-sink";
        Header header = new RecordHeader("monheader", "test-h-7".getBytes(StandardCharsets.UTF_8));

        // Create a ProducerRecord object from the data.
        ProducerRecord<String, TestObject> record = new ProducerRecord<String, TestObject>(topic, null,key, recordValue, Collections.singletonList(header));

        // Send the data to the specified topic.
        producer.send(record);

        // Close the producer to free resources.
        producer.close();
    }
}
