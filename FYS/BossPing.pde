//Niklas Leeuwin
//500784205
//some things have been copied from the Player class.

//This is the class that handles the ping boss. It's like playing pong
class BossPing
{
  private float 
    x, 
    y, 
    velocityX, 
    velocityY, 
    accelerationX, 
    accelerationY, 
    decelerateX, 
    decelerateY, 
    bossWidth, 
    bossHeight, 
    closestBallX,
    closestBallY;
  private int
    health, 
    damageTimer;
  private final float
    BOSS_START_WIDTH              = gamefield.GAMEFIELD_WIDTH*0.13, 
    BOSS_START_HEIGHT             = height * 0.045, 
    BOSS_START_X                  = gamefield.GAMEFIELD_WIDTH/2-BOSS_START_WIDTH/2, 
    BOSS_START_Y                  = BOSS_START_HEIGHT, 
    BOSS_START_ACCELERATION_X     = gamefield.GAMEFIELD_WIDTH * 0.0035, 
    BOSS_VELOCITY_X_MAX           = gamefield.GAMEFIELD_WIDTH * 0.01, 
    BOSS_START_ACCELERATION_Y     = height * 0.002, 
    BOSS_VELOCITY_Y_MAX           = height * 0.012, 
    BOSS_MAX_Y                    = height *0.3, 
    BALL_IS_CLOSE                 = BOSS_START_WIDTH*0.3, 
    BACKGROUND_LINE_SIZE          = gamefield.GAMEFIELD_WIDTH*0.01, 
    BOSS_START_DECELERATE_X       = 0.85, 
    BOSS_START_DECELERATE_Y       = 0.85;
  public final int
    BOSS_DAMAGE_TIMER             = 10, 
    BOSS_START_HEALTH             = 3;
  public BossPing()
  {
    x                   = BOSS_START_X;
    y                   = BOSS_START_Y;
    accelerationX       = BOSS_START_ACCELERATION_X; 
    accelerationY       = BOSS_START_ACCELERATION_Y;
    decelerateX         = BOSS_START_DECELERATE_X;
    decelerateY         = BOSS_START_DECELERATE_Y;
    bossWidth           = BOSS_START_WIDTH;
    bossHeight          = BOSS_START_HEIGHT;
    health              = BOSS_START_HEALTH;
  }

  public void update()
  {
    detectNearestBall();
    accelerate();
    decelerate();
    checkVelocityMax();
    move();
    countdown();
    detectCollisionEdge();
  }

  //locates the nearest ball.
  private void detectNearestBall()
  {
    float closestBallXT = gamefield.GAMEFIELD_WIDTH/2;
    float closestBallYT = height; //Futher away than a ball can possibly be.
    for (Ball ball : balls) 
    {
      float xT = ball.x;
      float yT = ball.y;
      if (ball.speedY<0)
      {
        if (dist(x + bossWidth/2, y + bossHeight/2, xT, yT)<dist(x + bossWidth/2, y + bossHeight/2, closestBallXT, closestBallYT))
        {
          closestBallXT = xT;
          closestBallYT = yT;
        }
      }
      closestBallX = closestBallXT;
      if (closestBallYT==height)
      {
        closestBallY=0;
      } else
      {
        closestBallY = closestBallYT;
      }
    }
  }

  //checks if the ball is to the right of the boss.
  private boolean isBallRight()
  {
    return closestBallX>x + bossWidth/2;
  }

  //checks if the ball is below the boss.
  private boolean isBallDown()
  {
    return closestBallY>y + bossHeight;
  }

  private boolean isBallCloseX()
  {
    return closestBallX+BALL_IS_CLOSE>x+bossWidth/2 && closestBallX-BALL_IS_CLOSE<x+bossWidth/2;
  }

  //accelerates the boss.
  private void accelerate()
  {
    //X
    if (!isBallCloseX())
    {
      if (isBallRight())
      {
        velocityX+= accelerationX;
      } else
      {
        velocityX-= accelerationX;
      }
    }
    //Y
    if (isBallDown())
    {
      velocityY+= accelerationY;
    } else
    {
      velocityY-= accelerationY;
    }
  }

  //decelerates the boss.
  private void decelerate()
  {
    //stops
    if (velocityX<accelerationX && velocityX>0)
    {
      velocityX=0;
    }
    if (velocityX>-accelerationX && velocityX<0)
    {
      velocityX=0;
    }
    //stops
    if (velocityY<accelerationY && velocityY>0)
    {
      velocityY=0;
    }
    if (velocityY>-accelerationY && velocityY<0)
    {
      velocityY=0;
    }
    velocityX *= decelerateX;
    velocityY *= decelerateY;
  }

  //makes sure the boss doesn't go too fast
  private void checkVelocityMax()
  {
    if (velocityX > BOSS_VELOCITY_X_MAX)
    {
      velocityX = BOSS_VELOCITY_X_MAX;
    } else if (velocityX < -BOSS_VELOCITY_X_MAX)
    {
      velocityX = -BOSS_VELOCITY_X_MAX;
    }
    if (velocityY > BOSS_VELOCITY_Y_MAX)
    {
      velocityY = BOSS_VELOCITY_Y_MAX;
    } else if (velocityY < -BOSS_VELOCITY_Y_MAX)
    {
      velocityY = -BOSS_VELOCITY_Y_MAX;
    }
  }

  //moves the boss
  private void move()
  {
    x += velocityX;
    y += velocityY;
  }
  //Prevents the boss from going out of bounds
  private void detectCollisionEdge() 
  {
    //Y
    if ( y < 0 )
    {
      y = 0;
      velocityY *= -1;
    }
    if ( y + bossHeight > BOSS_MAX_Y )
    {
      y = BOSS_MAX_Y - bossHeight;
      velocityY *= -1;
    }
    if ( x < 0 )
    {
      x = 0;
      velocityX = 0;
    }
    if ( x + bossWidth > gamefield.GAMEFIELD_WIDTH )
    {
      x = gamefield.GAMEFIELD_WIDTH - bossWidth;
      velocityX = 0;
    }
  }

  //damages the boss
  public void recieveDamage(int damage)
  {
    if (damageTimer>=0)
    {
      return;
    }
    health-=damage;
    damageTimer=BOSS_DAMAGE_TIMER;
    y-=y*0.5
    if ( health <= 0 )
    {
      killPing();
    }
  }


  //removes Ping from the game
  public void killPing()
  {
    stateBossPing=false;
    score = score + 1000;
  }

  public void display()
  {
    displayBackground();
    displayPing();
  }

  //draws the background of the boss fight
  private void displayBackground()
  {
    fill (Colors.DARK_GREEN);
    for ( int i =0; i < gamefield.GAMEFIELD_WIDTH/ (BACKGROUND_LINE_SIZE*2); i++ )
    {
      println(gamefield.GAMEFIELD_WIDTH / BACKGROUND_LINE_SIZE *2);
      rect(BACKGROUND_LINE_SIZE * i * 2, height/2 - BACKGROUND_LINE_SIZE/2, BACKGROUND_LINE_SIZE, BACKGROUND_LINE_SIZE);
    }
  }

  //draws the Boss
  private void displayPing()
  {
    fill(Colors.DARK_GREEN);
    rect(x, y, bossWidth, bossHeight);
  }

  private void countdown() {
    if (damageTimer>=0) {
      damageTimer--;
    }
  }
  public float getX() { 
    return x;
  }
  public float getY() { 
    return y;
  }
  public float getWidth() {
    return bossWidth;
  }
  public float getHeight() {
    return bossHeight;
  }
}
