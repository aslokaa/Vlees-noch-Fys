/* this class contains bossfight lester.
 lester has 3 seperate hitboxes which are made from the hitboxLester class.
 lester shoots 2 bullets from every hitbox for every set interval.
 lester also activates a chad enemy at a random hitbox every set interval.
 lester also spawns 2 kinds of powerups randomly troughout the fight every set interval.
 
 Eele
 */

class BossLester
{
  boolean active;
  boolean introducing;
  //position
  float x;
  float y;
  final float INTRODUCTION_Y_SPEED;
  final float FINAL_Y;
  //sizes
  float bodySize;
  final float HITBOX_OFFSET;
  //behavior timers
  final int SHOOT_TIMER;
  final int CHAD_SPAWN_TIMER;
  final int POWER_SPAWN_TIMER;
  final float BODY_SPRITE_OFFSET;
  //random placeholders
  float angle;
  int randomNumber;
  int hitboxToFire;
  Enemy chadToSpawn;
  float bulletAngle;
  //hitboxes
  PVector hitboxLeftPos = new PVector();
  PVector hitboxBottomPos = new PVector();
  PVector hitboxRightPos = new PVector();
  BossLesterHitbox hitboxLeft; 
  BossLesterHitbox hitboxBottom; 
  BossLesterHitbox hitboxRight;

  BossLester(float x, float y)
  {
    active = false;
    introducing = false;
    this.x = x;
    this.y = y;
    INTRODUCTION_Y_SPEED = 1;
    FINAL_Y = 100;
    bodySize = 700;
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
      hitboxLeft.update();
      hitboxBottom.update();
      hitboxRight.update();

      if ( !introducing )
      {
        executeBehavior();
      } else
      {
        introduce();
      }
    }
  }

  void introduce()
  {
    move();
    moveHitboxes();
    restrictPlayerMovement();
  }

  void move()
  {
    //move down at set pace, when final pos is hit stop moving, shake screen more ,and end introduction.
    if ( y < FINAL_Y )
    {
      y += INTRODUCTION_Y_SPEED;
    } else
    {
      introducing = false; 
      //shake screen even more, start next wave.
    }
  }

  void moveHitboxes()
  {
    hitboxLeft.x = x - HITBOX_OFFSET;
    hitboxLeft.y = y;
    hitboxBottom.x = x;
    hitboxBottom.y = y + HITBOX_OFFSET;
    hitboxRight.x = x + HITBOX_OFFSET;
    hitboxRight.y = y;
  }

  void restrictPlayerMovement()
  {
    //set player pos to wanted pos and set playerspeeds to 0,
    //needs to happen after movement update in player.
    //gebruik player.setPosition(x,y);
    player.setPosition( gamefield.GAMEFIELD_WIDTH / 2 - player.playerWidth / 2, height -100);
  }

  void executeBehavior()
  {
    checkAlive();
    shootPlayer();
    spawnChad();
    spawnPower();
  }

  void checkAlive()//sets active to false when all hitboxes have 0 hp.
  {
    if ( !hitboxLeft.active && !hitboxBottom.active && !hitboxRight.active )
    {
      active = false;
      stateBossLester=false;
      score = score + 1000;
      for ( Enemy enemy : enemies )
      {
        if ( enemy instanceof EnemyChad ) 
        {
          enemy.destroy();
        }
      }
    }
  }


  //every SHOOT_TIMER amount of frames 1 hitbox shoots 2 bullets at
  //player.x - player.width and player.x + 2 * player.width. 
  //after shooting hitboxToFire goes up by 1 and the next cycle the next hitbox will shoot
  void shootPlayer()
  {
    if ( frameCount % SHOOT_TIMER == 0 )
    {
      Rectangles hitboxesToCheck = player.getHitboxes();
      if ( hitboxesToCheck.rectangle1.exists )//this if statement handles shooting the regular hitbox
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
      if ( hitboxesToCheck.rectangle0.exists )//this if statement handles shooting the second hitbox when the player is split
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

      hitboxToFire++;
      if ( hitboxToFire > 3 )
      {
        hitboxToFire = 1;
      }
    }
  }

  EnemyBullet findInactiveBullet()//returns an inactive enemybullet from the array.
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


  //finds the angle to the player by using the translate and atan2 methods found in the processing reference.
  float getBulletSpeed(float boxX, float boxY, Rectangle rectangle, boolean left)
  {

    translate(boxX, boxY);
    if ( left )
    {
      angle = atan2( rectangle.y  - boxY, rectangle.x - ( rectangle.rectangleWidth * 0.5 ) - boxX);
      angle += PI / 2;//half PI is added to rotate the speed of the ball by a quarter to the right to ensure the right angle
    } else 
    {
      angle = atan2( rectangle.y  - boxY, rectangle.x + ( rectangle.rectangleWidth * 1.5 ) - boxX);
      angle += PI / 2;//half PI is added to rotate the speed of the ball by a quarter to the right to ensure the right angle
    }
    translate(-boxX, -boxY);

    return angle;
  }

  void spawnChad()//spawns a chad at the position of a random hitbox
  {

    if ( frameCount % CHAD_SPAWN_TIMER == 0 )
    {
      for ( Enemy enemy : enemies)
      {
        if ( enemy.active && enemy instanceof EnemyChad )
        {
          return;
        } else
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

  void activate()
  {
    this.active = true;
    this.introducing = true;
    hitboxLeft.HP = 4;
    hitboxBottom.HP = 4;
    hitboxRight.HP = 4;
    //changeMusic();
    //shakeScreen();
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
