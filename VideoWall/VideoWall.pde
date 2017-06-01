import processing.video.*;
Movie[] movie;
int index = 0;
Video[] plays;
int size;
boolean first = true;
String[] titles = {"transit.mov",
                   "transit.mov",
                   "transit.mov",
                   "transit.mov"};
void setup() {
  size(1000, 1000);
  findSize(titles.length);
  movie = new Movie[titles.length];
  plays = new Video[1];
  background(0);
  for(int i = 0; i< titles.length; i++){
    movie[i] = new Movie(this, titles[i]);
  }
  plays[0] = new Video();  
  movie[plays[0].element].play();
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
  for(int i = 0; i < plays.length; i++){
    plays[i].end = millis() + (movie[plays[i].element].duration()*1000);
  }
}
void checkVid(){ 
  for(int i = 0; i < plays.length; i++){
   if(millis() > plays[i].end){ 
     playNext();
   }
  }
}
void playNext(){ 
 for(int i = 0; i < plays.length; i++){
  movie[plays[i].element].stop();
  if(first){
   if(plays[i].element == (titles.length-1)) { 
     first=false;
     Video v = new Video();
     plays = (Video[]) append(plays, v);
     plays[i].element = int(random(0, titles.length-1));
   } else { 
     plays[i].element++;
   }
  } else { 
    plays[i].element = int(random(0, titles.length-1));
  }

   movie[plays[i].element].play();
 }
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

public class Video {
      public float end;
      public int element= 0;
}