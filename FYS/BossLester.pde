class BossLester
{
  boolean active;
  float x;
  float y;
  float bodySize;
  final float HITBOX_OFFSET;
  final int SHOOT_TIMER;
  final int CHAD_SPAWN_TIMER;
  final int POWER_SPAWN_TIMER;
  float angle;
  int randomNumber;
  int hitboxToFire;
  Enemy chadToSpawn;



  float bulletAngle;
  PVector hitboxLeftPos = new PVector();
  PVector hitboxBottomPos = new PVector();
  PVector hitboxRightPos = new PVector();

  BossLesterHitbox hitboxLeft; 
  BossLesterHitbox hitboxBottom; 
  BossLesterHitbox hitboxRight;
  
  final float BODY_SPRITE_OFFSET;



  BossLester(float x, float y)
  {
    active = true;
    this.x = x;
    this.y = y;
    this.bodySize = 700;
    HITBOX_OFFSET = 300;
    SHOOT_TIMER = 75;
    CHAD_SPAWN_TIMER = 400;
    POWER_SPAWN_TIMER = 300;
    BODY_SPRITE_OFFSET = 50;
    chadToSpawn = new Enemy(false, 0, 0, 0);
    hitboxLeftPos.x = x - HITBOX_OFFSET;
    hitboxLeftPos.y = y;
    hitboxBottomPos.x = x;
    hitboxBottomPos.y = y + HITBOX_OFFSET;
    hitboxRightPos.x = x + HITBOX_OFFSET;
    hitboxRightPos.y = y;
    hitboxLeft = new BossLesterHitbox(hitboxLeftPos.x, hitboxLeftPos.y);
    hitboxBottom = new BossLesterHitbox(hitboxBottomPos.x, hitboxBottomPos.y);
    hitboxRight = new BossLesterHitbox(hitboxRightPos.x, hitboxRightPos.y);
    this.hitboxToFire = 1;
  }

  void update()
  {
    if ( active )
    {
      executeBehavior();
      hitboxLeft.update();
      hitboxBottom.update();
      hitboxRight.update();
      checkAlive();

      //setHitboxPositions();
      //check collisions
    }
  }

  void executeBehavior()
  {
    shootPlayer();
    spawnChad();
    spawnPower();
  }

  void shootPlayer()
  {
    if ( frameCount % SHOOT_TIMER == 0 )
    {
      
      Rectangles hitboxesToCheck = player.getHitboxes();
      if ( hitboxesToCheck.rectangle1.exists )
      {
        if ( hitboxLeft.active && hitboxToFire == 1 )
        {
          bulletAngle = getBulletSpeed(hitboxLeft.x, hitboxLeft.y, hitboxesToCheck.rectangle1, true);
          findInactiveBullet().shoot(hitboxLeft.x, hitboxLeft.y, bulletAngle);
          bulletAngle = getBulletSpeed(hitboxLeft.x, hitboxLeft.y, hitboxesToCheck.rectangle1, false);
          findInactiveBullet().shoot(hitboxLeft.x, hitboxLeft.y, bulletAngle);
        }
        if ( hitboxBottom.active && hitboxToFire == 2)
        {
          bulletAngle = getBulletSpeed(hitboxBottom.x, hitboxBottom.y, hitboxesToCheck.rectangle1, true);
          findInactiveBullet().shoot(hitboxBottom.x, hitboxBottom.y, bulletAngle);
          bulletAngle = getBulletSpeed(hitboxBottom.x, hitboxBottom.y, hitboxesToCheck.rectangle1, false);
          findInactiveBullet().shoot(hitboxBottom.x, hitboxBottom.y, bulletAngle);
        }
        if ( hitboxRight.active && hitboxToFire == 3)
        {
          bulletAngle = getBulletSpeed(hitboxRight.x, hitboxRight.y, hitboxesToCheck.rectangle1, true);
          findInactiveBullet().shoot(hitboxRight.x, hitboxRight.y, bulletAngle);
          bulletAngle = getBulletSpeed(hitboxRight.x, hitboxRight.y, hitboxesToCheck.rectangle1, false);
          findInactiveBullet().shoot(hitboxRight.x, hitboxRight.y, bulletAngle);
        }
      } 
      if ( hitboxesToCheck.rectangle0.exists )
      {
        if ( hitboxLeft.active && hitboxToFire == 1)
        {
          bulletAngle = getBulletSpeed(hitboxLeft.x, hitboxLeft.y, hitboxesToCheck.rectangle0, true);
          findInactiveBullet().shoot(hitboxLeft.x, hitboxLeft.y, bulletAngle);
          bulletAngle = getBulletSpeed(hitboxLeft.x, hitboxLeft.y, hitboxesToCheck.rectangle0, false);
          findInactiveBullet().shoot(hitboxLeft.x, hitboxLeft.y, bulletAngle);
        }
        if ( hitboxBottom.active && hitboxToFire == 2)
        {
          bulletAngle = getBulletSpeed(hitboxBottom.x, hitboxBottom.y, hitboxesToCheck.rectangle0, true);
          findInactiveBullet().shoot(hitboxBottom.x, hitboxBottom.y, bulletAngle);
          bulletAngle = getBulletSpeed(hitboxBottom.x, hitboxBottom.y, hitboxesToCheck.rectangle0, false);
          findInactiveBullet().shoot(hitboxBottom.x, hitboxBottom.y, bulletAngle);
        }
        if ( hitboxRight.active && hitboxToFire == 3)
        {
          bulletAngle = getBulletSpeed(hitboxRight.x, hitboxRight.y, hitboxesToCheck.rectangle0, true);
          findInactiveBullet().shoot(hitboxRight.x, hitboxRight.y, bulletAngle);
          bulletAngle = getBulletSpeed(hitboxRight.x, hitboxRight.y, hitboxesToCheck.rectangle0, false);
          findInactiveBullet().shoot(hitboxRight.x, hitboxRight.y, bulletAngle);
        }
      }
    }
    hitboxToFire++;
    if ( hitboxToFire > 3 )
    {
     hitboxToFire = 1; 
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

  float getBulletSpeed(float boxX, float boxY, Rectangle rectangle, boolean left)
  {

    translate(boxX, boxY);
    if ( left )
    {
      angle = atan2( rectangle.y  - boxY, rectangle.x - ( rectangle.rectangleWidth * 1 ) - boxX);
      angle += PI / 2;//half PI is added to rotate the speed of the ball by a quarter to the right to ensure the right angle
    } else 
    {
      angle = atan2( rectangle.y  - boxY, rectangle.x + ( rectangle.rectangleWidth * 2 ) - boxX);
      angle += PI / 2;//half PI is added to rotate the speed of the ball by a quarter to the right to ensure the right angle
    }
    translate(-boxX, -boxY);

    return angle;
  }

  void spawnChad()
  {

    if ( frameCount % CHAD_SPAWN_TIMER == 0 )
    {
      for ( Enemy enemy : enemies)
      {
        if ( !enemy.active && enemy instanceof EnemyChad )
        {
          chadToSpawn = enemy;
        }
      }

      randomNumber = round(random(0, 2));
      switch ( randomNumber ) {
      case 0:
        chadToSpawn.activate(hitboxLeft.x, hitboxLeft.y);
        break;
      case 1:
        chadToSpawn.activate(hitboxBottom.x, hitboxBottom.y);
        break;
      case 2:
        chadToSpawn.activate(hitboxRight.x, hitboxRight.y);
      }
    }
  }

  void spawnPower()
  {
    if ( frameCount % POWER_SPAWN_TIMER == 0 )
    {
      for ( Power power : powers)
      {
        if ( !power.powerActive )
        {
          randomNumber = round(random(3, 4));
          power.drop(random(200, gamefield.GAMEFIELD_WIDTH - 200), -50, randomNumber);
          return;
        }
      }
    }
  }

  void checkAlive()
  {
    if ( !hitboxLeft.active && !hitboxBottom.active && !hitboxRight.active )
    {
      active = false;
      score = score + 1000;
    }
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
