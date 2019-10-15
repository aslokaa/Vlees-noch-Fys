/*
deze class bevat dave.
 dave word boven y = 100 gespawned, dus alle y < 100.
 dave beweegt tot de eerste row op y is 100, dave gaat dan alleen in de x bewegen
 totdat hij een muur raakt dan gaat hij een row naar beneden, dus y 200 en gaat in de andere richting 
 in x bewegen. etc.
 Eele Roet 500795948
 */

class EnemyDave extends Enemy
{
  boolean active = true;
  float moveSpeedLeft;
  float moveSpeedRight;
  float moveSpeedDown;
  boolean moveLeft;
  boolean moveRight;
  boolean moveDown;
  int currentRow;
  int rowToMoveTo;

  EnemyDave(float x, float y, float hitboxRadius)
  {
    super(x, y, hitboxRadius);
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
    if ( active )
    {
      move();//kijkt naar move booleans, zet snelheden, telt snelheid op bij positie.
      checkWallCollision();//als dave een muur raakt beweegt hij een row naar beneden
      checkRow();//als dave bij de volgende row komt gaat hij op de x bewegen.
    }
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
    if ( x - hitboxRadius < 0 )
    {
      rowToMoveTo++;
      x = hitboxRadius;
    } else if ( x + hitboxRadius > width )
    {
      rowToMoveTo++;
      x = width - hitboxRadius;
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

  @Override void destroy()
  {
    active = false;
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
    if ( active )
    {
      noStroke();
      fill(DAVE_COLOR);
      ellipse(x, y, hitboxDiameter, hitboxDiameter);
    }
  }
}
