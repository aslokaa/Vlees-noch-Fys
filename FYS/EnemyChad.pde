/*
deze class bevat chad.

Eele Roet 500795948
*/

class EnemyChad extends Enemy
{
  float SpeedX;
  float SpeedY;

  EnemyChad(float x, float y, float hitboxRadius)
  {
    super(x, y, hitboxRadius);
    SpeedY = 0;
    SpeedX = 0;
  }

  @Override void executeBehavior()
  {
    checkWallCollision();//als chad een muur raakt stopt hij met bewegen in die richting.
    moveToPlayer();//sets speeds so that chad accelerates towards the player.
  }

  void moveToPlayer()
  {
  }

  void move()
  {
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

  @Override void display()
  {
    noStroke();
    fill(CHAD_COLOR);
    ellipse(x, y, hitboxDiameter, hitboxDiameter);
  }
}
