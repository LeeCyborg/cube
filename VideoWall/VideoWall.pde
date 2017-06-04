import processing.video.*;
Movie[] movie;
int index = 0;
Video[] plays;
int sizew;
int sizeh;
boolean first = true;
String[] titles = {"transit.mov", 
  "transit.mov", 
  "transit.mov", 
  "transit.mov"};
void setup() {
  size(1920, 1080);  
  findSize(titles.length);
  movie = new Movie[titles.length];
  plays = new Video[1];
  background(0);
  for (int i = 0; i< titles.length; i++) {
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
  for (int h = 0; h < width; h += sizew) {
    for (int v = 0; v < height; v += sizeh) { 
      image(movie[index], h, v, sizew, sizeh);
      index++;
    }
  }
  index= 0;
  checkVid();
}
void whenStop() { 
  for (int i = 0; i < plays.length; i++) {
    plays[i].end = millis() + (movie[plays[i].element].duration()*1000);
  }
}
void checkVid() { 
  for (int i = 0; i < plays.length; i++) {
    if (millis() > plays[i].end) { 
      playNext();
    }
  }
}
void playNext() { 
  for (int i = 0; i < plays.length; i++) {
    movie[plays[i].element].stop();
    if (first) {
      if (plays[i].element == (titles.length-1)) { 
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
void findSize(int videos) {
  if (videos == 1) { 
    sizew = width;
    sizeh = height;
  }
  if (videos == 4) { 
    sizew = width/2;
    sizeh = height/2;
  }
  if (videos == 16) { 
    sizew = width/4;
    sizeh= height/4;
  }
  if (videos == 36) { 
    sizew = width/6;
    sizeh = width/6;
  }
}
public class Video {
  public float end;
  public int element= 0;
}