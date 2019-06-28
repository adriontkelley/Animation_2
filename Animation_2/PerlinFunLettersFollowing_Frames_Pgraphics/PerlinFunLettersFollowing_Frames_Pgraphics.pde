////Modified by Adrion T. Kelley



TextGraphics tg;
ArrayList<Part> parts;
int nbParts = 6000;
float theta = 0, gamma = 0;



int count  = 0;
int numFrames = 11;  // The number of frames in the animation
int currentFrame = 0;
PImage[] images = new PImage[numFrames];
String imageName;


PImage img;

void setup()
{
  size(568, 320, P3D);
  
  frameRate(10);
  
  
  for (int i = 1; i < numFrames; i++) {
        imageName = "Art_" + nf(i, 4) + ".png";
        images[i] = loadImage(imageName);

          println(imageName);
        //delay(1000);
       }
  
  
 
  
  img = new PImage(568,320);
  
  
  
  tg = new TextGraphics();
  
  
}

void draw()
{
  background(255);
  theta = map(width/2, 0, width, -PI, PI);
  gamma = map(height/2, 0, height, PI, -PI);
  
  
  tg.initialize();
  
  
  for (Part p : parts) {
    p.update();
  }
  
  //saveFrame("output/Art_####.png");
  
}

void mousePressed()
{
}

void keyPressed()
{
  if (key != CODED)
  {
    switch(key)
    {
    case ' '://ignore SPACE
    case ESC://ignore ESCAPE
    case ENTER://ignore ENTER
    case BACKSPACE://ignore BACKSPACE
      break;
    default://char input
      //tg.process("" + key);//RUN IN JAVA
      //tg.process(new String(key));//RUN IN JS
      break;
    }
  }
}

class Part
{
  PVector pos, origin;
  float viscosity = random(.03, .2);

  Part(PVector p_pos)
  {
    origin = p_pos.get();
    origin.z = random(-15, 15);
    pos = origin.get();
  }

  void update()
  {
    pushMatrix();
    translate(width/2, height/2);
    rotateY(theta);
    rotateX(gamma);
    translate(-width/2, -height/2);
    float x = modelX(origin.x, origin.y, origin.z);
    float y = modelY(origin.x, origin.y, origin.z);
    float z = modelZ(origin.x, origin.y, origin.z);
    popMatrix();
    
    PVector dest = new PVector(x, y, z);
    dest.sub(pos);
    stroke(min(map(dest.mag(), 0, 100, 0, 100), 100));
    strokeWeight(map(dest.z, -50, 50, 1, 3));
    dest.mult(viscosity);
    pos.add(dest);
    
    point(pos.x, pos.y);
  }
}

class TextGraphics
{  
  PGraphics pg;//buffer PG used to write the input char

  TextGraphics()
  {
    pg = createGraphics(img.width, img.height, P2D);
    //process(new String("#"));//"π")//initialize with a String
    //process(img);
  }
  
  void initialize()
  {    
    process(img);//initialize with a char
  }

  void process(PImage c)
  {
    
     count++;
       if(count == images.length) count = 1;
    img.copy(images[count], 0, 0, images[count].width, images[count].height, 
        0, 0, img.width, img.height);
    
    
    img=c;
    pg.beginDraw();
    pg.translate(0, height/100);
    pg.background(255);
    //pg.textSize(350);//500
    pg.fill(color(0, 255, 0));
    pg.image(img,0,0);
    //pg.text(c, 30, 30);
    pg.translate(0, -height/100);
    pg.endDraw();

    parts = new ArrayList<Part>();
    pg.loadPixels();

    //random hair disposition 
    while (parts.size () < nbParts)
    {
      PVector pv = new PVector(random(width), random(height));
      if (green(pg.pixels[(int)pv.y * width + (int)pv.x]) < 100)
        parts.add(new Part(new PVector(pv.x, pv.y)));
    }
    
    pg.updatePixels();
  }
}