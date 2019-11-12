class EnemyBullet
{
  boolean active = false;
  float x;
  float y;
  float speedX;
  float speedY; 
  final float DIAMETER = 20;
  final float RADIUS = DIAMETER /2;
  final float START_X = -100;
  final float START_Y = -100;

  EnemyBullet()
  {
    x = START_X;
    y = START_Y;
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

  void shoot(float x, float y, float speedX, float speedY)
  {
    this.x = x;
    this.y = y;
    this.speedX = speedX;
    this.speedY = speedY;
    this.active = true;
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
