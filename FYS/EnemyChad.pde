/*
deze class bevat chad.
 comments over de @Override methodes staan in Enemy base-class.
 chad accelerates towards the player 
 
 Eele Roet 500795948
 */

class EnemyChad extends Enemy
{
  float speedX;
  float speedY;
  float accelX;
  float accelY;
  float spawnChance;
  float spawnRate;

  EnemyChad(float x, float y, float hitboxRadius)
  {
    super(false, x, y, hitboxRadius);
    speedY = 1;
    speedX = 1;
    damageToDeal = 30;
    spawnRate = 0.15;
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

  void move()
  {
    speedX += accelX / 5;
    speedY += accelY / 5;

    if ( speedX > 3 )
    {
      speedX = 3;
    } else if ( speedX < -3)
    {
      speedX = -3;
    }

    if ( speedY > 3 )
    {
      speedY = 3;
    } else if ( speedY < -3)
    {
      speedY = -3;
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
    Rectangles hitboxesToCheck = player.getHitboxes();
    Rectangle hitboxToFollow;
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
    active = false;
    x = EnemyFinals.ENEMY_GRAVEYARD_X;
    y = EnemyFinals.ENEMY_GRAVEYARD_Y;
  }

  @Override void explode()
  {
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
        noStroke();
        fill(EnemyFinals.CHAD_COLOR);
        ellipse(x, y, hitboxDiameter, hitboxDiameter);
      }
    }
  }
