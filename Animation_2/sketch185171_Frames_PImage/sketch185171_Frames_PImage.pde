////Modified by Adrion T. Kelley



int num=8000;
//color[] palette = { #FE4365, #FC9D9A, #F9CDAD, #C8C8A9, #83AF9B};
color[] palette = { #A3A948, #EDB92E, #F85931, #CE1836, #009989};


int count  = 0;
int numFrames = 11;  // The number of frames in the animation
int currentFrame = 0;
PImage[] images = new PImage[numFrames];
String imageName;





PImage img;



void setup() {
  size(568, 320);
  colorMode(HSB, 360, 100, 100);
frameRate(10);


for (int i = 1; i < numFrames; i++) {
        imageName = "Art_" + nf(i, 4) + ".png";
        images[i] = loadImage(imageName);

          println(imageName);
        //delay(1000);
       }

  
  
  
  img = new PImage(568,320);

  
}

void draw() {
  
  count++;
       if(count == images.length) count = 1;
    img.copy(images[count], 0, 0, images[count].width, images[count].height, 
        0, 0, img.width, img.height);
  
  
  
  drawStuff();
  
  //saveFrame("output/Art_####.png");
  
}



void drawStuff() {
  background(#202020);

  for (int i=0; i<num; i++) {
    float x = random(width);
    float y = random(height);
    color col = img.get(int(x), int(y));
    stroke(#FE4365, 200);
    noStroke();
    if (brightness(col)<20) {    
      for (int j=0; j<5; j++) {
        fill(palette[4-j],220);
        float sz = 40-j*7;
        ellipse(x, y, sz, sz);
      }
    }
  }
}