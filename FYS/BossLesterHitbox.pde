class BossLesterHitbox
{
  float x;
  float y;
  int HP;
  boolean active;
  final float HITBOX_DIAMETER = 100;
  final float HITBOX_RADIUS = HITBOX_DIAMETER / 2;
  final int STARTING_HP = 4;
  float spriteSize;
  final int EXPLOSION_PARTICLES;
  float angle;

  BossLesterHitbox(float x, float y)
  {
    this.x = x;
    this.y = y;
    this.active = true;
    this.HP = STARTING_HP;
    spriteSize = 100;
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

  float getPlayerAngle( Rectangle rectangle)
  {

    translate(x, y);
   
      angle = atan2( rectangle.y  - y, rectangle.x + ( rectangle.rectangleWidth * 0.5 ) - x);
      angle -= PI / 2 ;//half PI is added to rotate the speed of the ball by a quarter to the right to ensure the right angle
   
    translate(-x, -y);

    return angle;
  }

  void display()
  {
    angle = getPlayerAngle( player.getHitboxes().rectangle0 );
   
     switch( HP )
     {
      case 4:
        translate(x, y);
        rotate(angle);
        image( lesterHitbox4HPImg, 0, 0, spriteSize, spriteSize );
        rotate(-angle);
        translate(-x, -y);
        break;
      case 3:
        translate(x, y);
        rotate(angle);
        image( lesterHitbox3HPImg, 0, 0, spriteSize, spriteSize );
        rotate(-angle);
        translate(-x, -y);
        break;
      case 2:
        translate(x, y);
        rotate(angle);
        image( lesterHitbox2HPImg, 0, 0, spriteSize, spriteSize );
        rotate(-angle);
        translate(-x, -y);
        break;
      case 1:
        translate(x, y);
        rotate(angle);
        image( lesterHitbox1HPImg, 0, 0, spriteSize, spriteSize );
        rotate(-angle);
        translate(-x, -y);
        break;
      case 0:
        image( lesterHitbox0HPImg, x, y, spriteSize, spriteSize );
        break;
     }
    
   }
}
