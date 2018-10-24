

// original from Daniel Shiffman
import controlP5.*;

ControlP5 cp5;

float slider = 0.36;
float angle = 0;
float w = 2;
float col = 0.5;
float A = 5 ;
float Sca = 0.33;
float Scb = -0.05;
float shx;
float shy;
float hu;


void setup() {
  smooth();
  //fullScreen();
  size(600,600);
  colorMode(HSB, 1);
  frameRate (60);
  cp5 = new ControlP5(this);
  cp5.addSlider ("slider").setPosition(10,10).setRange(0,0.7);  
  cp5.addSlider ("A").setPosition(10,30).setRange(0,10000000);
  //cp5.addSlider ("Sca").setPosition(10,50).setRange(-1,1);
  //cp5.addSlider ("Scb").setPosition(10,70).setRange(-1,1);
  //cp5.addSlider ("shx").setPosition(10,90).setRange(-2,2);
  //cp5.addSlider ("shy").setPosition(10,110).setRange(-2,2);
}
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
   w = w + w * 0.05 * e; // 0 bis 3
  //col = col + 0.1 * e; // 0 bis 0.7
  println("W",w);}
  



void draw() {

  // mouse control
 //float ca =Sca; 
 float ca = map(mouseX, 0, width, -1, 1);//-0.70176; 
 //float cb = Scb;
 float cb = map(mouseY, 0, height, -1, 1);//-0.3842;
 col = slider;
 


 
 //navigation
  float tf;
 if (w < 1) {
   tf=w*0.05;}
   else { tf = 0.1;
 }
 if (keyPressed) {
  if (key == CODED) {
    if (keyCode == UP) shy= shy -tf;
    if (keyCode == DOWN) shy= shy +tf;
    if (keyCode == LEFT) shx -=   tf;
    if (keyCode == RIGHT) shx = shx + tf  ;
   
    //
  }
 }

//col = sin(angle);//sin(angle);
  //float cb = sin(angle);

 // angle += 0.001;

  //background(255);

  // Establish a range of values on the complex plane
  // A different range will allow us to "zoom" in or out on the fractal

  // It all starts with the width, try higher or lower values
  //float w = abs(sin(angle))*5;

  float h = (w * height) / width;

  // Start at negative half the width and height
  float xmin = -w/2 + shx;
  float ymin = -h/2 + shy;

  // Make sure we can write to the pixels[] array.
  // Only need to do this once since we don't do any other drawing.
  loadPixels();

  // Maximum number of iterations for each point on the complex plane
  int maxiterations = 100;

  // x goes from xmin to xmax
  float xmax = xmin + w;
  // y goes from ymin to ymax
  float ymax = ymin + h;

  // Calculate amount we increment x,y for each pixel
  float dx = (xmax - xmin) / (width);
  float dy = (ymax - ymin) / (height);
  //println("dy",dy);

  // Start y
  float y = ymin;
  for (int j = 0; j < height; j++) {
    // Start x
    float x = xmin;
    for (int i = 0; i < width; i++) {

      // Now we test, as we iterate z = z^2 + cm does z tend towards infinity?
      float a = x;
      float b = y;
      int n = 0;
      while (n < maxiterations) {
        float aa = a * a;
        float bb = b * b;
        // Infinity in our finite world is simple, let's just consider it 16
        if (aa + bb >A) { //5
          break;  // Bail
        }
        float twoab = -2 * a * b;
        a = aa - bb + ca;
        b = twoab + cb;
        n++;
      }

      // We color each pixel based on how long it takes to get to infinity
      // If we never got there, let's pick the color black
      if (n == maxiterations) {
        pixels[i+j*width] = color(0.1,0.8,1, 0.5); // 0
      } else {
        // Gosh, we could make fancy colors here if we wanted
        hu =   ( (float(n) / maxiterations)) + col;
        float g= 1-float(n)+col;
        float f = 1-hu*g+col;
        
        //println( hu);
        pixels[i+j*width] = color(hu,1, 1);
        
      }
      x += dx;
    }
    y += dy;
  }
  updatePixels();
  //filter(INVERT);
  // println("Hu:", hu); 


  println(frameRate);
}
