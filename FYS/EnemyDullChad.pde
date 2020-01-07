/*
deze class bevat chad.
 comments over de @Override methodes staan in Enemy base-class.
 chad accelerates towards the player by a set amount, chad has wall collision, 
 chad bounces off the player in the y axis when he deals damage. 
 
 Eele Roet 500795948
 */

class EnemyDullChad extends Enemy
{
  //movement info
  float speedX;
  float speedY;
  float accelX;
  float accelY;
  float maxSpeed;
  PVector pointToFollow = new PVector();
  int switchFollow;
  //sprite info
  float angleToPlayer;
  //powerUp info
  float spawnChance;
  float spawnRate;
  //particle info

  EnemyDullChad(float x, float y, float hitboxRadius)
  {
    super(false, x, y, hitboxRadius);
    angleToPlayer = 0;
    speedY = 1;
    speedX = 1;
    damageToDeal = 30;
    spawnRate = 0.15;
    maxSpeed = 4;
    pointToFollow.x = 0;
    pointToFollow.y = 0;
    switchFollow = 60;
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
    if ( y > height ) 
    {
      y = height;
    }
  }




  void setAccelTowardsPlayer()
  {
    checkPointToFollow();

    accelX = dist( x, y, pointToFollow.x, y ) / 
      (dist( x, y, pointToFollow.x, y ) + dist( x, y, x, pointToFollow.y )) ;
    accelY = 1 - accelX;

    if ( x > pointToFollow.x )
    {
      accelX *= -1;
    }
    if ( y > pointToFollow.y ) 
    {
      accelY *= -1;
    }
  }

  void checkPointToFollow()
  {
    if ( frameCount % switchFollow == 0 )
    {
      pointToFollow.x = random(0, gamefield.GAMEFIELD_WIDTH);
      pointToFollow.y = random(0, gamefield.PLAYER_MIN_Y / 2);
    }
  }


  @Override void destroy()
  {
    explode();
    active = false;
    gamefield.scorePlus = 100;
    gamefield.scoreCounter = gamefield.scoreCounter + gamefield.scorePlus;
    gamefield.chadsAlive = gamefield.chadsAlive - 1;
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
    translate(x, y);
    angleToPlayer = atan2(pointToFollow.y - y, pointToFollow.x  - x) - PI / 2;
    rotate(angleToPlayer);
    image(enemyChadThrusterImg, 0, -hitboxRadius * 1.6, 75, 75);
    rotate(-angleToPlayer);
    translate(-x, -y);
  }
}
