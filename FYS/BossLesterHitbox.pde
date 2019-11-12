class BossLesterHitbox
{
  float x;
  float y;
  int HP;
  boolean active;
  final float HITBOX_DIAMETER = 75;
  final float HITBOX_RADIUS = HITBOX_DIAMETER / 2;
  final int STARTING_HP = 4;

  BossLesterHitbox(float x, float y)
  {
    this.x = x;
    this.y = y;
    this.active = true;
    this.HP = STARTING_HP;
  }

  void update()
  {
    if ( active )
    {
     // setPosition(x, y);
     handleBulletCollision();
    }
  }

  void setPosition(float x, float y)
  {
    this.x = x;
    this.y = y;
  }
  
  void handleBulletCollision()
  {
    for ( PlayerBullet bullet : playerBullets )
    {
     if( bullet.shootBullet && dist(bullet.bulletX, bullet.bulletY, x, y) < (HITBOX_RADIUS + (bullet.bulletDiameter/2)))
     {
       bullet.shootBullet = false;
       HP--;
     }
    }
    if ( HP <= 0 )
    {
     active = false; 
    }
  }

  void display()
  {
    if ( active )
    {
      noStroke();
      fill(Colors.DARK_GREEN);
      ellipse(x, y, HITBOX_DIAMETER, HITBOX_DIAMETER);
      fill(255);
      text(HP, x, y);
    }
  }
}
