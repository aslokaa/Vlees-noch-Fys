/*
 deze class bevat dave.
 comments over de @Override methodes staan in Enemy base-class.
 dave word boven y = 100 gespawned, dus alle y < 100.
 dave beweegt tot de eerste row op y is 100, dave gaat dan alleen in de x bewegen
 totdat hij een muur raakt dan gaat hij een row naar beneden, dus y 200 en gaat in de andere richting 
 in x bewegen. etc.
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

  EnemyDave(float x, float y, float hitboxRadius)
  {
    super(false, x, y, hitboxRadius);
    damageToDeal = 50;
    moveSpeedLeft = -3;
    moveSpeedRight = 3;
    moveSpeedDown = 3;
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
      handlePlayerCollision( player.getHitboxes() );
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
    if ( y - hitboxRadius > height)
    {
     active = false; 
    }
  }

  void checkWallCollision()
  {
    if ( x - hitboxRadius < 0 )
    {
      rowToMoveTo++;
      x = hitboxRadius;
    } else if ( x + hitboxRadius > gamefield.GAMEFIELD_WIDTH )
    {
      rowToMoveTo++;
      x = gamefield.GAMEFIELD_WIDTH - hitboxRadius;
    }
  }

  void checkRow()
  {
    if ( currentRow < rowToMoveTo )
    {
      if ( y >= EnemyFinals.DAVE_GRID_HEIGHT * rowToMoveTo )
      {
        currentRow++;
        y = EnemyFinals.DAVE_GRID_HEIGHT * rowToMoveTo;
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
    spawnPowerup();
    explode();
    active = false;
    x = EnemyFinals.ENEMY_GRAVEYARD_X;
    y = EnemyFinals.ENEMY_GRAVEYARD_Y;
    
  }
  
 @Override void activate(float posX, float posY)
  {
     x = posX;
     y = posY;
     active = true;
     currentRow = 0;
     rowToMoveTo = 1;
  }

  void setXSpeed()
  {
    if ( x >= gamefield.GAMEFIELD_WIDTH / 2 )
    {
      moveLeft = true;
    } else
    {
      moveRight = true;
    }
  }

@Override void spawnPowerup()
{
 float spawnChance = random(0, 1);
  for ( Power power : powers )
  {
   if ( !power.powerActive )
   {
    if ( spawnChance <= 0.001 )
    {

     int dropType = round(random(0, PowerUpTypes.SPLIT));
     power.drop(x, y, dropType);
    
     return;
    }
   }
  }
  
}
  @Override void display()
  {
    if ( active )
    {
      noStroke();
      fill(EnemyFinals.DAVE_COLOR);
      ellipse(x, y, hitboxDiameter, hitboxDiameter);
    }
  }
}
