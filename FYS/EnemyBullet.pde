/*
this class contains a bullet that can be fired by enemies.
when activated they are given an angle and a speed.
bullets have player collision.
*/

class EnemyBullet
{
  boolean active = false;
  //position
  float x;
  float y;
  //angle and speed
  float angle;
  float speedX;
  float speedY; 
  float speed;
  //
  final float DAMAGE_TO_DEAL;
  //size
  final float DIAMETER = 30;
  final float RADIUS = DIAMETER /2;
  //graveyard position
  final float START_X = -100;
  final float START_Y = -100;
  Rectangles hitboxesToCheck;
  Animation bulletAnimation;

  EnemyBullet()
  {
    x = START_X;
    y = START_Y;
    speed = 4;
    DAMAGE_TO_DEAL = 10;
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
    if ( hitboxesToCheck.rectangle0.exists )
    {
      if ( x > hitboxesToCheck.rectangle0.x && x < hitboxesToCheck.rectangle0.x + ( hitboxesToCheck.rectangle0.rectangleWidth  ) &&
           y > hitboxesToCheck.rectangle0.y && y < hitboxesToCheck.rectangle0.y + ( hitboxesToCheck.rectangle0.rectangleHeight ))
      {
        active = false;
        player.dealDamage(DAMAGE_TO_DEAL, false);
      }
    }
    if ( hitboxesToCheck.rectangle1.exists )
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

  void shoot(float
  x, float y, float angle)
  {   
    active = true;
    this.x = x;
    this.y = y;
    this.angle = angle + PI;
    speedX = speed * sin(angle);
    speedY = speed * -cos(angle);
    setAnimation();
  }
  
  void setAnimation()
  {
    for ( Animation animation : animations )
    {
      if ( !animation.active )
      {
        bulletAnimation = animation; 
        bulletAnimation.initializeAnimation(enemyBulletAnimation, 3, 8, DIAMETER * 2);
        break;
      }
    }
  }

  void display()
  {
    if (active)
    {
      translate( x, y );
      rotate( angle );
      bulletAnimation.display( 0, 0 );
      rotate( -angle );
      translate( -x, -y );
      //fill( Colors.WHITE );
      //ellipse(x, y, RADIUS, RADIUS);
    }
  }
}
