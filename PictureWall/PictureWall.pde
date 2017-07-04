String[] folders = { "cat", "snake", "owl","duck"};
String[][] filenames = new String[folders.length][];
import de.looksgood.ani.*;
int tileSize;
Image holder;
float currTime = 0;
float timeOut = 0;
int lapse = 5000;
ArrayList<Image> image = new ArrayList<Image>();
void setup() {
  smooth();
  noStroke();
    //Ani.setDefaultEasing(Ani.QUART_IN_OUT);

  tileSize = width/folders.length;
  Ani.init(this);
  image = new ArrayList();
  size (800, 800); 
  for (int i=0; i<folders.length; i++) { 
    filenames[i] = listFileNames(dataPath("images/"+folders[i]+"/"));
  }
    tileSize = width/folders.length;
  for (int i=0; i<filenames.length; i++) { 
    for (int j = 0; j<filenames[i].length; j++) {
      image.add(new Image(j*tileSize, i*tileSize, folders[i], filenames[i][j]));
    }
  }
 timeOut = millis() + lapse;
}
void draw() {
  background(0);
  for (int i = 0; i < image.size(); i++) {
    Image part = image.get(i);
    if (part.isVisible) {
      part.display();
      part.becomeExisting();
    }
  }
  checkTimer();
}
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    StringList filelist = new StringList();
    for (String s : names) {
      if (!s.contains("DS_Store")) {
        filelist.append(s);
      }
    }
    return filelist.array();
  } else {
    return null;
  }
}

void checkTimer(){ 
  if(millis() > timeOut ) { 
    Image holder = image.get(int(random(image.size())));
    holder.isVisible =true;
    timeOut = millis() + lapse;
  }
}

public class Image {
  public int x;
  public int y;
  public PVector start;
  public int finalX;
  public int finalY;
  public int finalSize;
  public String folder;
  public PImage image;
  public boolean isVisible; 
  Image (int x, int y, String folder, String location) { 
    this.x = x;
    this.y = y;
    this.start = new PVector(100, 100);
    this.finalX = width/2;
    this.finalY = height/2;
    this.finalSize = 200;
    this.folder = folder;
    image =loadImage (location);
  }
  void display() { 
    image(image, finalX,finalY, finalSize, finalSize);
  }
  void isVisible() {
  }
  void becomeExisting(){ 
        Ani.to(this, 0.1, "finalX", x);
        Ani.to(this,0.1, "finalY", y);
        Ani.to(this, 0.1, "finalSize", tileSize);
  }
}