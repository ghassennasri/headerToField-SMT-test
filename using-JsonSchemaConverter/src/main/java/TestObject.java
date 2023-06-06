import com.fasterxml.jackson.annotation.JsonProperty;

public class TestObject {
    @JsonProperty
    public String mavalue;

    public TestObject(String mavalue) {
        this.mavalue = mavalue;
    }
}
