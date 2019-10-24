//Niklas Leeuwin
//500784205
//


//This is the class that handles the object the player controlls. 

class Player
{
  final float
    PLAYER_START_WIDTH              = width*0.13, 
    PLAYER_START_HEIGHT             = height*0.045, 
    PLAYER_START_X                  = width/2-PLAYER_START_WIDTH/2, 
    PLAYER_START_Y                  = height-PLAYER_START_HEIGHT, 
    PLAYER_START_ACCELERATION_X     = width*0.0015, 
    PLAYER_VELOCITY_X_MAX           = width*0.01, 
    PLAYER_START_DECELERATE_X       = 0.9, 
    PLAYER_START_ACCELERATION_Y     = height*0.0015, 
    PLAYER_VELOCITY_Y_MAX           = height*0.015, 
    PLAYER_START_DECELERATE_Y       = 0.9, 
    PLAYER_MIN_WIDTH                = PLAYER_START_WIDTH*0.1, 
    PLAYER_MAX_WIDTH                = width, 
    SLOW_MODIFIER                   = 0.9, 
    SECOND                          = 60, //one second
    INVERTED_STARTING_TIMER         = SECOND*5, 
    INVISIBLE_STARTING_TIMER        = SECOND*1, 
    SLOW_STARTING_TIMER             = SECOND*4, 
    SHAKE_MODIFIER_MIN              = -width*0.003, 
    SHAKE_MODIFIER_MAX              = width*0.0003, 
    SHAKE_STARTING_TIMER            = SECOND*0.5, 
    SHOOT_STARTING_TIMER            = SECOND*1, 
    SPLIT_STARTING_TIMER            = SECOND*10;

  float 
    x, 
    xSplit, 
    y, 
    playerWidth, 
    playerHeigth, 
    accelerationX, 
    accelerationY, 
    velocityX, 
    velocityXSplit, 
    velocityY, 
    decelerateX, 
    decelerateY, 
    widthSplit0, 
    widthSplit1;
  boolean 
    inverted, //The direction the paddle moves in.
    invisible, // invisibles the paddle into 2.
    slow, //slows the paddle
    shake, //shakes the paddle
    split;       //splits the paddle
  float //Duration of effects.
    invertedTimer, 
    invisibleTimer, 
    slowTimer, 
    shakeTimer, 
    splitTimer, 
    shootTimer; 
  int 
    ammo, //amount of ammo
    shakeCounter; 


