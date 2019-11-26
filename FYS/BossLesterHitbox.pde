class BossLesterHitbox
{
  float x;
  float y;
  int HP;
  boolean active;
  final float HITBOX_DIAMETER = 75;
  final float HITBOX_RADIUS = HITBOX_DIAMETER / 2;
  final int STARTING_HP = 4;
  float spriteSize;
  final int EXPLOSION_PARTICLES;

  BossLesterHitbox(float x, float y)
  {
    this.x = x;
    this.y = y;
    this.active = true;
    this.HP = STARTING_HP;
    spriteSize = 50;
    this.EXPLOSION_PARTICLES = 75;
  }

  void update()
  {
    if ( active )
    {
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
    
     switch( HP )
     {
      case 4:
        image( lesterHitbox4HPImg, x, y, spriteSize, spriteSize );
        break;
      case 3:
        image( lesterHitbox3HPImg, x, y, spriteSize, spriteSize );
        break;
      case 2:
        image( lesterHitbox2HPImg, x, y, spriteSize, spriteSize );
        break;
      case 1:
        image( lesterHitbox1HPImg, x, y, spriteSize, spriteSize );
        break;
      case 0:
        image( lesterHitbox0HPImg, x, y, spriteSize, spriteSize );
        break;
     }
   }
}
