//Niklas Leeuwin
//500784205
//


//This is the class that handles the object the player controlls. 

class PlayerControlled
{
  final float PLAYER_START_WIDTH    = width*0.13, 
    PLAYER_START_HEIGHT             = height*0.045, 
    PLAYER_START_X                  = width/2-PLAYER_START_WIDTH/2, 
    PLAYER_START_Y                  =height-PLAYER_START_HEIGHT, 
    PLAYER_START_ACCELERATION_X     =width*0.001, 
    PLAYER_VELOCITY_X_MAX           =width*0.015, 
    PLAYER_START_DECELERATE_X       =0.98, 
    PLAYER_START_ACCELERATION_Y     =height*0.001, 
    PLAYER_VELOCITY_Y_MAX           =height*0.01, 
    PLAYER_START_DECELERATE_Y       =0.9, 
    PLAYER_MIN_WIDTH                =PLAYER_START_WIDTH*0.1, 
    PLAYER_MAX_WIDTH                =width, 
    SLOW_MODIFIER                   =0.9, 
    SECOND                          =60, //one second
    INVERTED_STARTING_TIMER         =SECOND*5, 
    INVISIBLE_STARTING_TIMER        =SECOND*1, 
    SLOW_STARTING_TIMER             =SECOND*4, 
    SHAKE_MODIFIER_MIN              =-width*0.003, 
    SHAKE_MODIFIER_MAX              =width*0.0003, 
    SHAKE_STARTING_TIMER            =SECOND*0.5, 
    SHOOT_STARTING_TIMER            =SECOND*0.1, 
    SPLIT_STARTING_TIMER            =SECOND*10;

  float x, y, playerWidth, playerHeigth, accelerationX, accelerationY, 
    velocityX, velocityY, //velocity on the X and Y axis
    decelerateX, decelerateY; //deceleration
  boolean inverted, //The direction the paddle moves in.
    invisible, // invisibles the paddle into 2.
    slow, //slows the paddle
    shake, //shakes the paddle
    split; //splits the paddle
  float invertedTimer, invisibleTimer, slowTimer, shakeTimer, splitTimer, shootTimer; //Duration of effects.
  int bullets, shakeCounter;//amount of bullets and the counter for shaking.


  PlayerControlled() //Constructor
  {
    x = PLAYER_START_X;
    y = PLAYER_START_Y;
    playerWidth = PLAYER_START_WIDTH;
    playerHeigth = PLAYER_START_HEIGHT;
    accelerationX = PLAYER_START_ACCELERATION_X;
    accelerationY = PLAYER_START_ACCELERATION_Y;
    velocityX = 0;
    velocityY = 0;
    decelerateX = PLAYER_START_DECELERATE_X;
    decelerateY = PLAYER_START_DECELERATE_Y;
    inverted = false;
    invertedTimer = 0;
    invisible = false;
    invisibleTimer = 0;
    slow = false;
    slowTimer = 0;
    shake = false;
    shakeTimer = 0;
    split = false;
    splitTimer = 0;
    shootTimer = 0;
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
    rect( x, y, playerWidth, playerHeigth );
  }
  //shakes the player
  void shake()
  {
    float xModifier = random( SHAKE_MODIFIER_MIN, SHAKE_MODIFIER_MAX );
    float yModifier = random( SHAKE_MODIFIER_MIN, SHAKE_MODIFIER_MAX );
    x += xModifier;
    y += yModifier;
    if (split)
    {
      displaySplit();
    } else
    {
      display();
    }
    x -=xModifier;
    y -=yModifier;
  }
  //draws the splitted player.
  void displaySplit()
  {
    noStroke();
    fill(getColor());
    rect( x , y , playerWidth / 2, playerHeigth );
    rect( width - x - playerWidth / 2, y, playerWidth / 2 , playerHeigth );
  }
  //detects user inputs.
  void detectInput()
  {
    if ( keyCodesPressed[LEFT] ) 
    {
      velocityX -= accelerationX ; //Accelerates to the left.
    }
    if ( keyCodesPressed[RIGHT] ) 
    {
      velocityX += accelerationX; //Accelerates to the right.
    }
    if ( keyCodesPressed[UP] )
    {
      velocityY -= accelerationY; //Accelerates to upwards.
    }
    if ( keyCodesPressed[DOWN] )
    {
      velocityY += accelerationY; //Accelerates to downwards.
    }
    if ( keysPressed['x'] && shootTimer <= 0 )
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
      velocityX *= SLOW_MODIFIER;
      velocityY *= SLOW_MODIFIER;
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
    if (velocityX > PLAYER_VELOCITY_X_MAX)
    {
      velocityX = PLAYER_VELOCITY_X_MAX;
    }
    if (velocityY > PLAYER_VELOCITY_Y_MAX)
    {
      velocityY = PLAYER_VELOCITY_Y_MAX;
    }
  }

