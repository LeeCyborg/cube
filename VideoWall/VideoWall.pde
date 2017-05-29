import processing.video.*;
Movie[] movie;
int index = 0;
int currPlay = 0;
float end;
int size;
String[] titles = {"transit.mov",
                   "transit.mov",
                   "transit.mov",
                   "transit.mov"};
void setup() {
  size(1000, 1000);
  findSize(titles.length);
  movie = new Movie[titles.length];
  background(0);
  for(int i = 0; i< titles.length; i++){
    movie[i] = new Movie(this, titles[i]);
  }
  movie[currPlay].play();
  whenStop();  
}
void movieEvent(Movie m) {
  m.read();
}
void draw() {
for (int h = 0; h < width; h += size) {
  for (int v = 0; v < height; v += size) { 
    image(movie[index], h, v, size, size);
    index++;
  }
}
index= 0;
checkVid();
}
void whenStop(){ 
 end = millis() + (movie[currPlay].duration()*1000);
}
void checkVid(){ 
   if(millis() > end){ 
     playNext();
   }
}
void playNext(){ 
  movie[currPlay].stop();
   if(currPlay == (titles.length-1)) { 
     currPlay = 0;
   } else { 
     currPlay++;
   }
   movie[currPlay].play();
   whenStop();
}
void findSize(int videos){
  if(videos == 1){ 
    size = width;
  }
  if(videos == 4){ 
    size = width/2;
  }
  if(videos == 16){ 
    size = width/4;
  }
  if(videos == 16){ 
    size = width/8;
  }
}