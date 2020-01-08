//Niklas Leeuwin
//500784205
//some things have been copied from the Player class.

//This is the class that handles the ping boss. It's like playing pong
class BossPing extends Paddle
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
    paddleWidth, 
    paddleHeight, 
    closestBallX, 
    closestBallY;
  private int
    health, 
    damageTimer;
  private final float
    START_WIDTH                   = gamefield.GAMEFIELD_WIDTH*0.16, 
    START_HEIGHT                  = height * 0.045, 
    START_X                       = gamefield.GAMEFIELD_WIDTH/2-START_WIDTH/2, 
    START_Y                       = START_HEIGHT, 
    START_ACCELERATION_X          = gamefield.GAMEFIELD_WIDTH * 0.0015, 
    VELOCITY_X_MAX                = gamefield.GAMEFIELD_WIDTH * 0.01, 
    START_ACCELERATION_Y          = height * 0.0015, 
    VELOCITY_Y_MAX                = height * 0.012, 
    MAX_Y                         = height *0.3, 
    BALL_IS_CLOSE                 = START_WIDTH*0.3, 
    TEXT_SIZE                     = height*0.1, 
    BACKGROUND_LINE_SIZE          = gamefield.GAMEFIELD_WIDTH*0.01, 
    HEALTH_TEXT_X                 = gamefield.GAMEFIELD_WIDTH*0.94, 
    HEALTH_TEXT_Y                 = height * 0.4, 
    START_DECELERATE_X            = 0.8, 
    START_DECELERATE_Y            = 0.8;
  public final int
    DAMAGE_TIMER                  = 10, 
    START_HEALTH                  = 4;
  public BossPing()
  {
    x                   = START_X;
    y                   = START_Y;
    accelerationX       = START_ACCELERATION_X; 
    accelerationY       = START_ACCELERATION_Y;
    decelerateX         = START_DECELERATE_X;
    decelerateY         = START_DECELERATE_Y;
    paddleWidth           = START_WIDTH;
    paddleHeight          = START_HEIGHT;
    health              = START_HEALTH;
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
        if (dist(x + paddleWidth/2, y + paddleHeight/2, xT, yT)<dist(x + paddleWidth/2, y + paddleHeight/2, closestBallXT, closestBallYT))
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
    return closestBallX>x + paddleWidth/2;
  }

  //checks if the ball is below the boss.
  private boolean isBallDown()
  {
    return closestBallY>y + paddleHeight;
  }

  private boolean isBallCloseX()
  {
    return closestBallX+BALL_IS_CLOSE>x+paddleWidth/2 && closestBallX-BALL_IS_CLOSE<x+paddleWidth/2;
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
    if (shouldDecelerate()) {
      velocityX *= decelerateX;
      velocityY *= decelerateY;
    }
  }

  private boolean shouldDecelerate() {
    for (Ball ball : balls) {
      if (ball.y<MAX_Y*2) {
        return false;
      }
    }
    return true;
  }

  //makes sure the boss doesn't go too fast
  private void checkVelocityMax()
  {
    if (velocityX > VELOCITY_X_MAX)
    {
      velocityX = VELOCITY_X_MAX;
    } else if (velocityX < -VELOCITY_X_MAX)
    {
      velocityX = -VELOCITY_X_MAX;
    }
    if (velocityY > VELOCITY_Y_MAX)
    {
      velocityY = VELOCITY_Y_MAX;
    } else if (velocityY < -VELOCITY_Y_MAX)
    {
      velocityY = -VELOCITY_Y_MAX;
    }
  }

  //moves the boss
  void move()
  {
    x += velocityX;
    y += velocityY;
  }

  //Prevents the boss from going out of bounds
  private void detectCollisionEdge() 
  {
    if ( y < 0 )
    {
      y = 0;
      velocityY *= -1;
    }
    if ( y + paddleHeight > MAX_Y )
    {
      y = MAX_Y - paddleHeight;
      velocityY *= -1;
    }
    if ( x < 0 )
    {
      x = 0;
      velocityX = 0;
    }
    if ( x + paddleWidth > gamefield.GAMEFIELD_WIDTH )
    {
      x = gamefield.GAMEFIELD_WIDTH - paddleWidth;
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
    damageTimer=DAMAGE_TIMER;
    if ( health <= 0 )
    {
      killPing();
    }
  }


  //removes Ping from the game
  public void killPing()
  {
    stateBossPing=false;
    gamefield.scorePlus = 1000;
    gamefield.scoreCounter = gamefield.scoreCounter + gamefield.scorePlus;
    achievement.increaseProgress(AchievementID.PING_PONG);
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
    textSize(TEXT_SIZE);
    text(health, HEALTH_TEXT_X, HEALTH_TEXT_Y);
    for ( int i =0; i < gamefield.GAMEFIELD_WIDTH/ (BACKGROUND_LINE_SIZE*2); i++ )
    {
      rect(BACKGROUND_LINE_SIZE * i * 2, height/2 - BACKGROUND_LINE_SIZE/2, BACKGROUND_LINE_SIZE, BACKGROUND_LINE_SIZE);
    }
  }

  //draws the Boss
  private void displayPing()
  {
    fill(Colors.DARK_GREEN);
    rect(x, y, paddleWidth, paddleHeight);
  }

  @Override
    //counts insert
    void countdown() {
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
    return paddleWidth;
  }
  public float getHeight() {
    return paddleHeight;
  }
  public boolean checkCollision(float xT, float yT, float diameterT) {
    return y>yT+diameterT && dist(xT, yT, x, y) < (paddleWidth +(diameterT/2)) ;
  }
}
