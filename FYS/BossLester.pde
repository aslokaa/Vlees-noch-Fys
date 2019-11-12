class BossLester
{
  boolean active;
  float x;
  float y;
  final float HITBOX_OFFSET = 200;

  PVector returnBulletSpeed = new PVector();
  PVector hitboxLeftPos = new PVector(0, 0);
  PVector hitboxBottomPos = new PVector(0, 0);
  PVector hitboxRightPos = new PVector(0, 0);

  BossLesterHitbox hitboxLeft; 
  BossLesterHitbox hitboxBottom; 
  BossLesterHitbox hitboxRight;



  BossLester(float x, float y)
  {
    active = true;
    this.x = x;
    this.y = y;
    hitboxLeftPos.x = x - HITBOX_OFFSET;
    hitboxLeftPos.y = y;
    hitboxBottomPos.x = x;
    hitboxBottomPos.y = y + HITBOX_OFFSET;
    hitboxRightPos.x = x + HITBOX_OFFSET;
    hitboxRightPos.y = y;
    hitboxLeft = new BossLesterHitbox(hitboxLeftPos.x, hitboxLeftPos.y);
    hitboxBottom = new BossLesterHitbox(hitboxBottomPos.x, hitboxBottomPos.y);
    hitboxRight = new BossLesterHitbox(hitboxRightPos.x, hitboxRightPos.y);
  }

  void update()
  {
    if ( active )
    {
      executeBehavior();
      hitboxLeft.update();
      hitboxBottom.update();
      hitboxRight.update();

      //setHitboxPositions();
      //check collisions
    }
  }

  void executeBehavior()
  {
    shootPlayer();
    spawnChad();
  }

  void shootPlayer()
  {
    if ( frameCount % 80 == 0 )
    {
      Rectangles hitboxesToCheck = player.getHitboxes();
      PVector bulletSpeed;
      if ( hitboxesToCheck.rectangle1.exists )
      {
        if ( hitboxLeft.active )
        {
          bulletSpeed = getBulletSpeed(hitboxLeftPos.x, hitboxLeftPos.y, hitboxesToCheck.rectangle1, true);
          findInactiveBullet().shoot(hitboxLeftPos.x, hitboxLeftPos.y, bulletSpeed.x, bulletSpeed.y);
          bulletSpeed = getBulletSpeed(hitboxLeftPos.x, hitboxLeftPos.y, hitboxesToCheck.rectangle1, false);
          findInactiveBullet().shoot(hitboxLeftPos.x, hitboxLeftPos.y, bulletSpeed.x, bulletSpeed.y);
        }
        if ( hitboxBottom.active )
        {
          bulletSpeed = getBulletSpeed(hitboxBottomPos.x, hitboxBottomPos.y, hitboxesToCheck.rectangle1, true);
          findInactiveBullet().shoot(hitboxBottomPos.x, hitboxBottomPos.y, bulletSpeed.x, bulletSpeed.y);
          bulletSpeed = getBulletSpeed(hitboxBottomPos.x, hitboxBottomPos.y, hitboxesToCheck.rectangle1, false);
          findInactiveBullet().shoot(hitboxBottomPos.x, hitboxBottomPos.y, bulletSpeed.x, bulletSpeed.y);
        }
        if ( hitboxRight.active )
        {
          bulletSpeed = getBulletSpeed(hitboxRightPos.x, hitboxRightPos.y, hitboxesToCheck.rectangle1, true);
          findInactiveBullet().shoot(hitboxRightPos.x, hitboxRightPos.y, bulletSpeed.x, bulletSpeed.y);
          bulletSpeed = getBulletSpeed(hitboxRightPos.x, hitboxRightPos.y, hitboxesToCheck.rectangle1, false);
          findInactiveBullet().shoot(hitboxRightPos.x, hitboxRightPos.y, bulletSpeed.x, bulletSpeed.y);
        }
      } 
      if ( hitboxesToCheck.rectangle0.exists )
      {
        if ( hitboxLeft.active )
        {
          bulletSpeed = getBulletSpeed(hitboxLeftPos.x, hitboxLeftPos.y, hitboxesToCheck.rectangle0, true);
          findInactiveBullet().shoot(hitboxLeftPos.x, hitboxLeftPos.y, bulletSpeed.x, bulletSpeed.y);
          //bulletSpeed = getBulletSpeed(hitboxLeftPos.x, hitboxLeftPos.y, hitboxesToCheck.rectangle0, false);
          //findInactiveBullet().shoot(hitboxLeftPos.x, hitboxLeftPos.y, bulletSpeed.x, bulletSpeed.y);
        }
        if ( hitboxBottom.active )
        {
          bulletSpeed = getBulletSpeed(hitboxBottomPos.x, hitboxBottomPos.y, hitboxesToCheck.rectangle0, true);
          findInactiveBullet().shoot(hitboxBottomPos.x, hitboxBottomPos.y, bulletSpeed.x, bulletSpeed.y);
         // bulletSpeed = getBulletSpeed(hitboxBottomPos.x, hitboxBottomPos.y, hitboxesToCheck.rectangle0, false);
         // findInactiveBullet().shoot(hitboxBottomPos.x, hitboxBottomPos.y, bulletSpeed.x, bulletSpeed.y);
        }
        if ( hitboxRight.active )
        {
          bulletSpeed = getBulletSpeed(hitboxRightPos.x, hitboxRightPos.y, hitboxesToCheck.rectangle0, true);
          findInactiveBullet().shoot(hitboxRightPos.x, hitboxRightPos.y, bulletSpeed.x, bulletSpeed.y);
         // bulletSpeed = getBulletSpeed(hitboxRightPos.x, hitboxRightPos.y, hitboxesToCheck.rectangle0, false);
         //findInactiveBullet().shoot(hitboxRightPos.x, hitboxRightPos.y, bulletSpeed.x, bulletSpeed.y);
        }
      }
    }
  }

  EnemyBullet findInactiveBullet()
  {
   
    for ( EnemyBullet bullet : enemyBullets ) 
    {
      if ( !bullet.active )
      {
        return bullet;
      }
    }
    return null;
  }

  PVector getBulletSpeed(float boxX, float boxY, Rectangle rectangle, boolean left)
  {
    float speedX;
    float speedY;
    if ( left )
    {
    speedX = dist( boxX, boxY, rectangle.x +  rectangle.rectangleWidth  , boxY ) / 
              (dist( boxX, boxY, rectangle.x +  rectangle.rectangleWidth , boxY ) + dist( boxX, boxY, boxX, rectangle.y )) ;
      speedY = 1 - speedX;
      if ( rectangle.x < boxX ) 
      {
        speedX *= -1;
      }
    } else 
    {
      speedX = dist( boxX, boxY, rectangle.x +  rectangle.rectangleWidth  , boxY ) / 
              (dist( boxX, boxY, rectangle.x +  rectangle.rectangleWidth , boxY ) + dist( boxX, boxY, boxX, rectangle.y )) ;
      speedY = 1 - speedX;        
      if ( rectangle.x + rectangle.rectangleWidth + 200 < boxX ) 
      {
        speedX *= -1;
      }
    }

    speedY = 1 - speedX;
    returnBulletSpeed.x = (speedX );
    returnBulletSpeed.y = (speedY );
  
    return returnBulletSpeed;
  }

  void spawnChad()
  {
  }

  void setHitboxPositions()
  {
  }

  void display()
  {
    if ( active )
    {
      hitboxLeft.display();
      hitboxBottom.display();
      hitboxRight.display();
    }
  }
}
