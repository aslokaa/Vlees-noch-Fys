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
  float moveSpeed;
  boolean moveLeft;
  boolean moveRight;
  boolean moveDown;
  int currentRow;
  int rowToMoveTo;
  //powerUp info
  float spawnRate;
  float spawnChance;
  Power powerToSpawn;
  //particle info


  EnemyDave(float x, float y, float moveSpeed, float hitboxRadius)
  {
    super(false, x, y, hitboxRadius);
    damageToDeal = 50;
    this.moveSpeed = moveSpeed;
    moveLeft = false;
    moveRight = false;
    moveDown = false;
    currentRow = 0;
    rowToMoveTo = 1;
    spawnRate = 0.2;
    EXPLOSION_PARTICLES = 50;
    destroyed = false;
    destroyCounter = 0;
  }

  @Override void executeBehavior()
  {
    if ( active )
    {
      if ( !destroyed )
      {
        move();//kijkt naar move booleans, zet snelheden, telt snelheid op bij positie.
        checkWallCollision();//als dave een muur raakt beweegt hij een row naar beneden
        handlePlayerCollision( player.getHitboxes() );
        checkRow();//als dave bij de volgende row komt gaat hij op de x bewegen.
      } else
      {
        fall();
        updateCounters();
      }
    }
  }

  void move()
  {
    if ( moveRight )
    {
      speedX = moveSpeed;
    } else if ( moveLeft )
    {
      speedX = -moveSpeed;
    } else
    {
      speedX = 0;
    }

    if ( moveDown )
    {
      speedY = moveSpeed;
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

  void fall()
  {
   speedX += random(-0.5, 0.5);
   speedY += fallSpeed;
   fallRotationAngle += fallRotation;
   x += speedX;
   y += speedY;
  }

  void updateCounters()
  {
    destroyCounter--;
    if ( destroyCounter < 0)
    {
      println("iii");
      active = false;
      x = EnemyFinals.ENEMY_GRAVEYARD_X;
      y = EnemyFinals.ENEMY_GRAVEYARD_Y;
    }
  }

  @Override void destroy()
  {
    spawnPowerup();
    explode();
    totalEnemiesKilled++;
    destroyed = true;
    screenScore.updateScore(x, y);
    gamefield.scorePlus = 100;
    gamefield.scoreCounter = gamefield.scoreCounter + gamefield.scorePlus;
    gamefield.scorePlus = 100;
    gamefield.scoreCounter = gamefield.scoreCounter + gamefield.scorePlus;
    gamefield.davesKilled = gamefield.davesKilled + 1;
    gamefield.setDaveMoveSpeed();
    destroyCounter = DESTROY_COUNTER;
    fallSpeed = random(0.05, 0.2);
    fallRotation = random ( -0.2, 0.2);
  }

  @Override void activate(float posX, float posY)
  {
    x = posX;
    y = posY;
    active = true;
    currentRow = 0;
    rowToMoveTo = 1;
    moveSpeed = gamefield.daveSpeed;
    destroyed = false;
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

  @Override void setMoveSpeed(float newSpeed)
  {
    moveSpeed = newSpeed;
  }

  @Override void spawnPowerup()
  {
    //only one powerup at the time, no bullets if bullet count is over 10, less chance for hp if playerWidth is big, no bullets before round 4.
    int dropType = 0;
    spawnChance = random(0, 1);
    for ( Power power : powers )
    {
      if ( !power.powerActive )
      {
        if ( spawnChance <= player.getPowerUpChance() )
        {
          dropType = round(random(PowerUpTypes.IMMUNE, PowerUpTypes.SPLIT));
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
      if ( !destroyed )
      {
        image(enemyDaveImg, x, y, hitboxDiameter, hitboxDiameter);
      } else
      {
        pushMatrix();
        translate( x, y );
        rotate(fallRotationAngle);
        image(enemyDaveImg, 0, 0, hitboxDiameter, hitboxDiameter);
        noStroke();
        fill(0,0,0,map((DESTROY_COUNTER - destroyCounter), 0, 150, 30, 255));
        ellipse(0,0,hitboxDiameter * 1.1, hitboxDiameter * 1.1);
        rotate( -fallRotationAngle );
        translate( -x, -y );
        popMatrix();
        
        
      }
    }
  }
}