  Player() //Constructor
  {
    x                 = PLAYER_START_X;
    y                 = PLAYER_START_Y;
    playerWidth       = PLAYER_START_WIDTH;
    playerHeigth      = PLAYER_START_HEIGHT;
    accelerationX     = PLAYER_START_ACCELERATION_X;
    accelerationY     = PLAYER_START_ACCELERATION_Y;
    velocityX         = 0;
    velocityXSplit    = 0;
    velocityY         = 0;
    decelerateX       = PLAYER_START_DECELERATE_X;
    decelerateY       = PLAYER_START_DECELERATE_Y;
    inverted          = false;
    invertedTimer     = 0;
    invisible         = false;
    invisibleTimer    = 0;
    slow              = false;
    slowTimer         = 0;
    shake             = false;
    shakeTimer        = 0;
    split             = false;
    splitTimer        = 0;
    shootTimer        = 0;
    xSplit            = 0;
    widthSplit0       = 0;
    widthSplit1       = 0;
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
    rect( x, y, widthSplit0, playerHeigth );
    rect(xSplit, y, widthSplit1, playerHeigth );
  }
  //detects user inputs.
  void detectInput()
  {
    if ( keyCodesPressed[LEFT] ) 
    {
      velocityX -= accelerationX ; //Accelerates to the left.
      if (split)
      {
        velocityXSplit += accelerationX;
      }
    }
    if ( keyCodesPressed[RIGHT] ) 
    {
      velocityX += accelerationX; //Accelerates to the right.
      if (split)
      {
        velocityXSplit -= accelerationX;
      }
    }
    if ( keyCodesPressed[UP] )
    {
      velocityY -= accelerationY; //Accelerates to upwards.
    }
    if ( keyCodesPressed[DOWN] )
    {
      velocityY += accelerationY; //Accelerates to downwards.
    }
    if ( keysPressed['x'] && shootTimer <= 1 )
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

  //makes sure the player doesn't go to fast
  void checkVelocityMax()
  {
    if (velocityX > PLAYER_VELOCITY_X_MAX)
    {
      velocityX = PLAYER_VELOCITY_X_MAX;
    }
    if (velocityX < -PLAYER_VELOCITY_X_MAX)
    {
      velocityX = -PLAYER_VELOCITY_X_MAX;
    }
    if (split && velocityXSplit > PLAYER_VELOCITY_X_MAX)
    {
      velocityXSplit = PLAYER_VELOCITY_X_MAX;
    }
    if (velocityY > PLAYER_VELOCITY_Y_MAX)
    {
      velocityY = PLAYER_VELOCITY_Y_MAX;
    }
    if (velocityY < -PLAYER_VELOCITY_Y_MAX)
    {
      velocityY = -PLAYER_VELOCITY_Y_MAX;
    }
  }
  // modifies the X and Y positions
  void move()
  {
    x += velocityX;
    y += velocityY;
    if (split)
    {
      xSplit+=velocityXSplit;
    }
  }
  //modifies the X and Y posistions but inverted.
  void moveInverted()
  {
    x -= velocityX;
    y -= velocityY;
    if (split)
    {
      xSplit-=velocityXSplit;
    }
  }

  //Gives the player a powerup or down.
  void modifyPower( int type )
  {
    switch(type)
    {
    case PowerUpTypes.INVERTED:
      playerSounds.play(Sounds.INVERTED);
      inverted = true;
      invertedTimer = INVERTED_STARTING_TIMER;
      break;
    case PowerUpTypes.INVISIBLE:
      playerSounds.play(Sounds.INVISIBLE);
      invisible = true;
      invisibleTimer = INVISIBLE_STARTING_TIMER;
      break;
    case PowerUpTypes.SLOW:
      playerSounds.play(Sounds.SLOW);
      slow = true;
      slowTimer = SLOW_STARTING_TIMER;
      break;
    case PowerUpTypes.SPLIT:
      playerSounds.play(Sounds.SPLIT);
      if (!split)
      {
        if ( x > width / 2 )
        {
          x = width - x - playerWidth;
        }
      }
      widthSplit0 = playerWidth / 2;
      widthSplit1 = playerWidth / 2;
      xSplit = width - x - widthSplit1;
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
    //Y
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
    //Unsplit X
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
      //Split X
    } else if (split)
    {
      if ( x < 0 )
      {
        x = 0;
        velocityX = 0;
      }
      if ( x + widthSplit0 > width / 2 )
      {
        x = width / 2 - widthSplit0;
        velocityX = 0;
      }
      if ( xSplit < width / 2 )
      {
        xSplit = width / 2;
        velocityXSplit = 0;
      }
      if ( xSplit + widthSplit1 > width )
      {
        xSplit = width - widthSplit1;
        velocityXSplit = 0;
      }
    }
  }

  //decelerates the player
  void decelerate()
  {
    velocityX *= decelerateX;
    if (split)
    {
      velocityXSplit *= decelerateX;
    }
    velocityY *= decelerateY;
  }
  //shrinks the paddle
  void dealDamage( float damage, boolean isRight)
  {
    if (shake || invisible)
    {
     return; 
    } 
    playerSounds.play(Sounds.RECIEVE_DAMAGE);
    shake = true;
    shakeTimer = SHAKE_STARTING_TIMER;
    if (split)//<- als ie shaked moet ie geen dmg nemen, handig voor balancing en betere feel.
    {
      if (isRight)
      {
        widthSplit1 -= damage;
      } else
      {
        widthSplit0 -= damage;
      }
      if (widthSplit0<PLAYER_MIN_WIDTH || widthSplit1 <PLAYER_MIN_WIDTH)
      {
        endSplit();
      }
    } else if (!split)
    {
      playerWidth -= damage;
      if ( playerWidth < PLAYER_MIN_WIDTH )
      {
        endscreen.loseGame();
      }
    }
  }



  //grows the paddle
  void restoreHealth( float healing, boolean isSplit )
  {
    playerSounds.play(Sounds.RESTORE_HEALTH);
    if (split)
    {
      if (isSplit)
      {
        if ( widthSplit1 < PLAYER_MAX_WIDTH / 2 )
          widthSplit1 += healing;
      } else
      {
        if ( widthSplit0 < PLAYER_MAX_WIDTH / 2 )
          widthSplit0 += healing;
      }
    } else if ( playerWidth < PLAYER_MAX_WIDTH )
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
        endSplit();
      }
    }
    if (shootTimer>0)
    {
      shootTimer--;
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
  //checks if you can shoot a bullet.
  void shoot()
  {
    if ( ammo<1 )
    {
      return;
    } 
    shootTimer=SHOOT_STARTING_TIMER;
    playerSounds.play(Sounds.SHOOT);
    ammo--;
    if (split)
    {
      activatesBullet(x+widthSplit0/2);
      activatesBullet(xSplit+widthSplit1/2);
    } else
    {
      activatesBullet(x+playerWidth/2);
    }
  }
  //adds aditional ammo.
  void gainAmmo( int newAmmo )
  {
    ammo += newAmmo;
  }

  //returns the hitboxes
  Rectangles getHitboxes()
  {
    return new Rectangles( x, xSplit, y, playerWidth, widthSplit0, widthSplit1, playerHeigth, split );
  }

  //activates a bullet.
  void activatesBullet(float xT)
  {
    for ( PlayerBullet playerBullet : playerBullets)
    {
      if (!playerBullet.shootBullet)
      {
        playerBullet.createBullet(xT, y);
        return;
      }
    }
  }
  //unsplits the player
  void endSplit()
  {
    split=false;
    playerWidth=widthSplit0+widthSplit1;
    splitTimer=0;
    if (widthSplit0>=widthSplit1)
    {
      return;
    } else
    {
      x=xSplit;
    }
  }
}


//stores hitbox information
class Rectangles
{
  Rectangle rectangle0;
  Rectangle rectangle1;
  Rectangles( float xT0, float xT1, float yT, float widthT, float w0T, float w1T, float heightT, boolean existsT )
  {
    float w0=widthT;
    float w1=widthT;
    if (existsT)
    {
      w0=w0T;
      w1=w1T;
    }
    rectangle0 = new Rectangle( xT0, yT, w0, heightT, true );
    rectangle1 = new Rectangle( xT1, yT, w1, heightT, existsT );
  }
}


class Rectangle
{
  float x, y, rectangleWidth, rectangleHeight;
  boolean exists;
  Rectangle( float xT, float yT, float widthT, float heightT, boolean existsT )
  {
    x = xT;
    y = yT;
    rectangleWidth = widthT;
    rectangleHeight = heightT;
    exists = existsT;
  }
}
