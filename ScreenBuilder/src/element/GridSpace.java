package element;

/**
 *
 * @author Phil
 */
public class GridSpace {
    
    /**
     * what layer this sprite is on
     */
    public enum Layer {
        TOP,
        BOTTOM
    }
    
    Sprite topSprite;
    Sprite bottomSprite;

    public Sprite getTopSprite() {
        return topSprite;
    }

    public void setTopSprite(Sprite topSprite) {
        this.topSprite = topSprite;
    }

    public Sprite getBottomSprite() {
        return bottomSprite;
    }

    public void setBottomSprite(Sprite bottomSprite) {
        this.bottomSprite = bottomSprite;
    }
    
    public void setSprite(Layer layer, Sprite sprite)
    {
        if(layer==Layer.TOP)
        {
            this.setTopSprite(sprite);
        }
        else if (layer == Layer.BOTTOM)
        {
            this.setBottomSprite(sprite);
        }
        else
        {
            throw new IllegalArgumentException("Bad Layer");
        }
    }
    
    public Sprite getSprite(Layer layer)
    {
        if(layer==Layer.TOP)
        {
            return this.getTopSprite();
        }
        else if (layer == Layer.BOTTOM)
        {
            return this.getBottomSprite();
        }
        else
        {
            throw new IllegalArgumentException("Bad Layer");
        }
    }
}
