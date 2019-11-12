//Olger Klok, 50082502
//Inverted, Invisable, Slow, Split, Ammo, HpUp

class Power {
  
  float x,y;
  float velocityX,velocityY;
  float hitboxDiameter;
  float hitboxRadius;
  
  Power(float x, float y, float velocityX){
    this.x = x;
    this.y = y;
    this.velocityX = velocityX;
    velocityX = 4;
    velocityY = PowerFinals.VELOCITY_Y;
    hitboxDiameter = PowerFinals.HITBOX_DIAMETER;
    hitboxRadius = hitboxDiameter / 2; 
  }
  
  void update(){
  move();
  }
  
  void display(){
  }
  
  void drop(){
  }
  
  void powerPickedUp(){
  }
  
  void move(){
  x += velocityY; 
  }
  
  
}
