 /*  Olger Klok, 50082502
 Create bullet methode,
 Collision bullets met enemy
 */

class PlayerBullet 
{
  float 
        bulletX,
        bulletY,
        bulletSpeed,
        bulletDiameter;
  boolean 
        shootBullet;

  PlayerBullet (float Xpos, float Ypos)
  {
    bulletX = Xpos;
    bulletY = Ypos;
    bulletSpeed = 5;
    bulletDiameter = 10;
    shootBullet = false;
  }

  void update() {
    if (shootBullet)
    {
      move();
    }
  }
  void display() {
    if (shootBullet)
    {
      ellipse(bulletX, bulletY, bulletDiameter, bulletDiameter);
    }
  }
  void createBullet(float playerX, float playerY) {
    shootBullet = true;
    playerBullets.add(new PlayerBullet(playerX, playerY + (bulletDiameter/2)));
  }
  
  void move() {
    bulletY += bulletSpeed;
  }

  boolean checkEnemyCollision() {
    for ( Enemy enemy : enemies ) {
      if ( dist(bulletX, bulletY, enemy.x, enemy.y) < (enemy.hitboxDiameter + (bulletDiameter/2))) {    
        return true;
      }
    }
    return false;
  }

  void bulletEnemyCollision() {
    if (checkEnemyCollision())
    {
      shootBullet = false;
    }
  }
}
