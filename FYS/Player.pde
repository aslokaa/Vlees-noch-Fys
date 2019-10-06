//Niklas Leeuwin
//500784205
//


//This is the class that handles the object the player controlls. 
class PC
{
  final float PLAYERSTARTWIDTH=width*0.13, 
    PLAYERSTARTHEIGHT=height*0.045, 
    PLAYERSTARTX=width/2-PLAYERSTARTWIDTH/2, 
    PLAYERSTARTY=height-PLAYERSTARTHEIGHT, 
    PLAYERSTARTACCELERATIONX=width*0.001, 
    PLAYERVELOCITYXMAX=width*0.015, 
    PLAYERSTARTDECELERATEX=0.96, 
    PLAYERSTARTACCELERATIONY=height*0.0008, 
    PLAYERVELOCITYYMAX=height*0.01, 
    PLAYERSTARTDECELERATEY=0.96, 
    PLAYERMINWIDTH=PLAYERSTARTWIDTH*0.1, 
    PLAYERMAXWIDTH=width, 
    SLOWMODIFIER=0.9, 
    SECOND=60, //one second
    INVERTEDSTARTINGTIMER=SECOND*5, 
    INVISIBLESTARTINGTIMER=SECOND*1, 
    SLOWSTARTINGTIMER=SECOND*4, 
    SHAKEMODIFIERMIN=-width*0.003, 
    SHAKEMODIFIERMAX=width*0.0003, 
    SHAKESTARTINGTIMER=SECOND*0.5, 
    SPLITSTARTINGTIMER=SECOND*10;

  float x, y, w, h, accelerationX, accelerationY, velocityX, velocityY, //X value, Y value, width, height, acceleration on X axis, acceleration on Y axis,acceleration modifiers and velocity on the X axis
    decelerateX, decelerateY; //deceleration
  boolean inverted, //The direction the paddle moves in.
    invisible, // invisibles the paddle into 2.
    slow, //slows the paddle
    shake, //shakes the paddle
    split; //splits the paddle
  float invertedTimer, invisibleTimer, slowTimer, shakeTimer, splitTimer; //Duration of inverted, invisible, slow.
  int bullets, shakeCounter;//amount of bullets and the counter for shaking.


  PC() //Constructor
  {
    x=PLAYERSTARTX;
    y=PLAYERSTARTY;
    w=PLAYERSTARTWIDTH;
    h=PLAYERSTARTHEIGHT;
    accelerationX=PLAYERSTARTACCELERATIONX;
    accelerationY=PLAYERSTARTACCELERATIONY;
    velocityX=0;
    velocityY=0;
    decelerateX=PLAYERSTARTDECELERATEX;
    decelerateY=PLAYERSTARTDECELERATEY;
    inverted=false;
    invertedTimer=0;
    invisible =false;
    invisibleTimer=0;
    slow =false;
    slowTimer=0;
    shake = false;
    shakeTimer=0;
    split = false;
    splitTimer=0;
  }

  //updates the player
  void update()
  {
    detectInput();
    decelerate();
    checkMove();
    detectCollisionEdge();
    powerCountdown();
  }
  //checks how to player should be drawn.
  void checkDisplay()
  {
    if (invisible)
    {
      return;
    } 
    if (shake)
    {
      shake();
    } else if (split)
    {
      displaySplit();
    } else
      display();
  }

