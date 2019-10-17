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
    bulletSpeed = -height*0.01;
    bulletDiameter = 10;
    shootBullet = false;
  }

  void update() { //Updates the location of the bullet if the bullet is shot
    if (shootBullet)
    {
      move();
      checkOffScreenBullet(); 
      bulletEnemyCollision();
    }
  }
  void display() { //Draws the bullet if it is shot
    if (shootBullet)
    {
      fill(Colors.YELLOW);
      ellipse(bulletX, bulletY, bulletDiameter, bulletDiameter);
    }
  }
  void createBullet(float playerX, float playerY) { // Creates the bullet at the players location 
    shootBullet = true;
    bulletX = playerX;
    bulletY = playerY;
  }

  void move() {
    bulletY += bulletSpeed; //Moves the ball
  }

  void checkOffScreenBullet() { //Stop drawing the bullet if its off screen
    if (bulletY < 0) {
      shootBullet = false;
    }
  }


  void bulletEnemyCollision() { //Checks colision tussesn enemy en bullet

    for ( Enemy enemy : enemies ) {
      if ( enemy.active && dist(bulletX, bulletY, enemy.x, enemy.y) < (enemy.hitboxRadius + (bulletDiameter/2))) {    
        shootBullet = false;
        enemy.destroy();
      }
    }
  }
}
