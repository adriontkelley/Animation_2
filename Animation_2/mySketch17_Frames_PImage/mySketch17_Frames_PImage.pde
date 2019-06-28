///modified by Adrion T. Kelley 2018



int count  = 0;
int numFrames = 11;  // The number of frames in the animation
int currentFrame = 0;
PImage[] images = new PImage[numFrames];
String imageName;





PImage img;



  
int vSpace = 20;
int hSpace = 20;

float amplitudeHeight = vSpace/2;
float precision = hSpace/15;

void setup() {
  size(568, 320, P3D); 
  smooth();
    frameRate(7);
    
  for (int i = 1; i < numFrames; i++) {
        imageName = "Art_" + nf(i, 4) + ".png";
        images[i] = loadImage(imageName);

          println(imageName);
        //delay(1000);
       }

  
  
  
  img = new PImage(568,320);
  
  
  
  
} 

void draw() {
  background(0);  
  
    count++;
       if(count == images.length) count = 1;
    img.copy(images[count], 0, 0, images[count].width, images[count].height, 
        0, 0, img.width, img.height);
  
  
  noFill();
  stroke(255);
  
  
  float frequency = -frameCount;
  for (int y = vSpace; y < height-vSpace*2; y+=vSpace) {
    beginShape();
    int x = 0;
    float prevAmplitude = 0;
    while (x < width) {
      float colorIntensity = img.get(int(x), int(y)) >> 16 & 0xFF;
      float amplitude = map(colorIntensity, 0, 255, 1, 0);
      for(int i=0; i<hSpace; i+=precision){
        float curAmpitude = lerp(prevAmplitude, amplitude, i/hSpace);
        x+=precision;
        frequency += curAmpitude;
      	vertex(x, y+ sin(frequency)*curAmpitude*amplitudeHeight);
      }
      prevAmplitude = amplitude;
    }
    endShape();
  }
}