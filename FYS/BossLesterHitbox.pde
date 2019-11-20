class BossLesterHitbox
{
  float x;
  float y;
  int HP;
  boolean active;
  final float HITBOX_DIAMETER = 75;
  final float HITBOX_RADIUS = HITBOX_DIAMETER / 2;
  final int STARTING_HP = 4;
  final int EXPLOSION_PARTICLES;

  BossLesterHitbox(float x, float y)
  {
    this.x = x;
    this.y = y;
    this.active = true;
    this.HP = STARTING_HP;
    this.EXPLOSION_PARTICLES = 75;
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
     explode();
    }
  }
  
  void explode()
  {
   for ( int i = 0; i < EXPLOSION_PARTICLES; i++ )
    {
      for ( Particle particle : particles )
      {
        if (!particle.active)
        {
          particle.activateParticle(x, y, random(3, 6), random(-3, 3), random(-3, 3), 1, round(random(30, 70) ) );
          break;
        }
      }
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
