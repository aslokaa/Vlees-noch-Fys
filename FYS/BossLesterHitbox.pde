/*
this class contains the hitbox used by bossLester, the hitbox has 4 HP,
every HP level displays a different sprite from 4 to 0.
the hitbox points the cannons in the sprites towards the player.
when the hitbox hits 0 hp it spawns explosion particles.
hitbox has collision with the ball and playerbullets.

Eele
*/


class BossLesterHitbox
{
  boolean active;
  int HP;
  final int STARTING_HP = 4;
  //position
  float x;
  float y;
  //hitbox size
  final float HITBOX_DIAMETER = 100;
  final float HITBOX_RADIUS = HITBOX_DIAMETER / 2;
  //size of own sprite
  float spriteSize;
  //particle info
  final int EXPLOSION_PARTICLES;
  float angle;
  float particleAngle;
  float particleSpeed;
  float particleSize;
  int particleLifespan;
  float particleSpeedX;
  float particleSpeedY;

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
  
  void explode()//spawns a set amount of particles with random speeds, angles, size and lifespan.
  {
    for ( int i = 0; i < EXPLOSION_PARTICLES; i++ )
    {
      for ( Particle particle : particles )
      {
        if (!particle.active)
        {
          particleSpeed = random( 0.2, 2 );
          particleAngle = random( 0, 2 * PI );
          particleSize = random( 15, 40 );
          particleSpeedX = particleSpeed * sin(particleAngle);
          particleSpeedY = particleSpeed * -cos(particleAngle);
          particleLifespan = round( 60 - particleSize * 1.2 );
          particle.activateParticle( x, y, particleSize, particleSpeedX, particleSpeedY, particleLifespan );
          break;
        }
      }
    }
  }


  //gets angle to the player using translate and  atan2 methods found in processing reference
  float getPlayerAngle( Rectangle rectangle)
  {

    translate(x, y);
   
      angle = atan2( rectangle.y  - y, rectangle.x + ( rectangle.rectangleWidth * 0.5 ) - x);
      angle -= PI / 2 ;//half PI is subtracted to rotate the speed of the ball by a quarter to the right to ensure the right angle
   
    translate(-x, -y);

    return angle;
  }
  
  void activate()
  {
   active = true;
   
  }

  void display()//displays sprites based on HP.
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
