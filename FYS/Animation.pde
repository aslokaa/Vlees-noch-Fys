int numFramesBallAnimation = 3;



class Animation {

  int animationTimer;
  int FrameDelay;
  int currentAnimationFrame;
  int numFrames;
  float imgDiameter;
  PImage[] animation;

  Animation()
  {
    animationTimer = 0;
    currentAnimationFrame = 0;
    numFrames = 0;
    imgDiameter = 0;
  }

  void initializeAnimation( String gifName, int numOfFrames, int delay, float diameter)
  {
    imgDiameter = diameter;
    FrameDelay = delay;
    animation = new PImage[numOfFrames];
    numFrames = numOfFrames;
    String fileName;
    for ( int i = 0; i < numOfFrames; i++ )
    {
      fileName = "./sprites/" + gifName + i + ".png";
      animation[i] = loadImage(fileName);
    }
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
