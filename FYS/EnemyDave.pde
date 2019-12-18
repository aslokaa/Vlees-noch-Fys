/*
 this class contains dave.
 comments about the @Override methodes are in the Enemy base-class.
 dave dave is spawned at  y < 100.
 dave moves vertically down untill he hits y >= 100, dave then moves horizontally towards the furthest wall. 
 when he hits this wall he moves down a row ( y >= 200 ) and start moving horizontally towards the other wall. 
 untill he hits y >= height.
 Eele Roet 500795948
 */

class EnemyDave extends Enemy
{
  //movement
  float moveSpeedLeft;
  float moveSpeedRight;
  float moveSpeedDown;
  boolean moveLeft;
  boolean moveRight;
  boolean moveDown;
  int currentRow;
  int rowToMoveTo;
  //powerUp info
  float spawnRate;
  float spawnChance;
  //particle info


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
    spawnRate = 0.2;
    EXPLOSION_PARTICLES = 50;
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
      player.dealDamage(damageToDeal, false);
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
    screenScore.updateScore(x, y);
    score = score + 100;
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

  void setSpeeds(float newSpeed)
  {
    moveSpeedLeft = -newSpeed;
    moveSpeedRight = newSpeed;
    moveSpeedDown = newSpeed;
  }

  @Override void spawnPowerup()
  {
    spawnChance = random(0, 1);
    for ( Power power : powers )
    {
      if ( !power.powerActive )
      {
        if ( spawnChance <= player.getPowerUpChance() )
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
      image(enemyDaveImg, x, y, hitboxDiameter, hitboxDiameter);
    }
  }
}
