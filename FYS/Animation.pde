int numFramesBallAnimation = 3;



class Animation {

  boolean active;
  int animationTimer;
  int FrameDelay;
  int currentAnimationFrame;
  int numFrames;
  float imgDiameter;
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

  void display(float x, float y) {
    if (animationTimer == FrameDelay) {
      currentAnimationFrame++;
      currentAnimationFrame %= numFrames;
      animationTimer = 0;
    }
    image(animation[currentAnimationFrame], x, y, imgDiameter, imgDiameter);
    animationTimer++;
  }
}
