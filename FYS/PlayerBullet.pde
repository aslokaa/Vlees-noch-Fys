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

  PlayerBullet (float Xpos, float Ypos) //constructor
  {
    bulletX = Xpos;
    bulletY = Ypos;
    bulletSpeed = -5;
    bulletDiameter = 10;
    shootBullet = false;
  }

  void update() { //Updates the location of the bullet if the bullet is shot
    if (shootBullet)
    {
      move();
    }
  }
  void display() { //Draws the bullet if it is shot
    if (shootBullet)
    {
      fill(Colors.YELLOW);
      ellipse(bulletX, bulletY, bulletDiameter, bulletDiameter);
    }
  }
  void createBullet(float playerX, float playerY) {
    shootBullet = true;
    bulletX = playerX;
    bulletY = playerY;
    println(1);
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
