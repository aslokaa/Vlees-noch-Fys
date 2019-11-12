//Olger Klok, 50082502
//Inverted, Invisable, Slow, Split, Ammo, HpUp

class Power {

  float x, y;
  float velocityX, velocityY;
  float hitboxDiameter;
  float hitboxRadius;
  boolean powerActive;
  int powerNumber;

  Power(float x, float y, float velocityX) {
    this.x = x;
    this.y = y;
    this.velocityX = velocityX;
    velocityX = 4;
    velocityY = PowerFinals.VELOCITY_Y;
    hitboxDiameter = PowerFinals.HITBOX_DIAMETER;
    hitboxRadius = hitboxDiameter / 2;
  }

  void update() {
    move();
  }

  void display() {
    switch(powerNumber) {
    case 0 : 
      fill(Colors.GREEN);
      ellipse(x, y, hitboxDiameter, hitboxDiameter);
      break;
    case 1 : 
      fill(Colors.WHITE);
      ellipse(x, y, hitboxDiameter, hitboxDiameter);
      break;
    case 2 :
      fill(Colors.BLUE);
      ellipse(x, y, hitboxDiameter, hitboxDiameter);
      break;
    case 3 :
      fill(Colors.PINK);
      ellipse(x, y, hitboxDiameter, hitboxDiameter);
      break;
    }
  }

  void drop(float spawnX, float spawnY, int powerNumberNew) {
    x = spawnX;
    y = spawnY;
    powerNumber = powerNumberNew;
  }

  void powerPickedUp() {
  }

  void move() {
    x += velocityY;
  }
}
