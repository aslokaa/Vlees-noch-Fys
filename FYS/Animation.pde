/* Olger, Eele
this class contains the code to store an array of PImages and 
display them in sequence with a given interval between images.
all animations are made at setup and initialized when they are needed. 
*/

int numFramesBallAnimation = 3;


class Animation {

  boolean active;
  int animationTimer;//a framecounter to check the amount of frames passed since last image switch
  int FrameDelay;//the number of frames between image switches
  int currentAnimationFrame;
  int numFrames;//total amount of frames in the animation
  float imgDiameter;//display diameter
  PImage[] animation;

  Animation()
  {
    active = false;
    animationTimer = 0;
    currentAnimationFrame = 0;
    numFrames = 0;
    imgDiameter = 0;
  }

  void initializeAnimation( PImage[] newAnimation, int numOfFrames, int delay, float diameter)
  {
    active = true;
    imgDiameter = diameter;
    FrameDelay = delay;
    animation = new PImage[numOfFrames];
    numFrames = numOfFrames;
    animationTimer = 0;
    currentAnimationFrame = 0;
    animation = newAnimation;
  }

  void display(float x, float y) {//gets called in the draw loop every frame, checks if image needs to switched and displays currentframe image.
    if (animationTimer == FrameDelay) {
      currentAnimationFrame++;
      currentAnimationFrame %= numFrames;
      animationTimer = 0;
    }
    image(animation[currentAnimationFrame], x, y, imgDiameter, imgDiameter);
    animationTimer++;
  }
}
