import java.awt.Graphics.*;
import java.io.*;
import java.awt.*;
import java.util.*;

/**
 * Stores a set of tiles which can be requested by id number, or name
 **/




public class GraphicsBank {
  
  final static int DEFAULT_TILE_WIDTH = 40;
  final static int DEFAULT_TILE_HEIGHT = 40;
  
  final static String GB_VERSION = "1.0";
  final static String DELIM      = ",";
  final static char   COMMENT    = '#';
  final static int    ID         = 0;
  final static int    PATH       = 1;
  final static int    NAME       = 2;
  final static int    TYPE       = 3;
  final static int    USABLE     = 4;
  final static int    SPECIAL    = 5;
  final static int    EXTRA      = 6;
  
  
  private ArrayList tiles;
  private ArrayList sprites;
  
  
  private ArrayList changeListeners;
  File loadedFrom;
  File baseDirectory;
  private boolean isUnsaved;
  
  Dimension baseTileSize;
  
  
  public GraphicsBank() {
    tiles = new ArrayList();
    sprites = new ArrayList();
    changeListeners = new ArrayList();
    loadedFrom = null;
    
    baseTileSize = new Dimension(DEFAULT_TILE_WIDTH, DEFAULT_TILE_HEIGHT);
    
    isUnsaved = true;
  }
  
  public void addSprite(String anmFile) {
  	addSprite(new File(anmFile));
  }
  
  public void addSprite(File anmFile) {
  	
  	
  }
  
  
  public void loadTileset(String from) throws FileNotFoundException, IOException {
    loadTileset(new File(from));
  }
  
  /**
   * Load tileset from file.
   * This will combine the tilesets if one has already been loaded.
   * The most recently loaded tileset file becomes the "loadedFrom"
   * tileset.
   **/
  public void loadTileset(File from) throws FileNotFoundException, IOException {
    BufferedReader r;
    String         line;
    String         tokens[];
    int            id;
    int            lineCount;
    File           tileFile;
    
    
		if(tiles.size() > 0) {
			isUnsaved = true;
		} else {
			isUnsaved = false;
		}
    
    System.out.println(from);
    baseDirectory = from.getParentFile();
    this.loadedFrom = from;
    
    
    lineCount = 0;
    r = new BufferedReader(new FileReader(from));
    while(true) {
      line = r.readLine();
      lineCount++;
      
      //stop when no more lines
      if(line == null) break;
      line = line.trim();
      if(line.length() == 0 || line.charAt(0) == COMMENT) {
        continue; //skip comments and empty lines.
      }
      
      tokens = line.split(DELIM);
      if(tokens.length < 6) {
        System.err.println("Could not parse line "+lineCount+". :");
        System.err.println(line);
        System.err.println("(There are not enough tokens)");
        continue;
      }
      try {
        id = Integer.parseInt(tokens[ID].trim());
      } catch(Exception e) {
        System.err.println("Could not parse line "+lineCount+". :");
        System.err.println(line);
        System.err.println("(The tile id is not a valid number)");
        continue;
      }
      
      //get file for image
      tokens[PATH] = tokens[PATH].trim();
      tokens[NAME] = tokens[NAME].trim();
      tokens[TYPE] = tokens[TYPE].trim();
      
      //PGH added
      tokens[USABLE] = tokens[USABLE].trim();
      tokens[SPECIAL] = tokens[SPECIAL].trim();
      
      tileFile = new File(baseDirectory, tokens[PATH]);
      //System.out.println("load tile image: "+tileFile);
      if(!tileFile.exists()) {
        tileFile = new File(tokens[PATH]);
        if(tileFile.exists()) {
          System.err.println("WARNING: file "+tokens[PATH]+" not within the tilemaps working directory");
        } else {
          r.close();
          throw new FileNotFoundException("File "+tokens[PATH]+" referenced on line "+lineCount +" of "+from+" could not be found");
        }
      }
      
      //System.out.println("New tile: "+id+", name = "+tokens[NAME]);
      
      Tile t = null;
      
      //PGH added
      WordGameProps props = new WordGameProps();
      props.setUsable(Boolean.parseBoolean(tokens[USABLE]));
      props.setSpecial(WordGameProps.SpecialProps.fromString(tokens[SPECIAL]));
      
      if(tokens.length > EXTRA) {
        t = new Tile(id, tileFile.toString(), tokens[NAME].trim(), tokens[TYPE].trim(), props, tokens[EXTRA].trim());
      } else {      
        t = new Tile(id, tileFile.toString(), tokens[NAME], tokens[TYPE], props);
      }
      tiles.add(t);
    }
  } //end loadTileset
  
  
  /**
   * Save the tileset to the specified file.
   * Will overwrite file if it exists.
   **/
  void saveTileset(File to) throws IOException{
  	
    File base = to.getParentFile();
    PrintWriter w = new PrintWriter(new FileWriter(to));
    w.println("# Generated by version "+GB_VERSION+" of GraphicsBank");
    w.println("# Tile Number, Image file, Tile Name, Type, Is Usable, Special Type, Extended Info");
    System.out.println("Saving "+tiles.size()+" tiles.");
    Iterator i = tiles.iterator();
    while(i.hasNext()) {
      Tile t = (Tile)i.next();
      File tf = new File(t.getPath()).getCanonicalFile();
      String relPath = RelativePath.getRelativePath(new File(base.getCanonicalPath()), new File(tf.getCanonicalPath()));
      w.print(""+t.getNumber() + ", "+relPath + ", " + t.getName() + ", "+t.getType()+ ", "+t.getProps().isUsable()+ ", "+t.getProps().getSpecial().toString());
      if(t.getInfo() != null) {
        w.println(", "+t.getInfo());
      } else {
        w.println();
      }
    }
    w.close();
    baseDirectory = base;
    loadedFrom = to;
    isUnsaved = false;
  }
  
