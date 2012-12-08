package element;

import java.util.Map;

/**
 *
 * @author Phil
 */
public class Sprite {
    String image;
    Map<String, String> properties;

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Map<String, String> getProperties() {
        return properties;
    }

    public void setProperties(Map<String, String> properties) {
        this.properties = properties;
    }

    public String toJSON()
    {
        StringBuilder toReturn =  new StringBuilder();
        
        return toReturn.toString();
    }
}