  //draws the standard player.
  void display()
  {
    noStroke();
    fill(getColor());
    rect(x, y, w, h);
  }
  //shakes the player
  void shake()
  {
    float xModifier=random(SHAKEMODIFIERMIN, SHAKEMODIFIERMAX);
    float yModifier=random(SHAKEMODIFIERMIN, SHAKEMODIFIERMAX);
    x+=xModifier;
    y+=yModifier;
    if (split)
    {
      displaySplit();
    } else
    {
      display();
    }
    x-=xModifier;
    y-=yModifier;
  }
  //draws the splitted player.
  void displaySplit()
  {
    noStroke();
    fill(getColor());
    rect(x, y, w/2, h);
    rect(width-x-w/2, y, w/2, h);
  }
  //detects user inputs.
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
    if (keysPressed['x'])
    {
      shoot();
    }
  }
  //checks what powers should affect the movement.
  void checkMove()
  {
    checkVelocityMax();
    if (slow) // slows the player
    {
      velocityX*=SLOWMODIFIER;
      velocityY*=SLOWMODIFIER;
    }
    if (inverted) // inverts the player
    {
      moveInverted();
    } else if (!inverted) // moves the player normally.
    {
      move();
    }
  }
  void checkVelocityMax()
  {
    if (velocityX>PLAYERVELOCITYXMAX)
    {
      velocityX=PLAYERVELOCITYXMAX;
    }
    if (velocityY>PLAYERVELOCITYYMAX)
    {
      velocityY=PLAYERVELOCITYYMAX;
    }
  }

  // modifies the X and Y positions
  void move()
  {
    x+=velocityX;
    y+=velocityY;
  }
  //modifies the X and Y posistions but inverted.
  void moveInverted()
  {
    x-=velocityX;
    y-=velocityY;
  }

  //Gives the player a powerup or down.
  void modifyPower(int type)
  {
    switch(type)
    {
    case PowerUps.INVERTED:
      inverted=true;
      invertedTimer=INVERTEDSTARTINGTIMER;
      break;
    case PowerUps.INVISIBLE:
      invisible=true;
      invisibleTimer=INVISIBLESTARTINGTIMER;
      break;
    case PowerUps.SLOW:
      slow=true;
      slowTimer=SLOWSTARTINGTIMER;
      break;
    case PowerUps.SPLIT:
      if (!split)
      {
        if (x>width/2)
        {
          x=width-x-w;
        }
      }
      split=true;
      splitTimer=SPLITSTARTINGTIMER;
      break;
    default:
      println("modifyPower default");
    }
  }

  //Prevents the player from going out of bounds
  void detectCollisionEdge() 
  {
    if (!split)
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
    } else if (split)
    {
      if (x<0)
      {
        x=0;
        velocityX=0;
      }
      if (x+w/2>width/2)
      {
        x=width/2-w/2;
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
  }

  //decelerates the player
  void decelerate()
  {
    velocityX*=decelerateX;
    velocityY*=decelerateY;
  }
  //shrinks the paddle
  void dealDamage(float damage)
  {
    w-=damage;
    shake=true;
    shakeTimer=SHAKESTARTINGTIMER;
    if (w<PLAYERMINWIDTH)
    {
      println("Lost");
    }
  }
  //grows the paddle
  void restoreHealth(float healing)
  {
    if (w<PLAYERMAXWIDTH)
    {
      w+=healing;
    }
  }
  //Keeps track of which powers are active and deactivates them.
  void powerCountdown()
  {
    if (inverted)
    {
      invertedTimer--;
      if (invertedTimer<=0)
      {
        inverted=false;
      }
    }
    if (invisible)
    {
      invisibleTimer--;
      if (invisibleTimer<=0)
      {
        invisible=false;
      }
    }
    if (slow)
    {
      slowTimer--;
      if (slowTimer<=0)
      {
        slow=false;
      }
    }
    if (shake)
    {
      shakeTimer--;
      if (shakeTimer<=0)
      {
        shake=false;
      }
    }
    if (split)
    {
      splitTimer--;
      if (splitTimer<=0)
      {
        split=false;
      }
    }
  }

  //Retrieves the color the player should have.
  color getColor()
  {
    if (shake)
    {
      return Colors.RED;
    }
    if (inverted)
    {
      return Colors.GREEN;
    } else if (invisible)
    {
      return Colors.WHITE;
    } else if (slow)
    {
      return Colors.BLUE;
    } else
    {
      return Colors.PINK;
    }
  }
  //creates a bullet
  void shoot()
  {
    println(bullets);
    if (bullets<1)
    {
      return;
    } 
    bullets--;
    println("pew");
  }
  //adds aditional bullets.
  void gainBullets(int ammo)
  {
    bullets+=ammo;
  }
}
