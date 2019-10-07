/*
deze class bevat dave.
dave word boven y = 100 gespawned, dus alle y < 100.
dave beweegt tot de eerste row op y is 100, dave gaat dan alleen in de x bewegen
totdat hij een muur raakt dan gaat hij een row naar beneden, dus y 200 en gaat in de andere richting 
in x bewegen.
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
    checkWallCollision();//als dave een muur raakt beweegt hij een row naar beneden
    checkRow();//als dave bij de volgende row komt gaat hij op de x bewegen.
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
