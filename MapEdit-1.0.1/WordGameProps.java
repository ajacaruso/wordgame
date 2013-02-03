/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Phil
 */
public class WordGameProps {
    public enum SpecialProps {
        NONE("None"),
        EXPLODING("Exploding")
        ;
        
        private SpecialProps(final String text) {
        this.text = text;
        }
        private final String text;
        @Override
        public String toString() {
            return text;
        }
        
          public static SpecialProps fromString(String text) {
            if (text != null) {
              for (SpecialProps p : SpecialProps.values()) {
                if (text.equalsIgnoreCase(p.text)) {
                  return p;
                }
              }
            }
            throw new IllegalArgumentException("No constant with text " + text + "found.");
          }
        
        public static final int size = SpecialProps.values().length;
    };
    
    boolean usable;
    SpecialProps special;

    public boolean isUsable() {
        return usable;
    }

    public void setUsable(boolean usable) {
        this.usable = usable;
    }

    public SpecialProps getSpecial() {
        return special;
    }

    public void setSpecial(SpecialProps special) {
        this.special = special;
    }
    
}
