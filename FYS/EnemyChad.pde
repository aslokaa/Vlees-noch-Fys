/*
deze class bevat chad.

Eele Roet 500795948
*/

class EnemyChad extends Enemy
{
  float moveSpeedX;
  float moveSpeedY;

  EnemyChad(float x, float y)
  {
    super(x, y);
    moveSpeedY = 0;
    moveSpeedX = 0;
  }

  @Override void executeBehavior()
  {
    checkWallCollision();//als chad een muur raakt stopt hij met bewegen in die richting.
    move();//kijkt naar move booleans, zet snelheden, telt snelheid op bij positie.  
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
        setXSpeed();//als dave aan de linker kant van het veld staat gaat hij naar rechts bewegen en andersom
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