  // modifies the X and Y positions
  void move()
  {
    x += velocityX;
    y += velocityY;
  }
  //modifies the X and Y posistions but inverted.
  void moveInverted()
  {
    x -= velocityX;
    y -= velocityY;
  }

  //Gives the player a powerup or down.
  void modifyPower( int type )
  {
    switch(type)
    {
    case PowerUps.INVERTED:
      inverted = true;
      invertedTimer = INVERTED_STARTING_TIMER;
      break;
    case PowerUps.INVISIBLE:
      invisible = true;
      invisibleTimer = INVISIBLE_STARTING_TIMER;
      break;
    case PowerUps.SLOW:
      slow = true;
      slowTimer = SLOW_STARTING_TIMER;
      break;
    case PowerUps.SPLIT:
      if (!split)
      {
        if ( x > width / 2 )
        {
          x = width - x - playerWidth;
        }
      }
      split = true;
      splitTimer=SPLIT_STARTING_TIMER;
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
      if ( x < 0 )
      {
        x = 0;
        velocityX = 0;
      }
      if ( x + playerWidth > width )
      {
        x = width - playerWidth;
        velocityX = 0;
      }
      if ( y < 0 )
      {
        y = 0;
        velocityY = 0;
      }
      if ( y + playerHeigth > height )
      {
        y = height - playerHeigth;
        velocityY = 0;
      }
    } else if (split)
    {
      if ( x < 0 )
      {
        x = 0;
        velocityX = 0;
      }
      if ( x + playerWidth / 2 > width / 2 )
      {
        x = width / 2 - playerWidth / 2;
        velocityX = 0;
      }
      if (y < 0)
      {
        y = 0;
        velocityY = 0;
      }
      if ( y + playerHeigth > height)
      {
        y = height - playerHeigth;
        velocityY = 0;
      }
    }
  }

  //decelerates the player
  void decelerate()
  {
    velocityX *= decelerateX;
    velocityY *= decelerateY;
  }
  //shrinks the paddle
  void dealDamage( float damage )
  {
    playerWidth -= damage;
    shake = true;
    shakeTimer = SHAKE_STARTING_TIMER;
    if ( playerWidth < PLAYER_MIN_WIDTH )
    {
      println("Lost");
    }
  }
  //grows the paddle
  void restoreHealth( float healing )
  {
    if ( playerWidth < PLAYER_MAX_WIDTH )
    {
      playerWidth += healing;
    }
  }
  //Keeps track of which powers are active and deactivates them.
  void powerCountdown()
  {
    if (inverted)
    {
      invertedTimer--;
      if ( invertedTimer <= 0 )
      {
        inverted=false;
      }
    }
    if (invisible)
    {
      invisibleTimer--;
      if ( invisibleTimer <= 0 )
      {
        invisible=false;
      }
    }
    if (slow)
    {
      slowTimer--;
      if ( slowTimer <= 0 )
      {
        slow=false;
      }
    }
    if (shake)
    {
      shakeTimer--;
      if ( shakeTimer <=0 )
      {
        shake=false;
      }
    }
    if (split)
    {
      splitTimer--;
      if ( splitTimer <= 0 )
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
    if ( inverted )
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
    if ( bullets<1 )
    {
      return;
    } 
    bullets--;
    println("pew");
  }
  //adds aditional bullets.

  void gainBullets( int ammo )
  {
    bullets += ammo;
  }
}

class rectangle
{
  float x, y, rectangleWidth, rectangleHeight;

  rectangle( float xT, float yT, float widthT, float heightT )
  {
    x = xT;
    y = yT;
    rectangleWidth = widthT;
    rectangleHeight = heightT;
  }
}
