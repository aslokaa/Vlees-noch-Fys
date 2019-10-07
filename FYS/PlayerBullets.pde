/*
Create bullet methode,
 Collision bullets met enemy
 
 */

class PlayerBullets 
{
  float bulletX, bulletY, bulletSpeed, bulletDiameter;


  PlayerBullets (float Xpos, float Ypos)
  {
    bulletX = Xpos;
    bulletY = Ypos;
    bulletSpeed = 5;
    bulletDiameter = 10;
  }

  void update() {
    bulletY += bulletSpeed;
  }
  void display() {
    ellipse(bulletX, bulletY, bulletDiameter, bulletDiameter);
  }
  
  boolean collidesWithEnemy(float enemyX, float enemyY, float enemyRadius){
    
    
    
    return true;
    
    
  }

}
