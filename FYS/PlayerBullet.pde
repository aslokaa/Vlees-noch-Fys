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
    bulletSpeed = -height*0.03;
    bulletDiameter = 100;
    shootBullet = false;
  }

  void update() { 
    if (shootBullet)
    {
      move();  //Updates the location of the bullet if the bullet is shot
      checkOffScreenBullet();   //Checks each frame if the bullet is off screen
      bulletEnemyCollision();  //Checks each frame if the bullet colliddes with the enemy
    }
  }
  void display() { //Draws the bullet if it is shot
    if (shootBullet)
    {  
      image(bulletImg, bulletX, bulletY, bulletDiameter, bulletDiameter);
    }
  }
  void createBullet(float playerX, float playerY) { // Moves the bullet to the players location 
    shootBullet = true;
    bulletX = playerX;
    bulletY = playerY;
  }

  void move() {
    bulletY += bulletSpeed; //Moves the bullet
  }

  void checkOffScreenBullet() { //Stop drawing the bullet if its off screen
    if (bulletY < 0) {
      shootBullet = false;
    }
  }


  void bulletEnemyCollision() { //Checks colision tussesn enemy en bullet

    for ( Enemy enemy : enemies ) {
      if ( !enemy.destroyed && dist(bulletX, bulletY, enemy.x, enemy.y) < (enemy.hitboxRadius + (bulletDiameter/2))) {    
        shootBullet = false;
        enemy.destroy();
      }
    }
    if (ping.checkCollision(bulletX,bulletY,bulletDiameter)){     
    }
  }
}
