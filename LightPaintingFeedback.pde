/* Light Painting Assist App v0.1 by Eric Barch (ttjcrew.com) */

//Sets the minimum value to be counted as intense (Max of 255)
int INTENSITY_MIN = 175; 


/* Begin Main Code */
import JMyron.*;
JMyron videoSrc;
int[] currFrame;
int[] lastFrame;

void setup() {
  size(320, 240);
  videoSrc = new JMyron();
  videoSrc.start(width, height);
  videoSrc.findGlobs(0);
  videoSrc.update();
  lastFrame = videoSrc.image();
}

void draw() {
  videoSrc.update();
  currFrame = videoSrc.image();

  loadPixels();
  for (int i = 0; i < width*height; i++) {
    float r = red(currFrame[i]);
    float g = green(currFrame[i]);
    float b = blue(currFrame[i]);
    float rl = red(lastFrame[i]);
    float gl = green(lastFrame[i]);
    float bl = blue(lastFrame[i]);
    
    //if it's bright we need to save it
    if (((r + g + b)/3) > INTENSITY_MIN) {
      lastFrame[i] = color(r, g, b);
    } //dark...overwrite with current cam frame
    else if (((rl + gl + bl)/3) <= INTENSITY_MIN) {
      lastFrame[i] = color(r, g, b);
    }
      
    pixels[i] = lastFrame[i];
  }
  updatePixels();
}

void mousePressed() {
videoSrc.update();
  lastFrame = videoSrc.image();
}

public void stop() {
  videoSrc.stop();
  super.stop();
}
