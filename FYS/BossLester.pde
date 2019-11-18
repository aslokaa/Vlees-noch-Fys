class BossLester
{
  boolean active;
  float x;
  float y;
  final float HITBOX_OFFSET = 200;
  float angle;

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
    if ( frameCount % 150 == 0 )
    {
      Rectangles hitboxesToCheck = player.getHitboxes();
      PVector bulletSpeed;
      if ( hitboxesToCheck.rectangle1.exists )
      {
        if ( hitboxLeft.active )
        {
          bulletSpeed = getBulletSpeed(hitboxLeft.x, hitboxLeft.y, hitboxesToCheck.rectangle1, true);
          findInactiveBullet().shoot(hitboxLeft.x, hitboxLeft.y, bulletSpeed.x, bulletSpeed.y);
          bulletSpeed = getBulletSpeed(hitboxLeft.x, hitboxLeft.y, hitboxesToCheck.rectangle1, false);
          findInactiveBullet().shoot(hitboxLeft.x, hitboxLeft.y, bulletSpeed.x, bulletSpeed.y);
        }
        if ( hitboxBottom.active )
        {
          bulletSpeed = getBulletSpeed(hitboxBottom.x, hitboxBottom.y, hitboxesToCheck.rectangle1, true);
          findInactiveBullet().shoot(hitboxBottom.x, hitboxBottom.y, bulletSpeed.x, bulletSpeed.y);
          bulletSpeed = getBulletSpeed(hitboxBottom.x, hitboxBottom.y, hitboxesToCheck.rectangle1, false);
          findInactiveBullet().shoot(hitboxBottom.x, hitboxBottom.y, bulletSpeed.x, bulletSpeed.y);
        }
        if ( hitboxRight.active )
        {
          bulletSpeed = getBulletSpeed(hitboxRight.x, hitboxRight.y, hitboxesToCheck.rectangle1, true);
          findInactiveBullet().shoot(hitboxRight.x, hitboxRight.y, bulletSpeed.x, bulletSpeed.y);
          bulletSpeed = getBulletSpeed(hitboxRight.x, hitboxRight.y, hitboxesToCheck.rectangle1, false);
          findInactiveBullet().shoot(hitboxRight.x, hitboxRight.y, bulletSpeed.x, bulletSpeed.y);
        }
      } 
      if ( hitboxesToCheck.rectangle0.exists )
      {
        if ( hitboxLeft.active )
        {
          bulletSpeed = getBulletSpeed(hitboxLeft.x, hitboxLeft.y, hitboxesToCheck.rectangle0, true);
          findInactiveBullet().shoot(hitboxLeft.x, hitboxLeft.y, bulletSpeed.x, bulletSpeed.y);
          bulletSpeed = getBulletSpeed(hitboxLeft.x, hitboxLeft.y, hitboxesToCheck.rectangle0, false);
          findInactiveBullet().shoot(hitboxLeft.x, hitboxLeft.y, bulletSpeed.x, bulletSpeed.y);
          println(bulletSpeed);
        }
        if ( hitboxBottom.active )
        {
          bulletSpeed = getBulletSpeed(hitboxBottom.x, hitboxBottom.y, hitboxesToCheck.rectangle0, true);
          findInactiveBullet().shoot(hitboxBottom.x, hitboxBottom.y, bulletSpeed.x, bulletSpeed.y);
          bulletSpeed = getBulletSpeed(hitboxBottom.x, hitboxBottom.y, hitboxesToCheck.rectangle0, false);
          findInactiveBullet().shoot(hitboxBottom.x, hitboxBottom.y, bulletSpeed.x, bulletSpeed.y);
         println(bulletSpeed);
        }
        if ( hitboxRight.active )
        {
          bulletSpeed = getBulletSpeed(hitboxRight.x, hitboxRight.y, hitboxesToCheck.rectangle0, true);
          findInactiveBullet().shoot(hitboxRight.x, hitboxRight.y, bulletSpeed.x, bulletSpeed.y);
          bulletSpeed = getBulletSpeed(hitboxRight.x, hitboxRight.y, hitboxesToCheck.rectangle0, false);
          findInactiveBullet().shoot(hitboxRight.x, hitboxRight.y, bulletSpeed.x, bulletSpeed.y);
         println(bulletSpeed);
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
    
    translate(boxX, boxY);
    fill(255);
    ellipse(0,0,200, 200);
    if ( left )
    {
      angle = atan2( rectangle.y  - boxY, rectangle.x - ( rectangle.rectangleWidth * 0.5 ) - boxX);
      angle += PI / 2;
    } else 
    {
      angle = atan2( rectangle.y  - boxY, rectangle.x + ( rectangle.rectangleWidth * 1.5 ) - boxX);
      angle += PI / 2;
    }
    translate(-boxX,-boxY);

    
    returnBulletSpeed.x = angle ;
    returnBulletSpeed.y = 3;
  
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
