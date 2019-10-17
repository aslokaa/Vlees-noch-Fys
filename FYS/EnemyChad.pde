/*
deze class bevat chad.
 
 Eele Roet 500795948
 */

class EnemyChad extends Enemy
{
  float speedX;
  float speedY;
  float accelX;
  float accelY;

  EnemyChad(float x, float y, float hitboxRadius)
  {
    super(true, x, y, hitboxRadius);
    speedY = 0;
    speedX = 0;
    damageToDeal = 50;
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
    speedX += accelX / 10;

    speedY += accelY / 10;

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
    } else if ( x + hitboxRadius > width )
    {
      x = width - hitboxRadius;
    }
  }

  @Override void handlePlayerCollision(Rectangles rectangles)
  {
    if ( checkPlayerCollision(rectangles.rectangle0) ) 
    {
      player.dealDamage(damageToDeal, false);
    }
    if ( checkPlayerCollision(rectangles.rectangle1) ) 
    {
      player.dealDamage(damageToDeal, true);
    }
  }

  void setAccelTowardsPlayer()
  {
    accelX = dist( x, y, player.x, y ) / (dist( x, y, player.x, y ) + dist( x, y, x, player.y )) ;
    accelY = 1 - accelX;

    if ( x > player.x )
    {
      accelX *= -1;
    }
    if ( y > player.y ) 
    {
      accelY *= -1;
    }
    //get angle to player
    //translate angle to x and y acceleration.
  }

 
  @Override void destroy()
  {
    active = false;
  }

  @Override void explode()
  {
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
