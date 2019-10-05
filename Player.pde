
//This is the class that handles the object the player controlls. 
class PC
{
  final float PLAYERSTARTWIDTH=width*0.13, 
    PLAYERSTARTHEIGHT=height*0.045, 
    PLAYERSTARTX=width/2-PLAYERSTARTWIDTH/2, 
    PLAYERSTARTY=height-PLAYERSTARTHEIGHT, 
    PLAYERSTARTVELOCITY=0, 
    PLAYERSTARTACCELERATIONX=width*0.001, 
    PLAYERVELOCITYXMAX=width*0.015, 
    PLAYERSTARTDECELERATEX=0.96, 
    PLAYERSTARTACCELERATIONY=height*0.0008, 
    PLAYERVELOCITYYMAX=height*0.01, 
    PLAYERSTARTDECELERATEY=0.96,
    PLAYERMINWIDTH=PLAYERSTARTWIDTH*0.1,
    PLAYERMAXWIDTH=width;
  final color PLAYERSTARTCOLOR=color(255, 0, 255); //purple
  float x, y, w, h, accelerationX, accelerationY, velocityX, velocityY, //X value, Y value, width, height, acceleration on X axis, acceleration on Y axis,acceleration modifiers and velocity on the X axis
    decelerateX, decelerateY; //deceleration
  color c;//color value

  PC()
  {
    x=PLAYERSTARTX;
    y=PLAYERSTARTY;
    w=PLAYERSTARTWIDTH;
    h=PLAYERSTARTHEIGHT;
    c=PLAYERSTARTCOLOR;
    accelerationX=PLAYERSTARTACCELERATIONX;
    accelerationY=PLAYERSTARTACCELERATIONY;
    velocityX=PLAYERSTARTVELOCITY;
    decelerateX=PLAYERSTARTDECELERATEX;
    decelerateY=PLAYERSTARTDECELERATEY;
  }

  //updates the player
  void update()
  {
    detectInput();
    decelerate();
    move();
    detectCollisionEdge();
  }

  //draws the player
  void display()
  {
    fill(c);
    rect(x, y, w, h);
  }

  void detectInput()
  {
    if (keyCodesPressed[LEFT]) 
    {
      velocityX -= accelerationX ; //Accelerates to the left.
    }
    if (keyCodesPressed[RIGHT]) 
    {
      velocityX += accelerationX; //Accelerates to the right.
    }
    if (keyCodesPressed[UP])
    {
      velocityY -= accelerationY; //Accelerates to upwards.
    }
    if (keyCodesPressed[DOWN])
    {
      velocityY += accelerationY; //Accelerates to downwards.
    }
  }
  void move()
  {
    if (velocityX>PLAYERVELOCITYXMAX)
    {
      velocityX=PLAYERVELOCITYXMAX;
    }
    if (velocityY>PLAYERVELOCITYYMAX)
    {
      velocityY=PLAYERVELOCITYYMAX;
    }
    x+=velocityX;
    y+=velocityY;
  }

  //Prevents the player from going out of bounds
  void detectCollisionEdge() 
  {
    if (x<0)
    {
      x=0;
      velocityX=0;
    }
    if (x+w>width)
    {
      x=width-w;
      velocityX=0;
    }
    if (y<0)
    {
      y=0;
      velocityY=0;
    }
    if (y+h>height)
    {
      y=height-h;
      velocityY=0;
    }
  }

  //decelerates the player
  void decelerate()
  {
    velocityX*=decelerateX;
    velocityY*=decelerateY;
  }
  
  void dealDamage(float damage)
  {
   w-=damage;
   if (w<PLAYERMINWIDTH)
   {
     println("Lost");
   }
  }
  void restoreHealth(float healing)
  {
    if (w<PLAYERMAXWIDTH)
   {
     w+=healing;
   }
  }
}
