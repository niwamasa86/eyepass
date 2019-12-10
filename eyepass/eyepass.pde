import gazetrack.*;
GazeTrack gazeTrack;

PImage imgramen;
PImage imgsushi;
PImage imgbeef;
PImage imgsukiyaki; 
PImage []images=new PImage [4];

int flag=0;
int pos;
int [] array={0, 1, 2, 3};
//0:ラーメン
//1:寿司
//2:ローストビーフ
//3:すき焼き
int [] pass={3, 2, 1}; //正しい写真をみる順番を決める

int [] cpass=new int[pass.length+5];
void setup() {
  fullScreen();
  noFill();
  stroke(50, 100);
  strokeWeight(10);

  gazeTrack = new GazeTrack(this);
  shuffle(array, 4);
  images[array[0]]= loadImage("ラーメン.jpg");
  images[array[1]]= loadImage("sushi.jpg");
  images[array[2]]= loadImage("ローストビーフ.jpg");
  images[array[3]] =loadImage("SUKIYAKI.jpg");
  for (int i=0; i<pass.length; i++) {
    cpass[i]=array[pass[i]];
    println(cpass[i]);
  }
}

void draw() {
  background(255);
  image(images[0], 0, 0, width/2, height/2);
  image(images[1], width/2, 0, width/2, height/2);
  image(images[2], 0, height/2, width/2, height/2);
  image(images[3], width/2, height/2, width/2, height/2);
  noFill();
  if (flag>2) {


    background(255, 200, 0);
    fill(255, 0, 0);
    textSize(100);
    text("OPEN", width/2-130, height/2-100);
    fill(-1);
  }
  ellipse(width/2+150, height/2, 80, 80);
  if (flag>1) {
    fill(-1);
  }
  ellipse(width/2, height/2, 80, 80);
  if (flag>0) {
    fill(-1);
  }
  ellipse(width/2-150, height/2, 80, 80);
  if (gazeTrack.gazePresent())
  {
    //ellipse(gazeTrack.getGazeX(), gazeTrack.getGazeY(), 80, 80);

    // Print the tracker's timestamp for the gaze cursor above
    //println("Latest gaze data at: " + gazeTrack.getTimestamp());
  }

  if (((keyPressed == true) && (key ==' '))||(mousePressed == true)) {
    println("a観測");
    println((gazeTrack.getGazeX()));
    println((gazeTrack.getGazeY()));
    if (gazeTrack.getGazeX()<width/2 &&  gazeTrack.getGazeY()<height/2) {
      pos=0;
    } else if (gazeTrack.getGazeX()>width/2 &&  gazeTrack.getGazeY()<height/2) {
      pos=1;
    } else if (gazeTrack.getGazeX()<width/2 &&  gazeTrack.getGazeY()>height/2) {
      pos=2;
    } else if (gazeTrack.getGazeX()>width/2 &&  gazeTrack.getGazeY()>height/2) {
      pos=3;
    }
    if (cpass[flag]==pos) {
      println("good" );
      flag++;
    } else {
      println("bad" );
      flag=0;
    }
  }
}

void shuffle(int array[], int size) {
  for (int i = 0; i < size; i++) {
    int j =int(random(size));
    int t = array[i];
    array[i] = array[j];
    array[j] = t;
  }
}
