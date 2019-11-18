class EnemyBullet
{
  boolean active = false;
  float x;
  float y;
  float speedX;
  float speedY; 
  float bulletSpeed;
  final float DIAMETER = 30;
  final float RADIUS = DIAMETER /2;
  final float START_X = -100;
  final float START_Y = -100;

  EnemyBullet()
  {
    x = START_X;
    y = START_Y;
    bulletSpeed = 3;
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
    
  }

  void checkIfOutField()
  {
    if ( x < 0 || x > gamefield.GAMEFIELD_WIDTH || y > height )
    {
      active = false;
    }
  }

  void shoot(float x, float y, float angle, float speed)
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