  /**
   * Get the tileset file this tileset was loaded from.
   * May return NULL if this is a new tileset that has never been saved.
   **/
  File getFile() {
    return loadedFrom;
  }
  
  /**
   * Get a tile by number
   **/
  Tile getTile(int number) {
    Iterator i = tiles.iterator();
    while(i.hasNext()) {
      Tile t = (Tile)i.next();
      if(t.number == number) {
        return t;
      }
    }
    return null;
  }
  
  /**
   * Get a tile by name. Case sensitive
   **/
  Tile getTile(String name) {
    Iterator i = tiles.iterator();
    while(i.hasNext()) {
      Tile t = (Tile)i.next();
      if(t.getName().equals(name)) {
        return t;
      }
    }
    return null;
  }
  
  /**
   * Rwemove a tile from the graphics bank. Any registered change listeners
   * will be notified.
   **/
  Tile remove(Tile t) {
  	Tile rm = null;
  	if(tiles.remove(t)) {
  		rm = t;
  	}
    if(t != null) {
    	fireRemoveEvent(t);
    	isUnsaved = true;
    }
  	return t;
  }
  
  /**
   * Add a tile to the graphics bank. Any registered change listeners
   * will be notified.
   **/
  void add(Tile t) {
  	/* TODO: validate the tile */
  	tiles.add(t);
    isUnsaved = true;
    fireAddEvent(t);
  }
  
  int size() {
  	return tiles.size();
  }
  
  Dimension getBaseTileSize() {
  	return baseTileSize;
  }
  
  /**
   * Iterator for tile objects
   **/
  Iterator iterator() {
    return tiles.iterator();
  }
  
  /**
   * Set a global colour adjustment effect for all tiles in the
   * graphics bank. This will override any individually set
   * effects on all tiles.
   **/
  public void setEffect(float r, float g, float b, float h, float s, float z)
  {
    Iterator i = tiles.iterator();
    while(i.hasNext()) {
      ((Tile)(i.next())).adjustRGBHS(r, g, b, h, s, z);
    }
  }
  
  /**
   * True if there have been any changes to the tileset since it
   * was last saved or loaded.
   **/
  public boolean isUnsaved() {
  	if(getFile() == null) {
  		return true;
  	}
    return isUnsaved;
  }
  
  /**
   * Get the directory that the tileset file describing this
   * tileset was found in.
   **/
  File getBaseDirectory() {
    return baseDirectory;
  }
  
  /**
   * Get an unused tile number. Returns one more than the
   * highest number used.
   **/
  int getUnusedNumber() {
  	int n = 1;
  	Iterator i = tiles.iterator();
    while(i.hasNext()) {
    	Tile t = (Tile)i.next();
    	if(n <= t.getNumber()) {
    		n = t.getNumber() + 1;
    	}
    }
    return n;
  }
  
  
  
  /**
   * Add a GraphicsBankChangeListener to the graphics bank.
   * This listener will be notified whenever the tileset
   * is changed.
   **/
  void addChangeListener(GraphicsBankChangeListener l) {
  	changeListeners.add(l);
  }
  /**
   * Remove a GraphicsBankChangeListener from the graphics bank.
   **/
  void removeChangeListener(GraphicsBankChangeListener l) {
  	changeListeners.remove(l);
  }
  
  /**
   * May be called directly, and will cause
   * the tilesetUpdated() method of every registered
   * GraphicsBankChangeListener object to be called.
   **/
  public void fireChangeEvent() {
  	GraphicsBankChangeListener l;
  	Iterator i = changeListeners.iterator();
  	while(i.hasNext()) {
  		l = (GraphicsBankChangeListener)i.next();
  		l.tilesetUpdated(this);
  	}
  }
  /**
   * Called whenever a tile is added using add(). will cause
   * the tileAdded() method of every registered
   * GraphicsBankChangeListener object to be called.
   **/
  private void fireAddEvent(Tile t) {
  	System.out.println("Fire add event");
  	GraphicsBankChangeListener l;
  	Iterator i = changeListeners.iterator();
  	while(i.hasNext()) {
  		l = (GraphicsBankChangeListener)i.next();
  		l.tileAdded(this, t);
  	}
  }
  /**
   * Called whenever a tile is removed using remove().
   * will cause the tileRemoved() method of every registered
   * GraphicsBankChangeListener object to be called.
   **/
  private void fireRemoveEvent(Tile t) {
  	GraphicsBankChangeListener l;
  	Iterator i = changeListeners.iterator();
  	while(i.hasNext()) {
  		l = (GraphicsBankChangeListener)i.next();
  		l.tileRemoved(this, t);
  	}
  }
}


interface GraphicsBankChangeListener {
	/* Large change happened such as loading a tileset */
  public void tilesetUpdated(GraphicsBank bank);
  /* A single tile was removed */
  public void tileRemoved(GraphicsBank bank, Tile removed);
  /* A single tile was added */
  public void tileAdded(GraphicsBank bank, Tile added);
}