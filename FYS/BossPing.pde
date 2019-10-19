//Niklas Leeuwin
//500784205
//some things have been copied from the Player class.

//This is the class that handles the ping boss. It's like playing pong
class BossPing
{
  float 
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
  final float
    BOSS_START_WIDTH              = player.PLAYER_START_WIDTH, 
    BOSS_START_HEIGHT             = player.PLAYER_START_HEIGHT, 
    BOSS_START_X                  = width/2-BOSS_START_WIDTH/2, 
    BOSS_START_Y                  = 0+BOSS_START_HEIGHT, 
    BOSS_START_ACCELERATION_X     = player.PLAYER_START_ACCELERATION_X, 
    BOSS_VELOCITY_X_MAX           = player.PLAYER_VELOCITY_X_MAX, 
    BOSS_START_DECELERATE_X       = player.PLAYER_START_DECELERATE_X, 
    BOSS_START_ACCELERATION_Y     = player.PLAYER_START_ACCELERATION_Y, 
    BOSS_VELOCITY_Y_MAX           = player.PLAYER_VELOCITY_Y_MAX, 
    BOSS_START_DECELERATE_Y       = player.PLAYER_START_DECELERATE_Y;

  BossPing()
  {
    x                   = BOSS_START_X;
    y                   = BOSS_START_Y;
    velocityX           = 0; 
    velocityY           = 0; 
    accelerationX       = BOSS_START_ACCELERATION_X; 
    accelerationY       = BOSS_START_ACCELERATION_Y;
    decelerateX         = BOSS_START_DECELERATE_X;
    decelerateY         = BOSS_START_DECELERATE_Y;
    bossWidth           = BOSS_START_WIDTH;
    bossHeight          = BOSS_START_HEIGHT;
    closestBallX        = 0;
    closestBallY        = 0;
  }

  void update()
  {
    detectNearestBall();
    accelerate();
    decelerate();
    checkVelocityMax();
    move();
  }

  //locates the nearest ball.
  void detectNearestBall()
  {
    float closestBallXT = -10000;
    float closestBallYT = -10000;
    for (Ball ball : balls) 
    {
      float xT = ball.x;
      float yT = ball.y;
      if (dist(x, y, xT, yT)<dist(x, y, closestBallXT, closestBallYT))
      {
        closestBallXT = xT;
        closestBallYT = yT;
      }
    }
    closestBallX = closestBallXT;
    closestBallY = closestBallYT;
  }

  //checks if the ball is to the right of the boss.
  boolean isBallRight()
  {
    return closestBallX>x;
  }

  //checks if the ball is below the boss.
  boolean isBallDown()
  {
    return closestBallY>y;
  }

  //accelerates the boss.
  void accelerate()
  {
    //X
    if (isBallRight())
    {
      velocityX+= accelerationX;
    } else
    {
      velocityX-= accelerationX;
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
  void decelerate()
  {
    velocityX *= decelerateX;
    velocityY *= decelerateY;
  }

  //makes sure the boss doesn't go too fast
  void checkVelocityMax()
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
  void move()
  {
    x += velocityX;
    y += velocityY;
  }
}
