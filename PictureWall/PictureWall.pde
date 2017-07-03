void setup() {
  size (1000, 800); 

  String[] folders = { "first", "second"};
  String[][] filenames = new String[folders.length][];
  PImage[][] images = new PImage[folders.length][]; 
  for (int i=0; i<folders.length; i++) { 
    filenames[i] = listFileNames(dataPath(""+folders[i]+"/"));
    images[i] = new PImage [filenames[i].length];
  }


  
  for (int i=0; i<images.length; i++) { 
    for (int j = 0; j<filenames[i].length; j++) {
      images[i][j] = loadImage (filenames[i][j]); //load each image
      images[i][j].resize(width, height); //resize it to the size of the canvas
    }
  }
  int colWidth = 50;
  int rowHeight = 50;
  int colNum = images[0].length;
  int rowNum = folders.length;
  println(folders.length);
  for (int j = 0; j < folders.length; j++) { //loop through all therows
    for (int i = 0; i < filenames[j].length; i++) { //loop through all the columns
      PImage tile=images[j][i];
      image(tile, i*colWidth, j*rowHeight, 50, 50); //draw the tile to the screen

    }
  }
}

void draw() {
  noLoop();
}

//function to get all files in the data folder
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
    // if it's not a directory
    return null;
  }
}