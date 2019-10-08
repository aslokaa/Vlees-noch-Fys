/*
Create bullet methode,
 Collision bullets met enemy
 
 */

class PlayerBullet 
{
  float bulletX, bulletY, bulletSpeed, bulletDiameter;


  PlayerBullet (float Xpos, float Ypos)
  {
    bulletX = Xpos;
    bulletY = Ypos;
    bulletSpeed = 5;
    bulletDiameter = 10;
  }

  void update() {
<<<<<<< Updated upstream
    bulletY += bulletSpeed;
=======
    move();
>>>>>>> Stashed changes
  }
  void display() {
    ellipse(bulletX, bulletY, bulletDiameter, bulletDiameter);
  }
<<<<<<< Updated upstream
  
  void createBullet(){
    
    
  }
  
  
  
  boolean collidesWithEnemy(Enemy enemy){
    if( dist(bulletX, bulletY, enemy.x, enemy.y) < (enemy. + (bulletDiameter/2))    
    return true;
  } else {
    return false;
  }
    
    
  }

=======

  void createBullet() {
  }

  void move() {
    bulletY += bulletSpeed;
  }

  boolean collidesWithEnemy(Enemy enemy) {
    if ( dist(bulletX, bulletY, enemy.x, enemy.y) < (enemy.hitboxRadius + (bulletDiameter/2)) {    
      return true;
    } else {
      return false;
    }
  }
>>>>>>> Stashed changes
}
