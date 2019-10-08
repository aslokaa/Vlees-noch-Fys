/*
deze class bevat chad.

Eele Roet 500795948
*/

class EnemyChad extends Enemy
{
  float moveSpeedX;
  float moveSpeedY;

  EnemyChad(float x, float y, float hitboxRadius)
  {
    super(x, y, hitboxRadius);
    moveSpeedY = 0;
    moveSpeedX = 0;
  }

  @Override void executeBehavior()
  {
    checkWallCollision();//als chad een muur raakt stopt hij met bewegen in die richting.
    moveToPlayer();//sets
  }

  void moveToPlayer()
  {
    
  };

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
    fill(DAVE_COLOR);
    ellipse(x, y, hitboxDiameter, hitboxDiameter);
  }
}
