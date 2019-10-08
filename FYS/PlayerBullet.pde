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
    move();
  }
  void display() {
    ellipse(bulletX, bulletY, bulletDiameter, bulletDiameter);
  }
  
  void createBullet(float playerX, float playerY){
     playerBullets.add(new PlayerBullet(playerX,  playerY + (bulletDiameter/2)));
    
  }
  
  void move(){
    bulletY += bulletSpeed; 
    
  }
  
  
  
  boolean collidesWithEnemy(Enemy enemy){
    if( dist(bulletX, bulletY, enemy.x, enemy.y) < (enemy.hitboxDiameter + (bulletDiameter/2))){    
    return true;
  } else {
    return false;
  }
    
    
  }

}
