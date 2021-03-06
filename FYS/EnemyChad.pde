/*
deze class bevat chad.
 comments over de @Override methodes staan in Enemy base-class.
 chad accelerates towards the player by a set amount, chad has wall collision, 
 chad bounces off the player in the y axis when he deals damage. 
 
 Eele Roet 500795948
 */

class EnemyChad extends Enemy
{
  //movement info
  float speedX;
  float speedY;
  float accelX;
  float accelY;
  float maxSpeed;
  Rectangle hitboxToFollow;
  //sprite info
  float angleToPlayer;
  //powerUp info
  float spawnChance;
  float spawnRate;
  //particle info

  EnemyChad(float x, float y, float hitboxRadius)
  {
    super(false, x, y, hitboxRadius);
    angleToPlayer = 0;
    speedY = 1;
    speedX = 1;
    damageToDeal = 30;
    spawnRate = 0.15;
    maxSpeed = 4;
    EXPLOSION_PARTICLES = 50;
  }

  @Override void executeBehavior()
  {
    if ( active )
    {
      move();
      checkWallCollision();//als chad een muur raakt stopt hij met bewegen in die richting.
      handlePlayerCollision(player.getHitboxes());
      setAccelTowardsPlayer();//sets speeds so that chad accelerates towards the player.
    }
  }

  void move()//adds acceleration to speed and speed to position, also handles maximum speed.
  {
    speedX += accelX / 4;
    speedY += accelY / 4;

    if ( speedX > maxSpeed )
    {
      speedX = maxSpeed;
    } else if ( speedX < -maxSpeed)
    {
      speedX = -maxSpeed;
    }

    if ( speedY > maxSpeed )
    {
      speedY = maxSpeed;
    } else if ( speedY < -maxSpeed)
    {
      speedY = -maxSpeed;
    }
    x += speedX;
    y += speedY;
  }

  void checkWallCollision()
  {
    if ( x - hitboxRadius < 0 )
    {

      x = hitboxRadius;
    } else if ( x + hitboxRadius > gamefield.GAMEFIELD_WIDTH )
    {
      x = gamefield.GAMEFIELD_WIDTH - hitboxRadius;
    }
    if ( y > gamefield.GAMEFIELD_HEIGHT ) 
      gamefield.scoreDamage = 200;

  }

  @Override void handlePlayerCollision(Rectangles rectangles)
  {
    if ( !player.shake && checkPlayerCollision(rectangles.rectangle0)) 
    {
      player.dealDamage(damageToDeal, false);
      speedY *= -1.3;
      speedY += ( y < rectangles.rectangle1.y + rectangles.rectangle0.rectangleHeight / 2 ? -abs(player.velocityY) : abs(player.velocityY));
      y = rectangles.rectangle0.y + rectangles.rectangle0.rectangleHeight / 2 + ( y < rectangles.rectangle0.y + rectangles.rectangle0.rectangleHeight / 2 ? -rectangles.rectangle0.rectangleHeight : rectangles.rectangle0.rectangleHeight );
    }
    if ( !player.shake && checkPlayerCollision(rectangles.rectangle1) && rectangles.rectangle1.exists) 
    {
      player.dealDamage(damageToDeal, true);

      speedY *= -1.3;
      speedY += ( y < rectangles.rectangle1.y ? -abs(player.velocityY) : abs(player.velocityY));
      y = rectangles.rectangle1.y + rectangles.rectangle1.rectangleHeight / 2 + ( y < rectangles.rectangle1.y + rectangles.rectangle1.rectangleHeight / 2 ? -rectangles.rectangle0.rectangleHeight : rectangles.rectangle0.rectangleHeight );
    }
  }

  void setAccelTowardsPlayer()
  {
    Rectangles hitboxesToCheck = player.getHitboxes();

    if ( hitboxesToCheck.rectangle1.exists )
    {
      if ( dist( x, y, hitboxesToCheck.rectangle0.x, hitboxesToCheck.rectangle0.y) < dist( x, y, hitboxesToCheck.rectangle1.x, hitboxesToCheck.rectangle1.y) )
      {
        hitboxToFollow = hitboxesToCheck.rectangle0;
      } else
      {
        hitboxToFollow = hitboxesToCheck.rectangle1;
      }
    } else
    {
      hitboxToFollow = hitboxesToCheck.rectangle0;
    }

    accelX = dist( x, y, hitboxToFollow.x + ( hitboxToFollow.rectangleWidth / 2 ), y ) / 
      (dist( x, y, hitboxToFollow.x + ( hitboxToFollow.rectangleWidth / 2 ), y ) + dist( x, y, x, hitboxToFollow.y )) ;
    accelY = 1 - accelX;

    if ( x > hitboxToFollow.x + ( hitboxToFollow.rectangleWidth / 2 ) )
    {
      accelX *= -1;
    }
    if ( y > hitboxToFollow.y ) 
    {
      accelY *= -1;
    }
  }


  @Override void destroy()
  {
    explode();
    totalEnemiesKilled++;
    active = false;
    screenScore.updateScore(x, y);
    gamefield.scorePlus = 100;
    gamefield.scoreCounter = gamefield.scoreCounter + gamefield.scorePlus;
    gamefield.chadCounter = gamefield.chadCounter - 1;
    x = EnemyFinals.ENEMY_GRAVEYARD_X;
    y = EnemyFinals.ENEMY_GRAVEYARD_Y;
  }



  @Override void spawnPowerup()
  {
    spawnChance = random(0, 1);
    for ( Power power : powers )
    {
      if ( !power.powerActive )
      {
        if ( spawnChance <= spawnRate )
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
      displayThruster();
      image(enemyChadImg, x, y, hitboxDiameter, hitboxDiameter);
    }
  }

  void displayThruster()
  {
    pushMatrix();
    translate(x, y);
    angleToPlayer = atan2((hitboxToFollow.y + hitboxToFollow.rectangleHeight / 2) - y, (hitboxToFollow.x + hitboxToFollow.rectangleWidth / 2) - x) - PI / 2;
    rotate(angleToPlayer);
    image(enemyChadThrusterImg, 0, -hitboxRadius * 1.6, 75, 75);
    rotate(-angleToPlayer);
    translate(-x, -y);
    popMatrix();
  }
}
