/*
deze class bevat dave.

Eele Roet 500795948
*/

class EnemyDave extends Enemy
{
  float moveSpeedLeft;
  float moveSpeedRight;
  float moveSpeedDown;
  boolean moveLeft;
  boolean moveRight;
  boolean moveDown;
  int currentRow;
  int rowToMoveTo;

  EnemyDave(float x, float y)
  {
    super(x, y);
    moveSpeedLeft = -5;
    moveSpeedRight = 5;
    moveSpeedDown = 5;
    moveLeft = false;
    moveRight = false;
    moveDown = false;
    currentRow = 0;
    rowToMoveTo = 1;
  }

  @Override void executeBehavior()
  {
    checkWallCollision();
    checkRow();
    move();
  }



  void move()
  {
    if ( moveRight )
    {
      speedX = moveSpeedRight;
    } else if ( moveLeft )
    {
      speedX = moveSpeedLeft;
    } else
    {
      speedX = 0;
    }

    if ( moveDown )
    {
      speedY = moveSpeedDown;
    } else
    {
      speedY = 0;
    }

    x += speedX;
    y += speedY;
  }

  void checkWallCollision()
  {
    if ( x - DAVE_HITBOX_RADIUS < 0 )
    {
      rowToMoveTo++;
      x = DAVE_HITBOX_RADIUS;
    } else if ( x + DAVE_HITBOX_RADIUS > width )
    {
      rowToMoveTo++;
      x = width - DAVE_HITBOX_RADIUS;
    }
  }

  void checkRow()
  {
    if ( currentRow < rowToMoveTo )
    {
      if ( y >= DAVE_GRID_HEIGHT * rowToMoveTo )
      {
        currentRow++;
        y = DAVE_GRID_HEIGHT * rowToMoveTo;
        setXSpeed();
        moveDown = false;
      } else
      {
        moveRight = false;
        moveLeft = false;
        moveDown = true;
      }
    }
  }

  void setXSpeed()
  {
    if ( x >= width / 2 )
    {
      moveLeft = true;
    } else
    {
      moveRight = true;
    }
  }

  @Override void display()
  {
    noStroke();
    fill(DAVE_COLOR);
    ellipse(x, y, DAVE_HITBOX_DIAMETER, DAVE_HITBOX_DIAMETER);
  }
}
