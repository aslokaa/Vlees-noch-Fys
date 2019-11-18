class EnemyBullet
{
  boolean active = false;
  float x;
  float y;
  float speedX;
  float speedY; 
  float speed;
  final float DAMAGE_TO_DEAL;
  final float DIAMETER = 30;
  final float RADIUS = DIAMETER /2;
  final float START_X = -100;
  final float START_Y = -100;
  Rectangles hitboxesToCheck;

  EnemyBullet()
  {
    x = START_X;
    y = START_Y;
    speed = 3;
    DAMAGE_TO_DEAL = 20;
  }


  void update()
  {
    if ( active )
    {
      move();
      handlePlayerCollision();
      checkIfOutField();
    }
  }

  void move()
  {
    x += speedX;
    y += speedY;
  }

  void handlePlayerCollision()
  {
    hitboxesToCheck = player.getHitboxes();
    if ( hitboxesToCheck.rectangle1.exists )
    {
      if ( x > hitboxesToCheck.rectangle0.x && x < hitboxesToCheck.rectangle0.x + ( hitboxesToCheck.rectangle0.rectangleWidth  / 2 ) &&
           y > hitboxesToCheck.rectangle0.y && y < hitboxesToCheck.rectangle0.y + ( hitboxesToCheck.rectangle0.rectangleHeight / 2 ))
      {
        active = false;
        player.dealDamage(DAMAGE_TO_DEAL, false);
      }
    }
    if ( hitboxesToCheck.rectangle0.exists )
    {
      if ( x > hitboxesToCheck.rectangle1.x && x < hitboxesToCheck.rectangle1.x + ( hitboxesToCheck.rectangle1.rectangleWidth  / 2 ) &&
           y > hitboxesToCheck.rectangle1.y && y < hitboxesToCheck.rectangle1.y + ( hitboxesToCheck.rectangle1.rectangleHeight / 2 ))
      {
        active = false;
        player.dealDamage(DAMAGE_TO_DEAL, true);
      }
    }
  }

  void checkIfOutField()
  {
    if ( x < 0 || x > gamefield.GAMEFIELD_WIDTH || y > height )
    {
      active = false;
    }
  }

  void shoot(float x, float y, float angle)
  {   
    active = true;
    // Start the bullet at the player position
    this.x = x;
    this.y = y;
    // the vertical velocity is 10
    speedX = speed * sin(angle);
    speedY = speed * -cos(angle);
  }

  void display()
  {
    if (active)
    {
      fill(Colors.WHITE);
      ellipse(x, y, RADIUS, RADIUS);
    }
  }
}
