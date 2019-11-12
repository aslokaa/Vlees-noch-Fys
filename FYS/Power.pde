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
    velocityX = 0;
    velocityY = PowerFinals.VELOCITY_Y;
    hitboxDiameter = PowerFinals.HITBOX_DIAMETER;
    hitboxRadius = hitboxDiameter / 2;
    powerActive = false;
  }

  void update() {
    if (powerActive) {
      move();
      checkOffscreen();
      powerPickedUp();
    }
  }

  void display() {
    if (powerActive) {
      switch(powerNumber) {
      case 0 : 
        fill(Colors.DARK_GREEN);
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
        fill(Colors.GREEN);
        ellipse(x, y, hitboxDiameter, hitboxDiameter);
        break;
      case 4 :
        fill(Colors.YELLOW);
        ellipse(x, y, hitboxDiameter, hitboxDiameter);
        break;
      case 5 :
        fill(Colors.MAGENTA);
        ellipse(x, y, hitboxDiameter, hitboxDiameter);
        break;
      case 6 :
        fill(Colors.PINK);
        ellipse(x, y, hitboxDiameter, hitboxDiameter);
        break;
        default:
        println("wrong number");
      }
    }
  }

  void drop(float spawnX, float spawnY, int powerNumberNew) {
    x = spawnX;
    y = spawnY;
    powerNumber = powerNumberNew;
    powerActive = true;
  }

  void checkOffscreen() {
    if ( y - hitboxRadius > height) {
      powerActive = false;
    }
  }

  void powerPickedUp() {
    Rectangles hitboxes = player.getHitboxes();

    if (hitboxes.rectangle0.exists)  //check if player exist.
    {

      if (( x + hitboxRadius > hitboxes.rectangle0.x)&&(x - hitboxRadius < hitboxes.rectangle0.x + hitboxes.rectangle0.rectangleWidth)&&  //collision with player check.
        (y + hitboxRadius > hitboxes.rectangle0.y)&&(y - hitboxRadius < hitboxes.rectangle0.y + hitboxes.rectangle0.rectangleHeight)) {
        player.modifyPower(powerNumber);
        powerActive= false;
      }
    }

    if (hitboxes.rectangle1.exists)  // check if player 2(if player is split) exist.
    {

      if (( x + hitboxRadius > hitboxes.rectangle1.x)&&(x - hitboxRadius < hitboxes.rectangle1.x + hitboxes.rectangle1.rectangleWidth)&&  //collision with player 2 check.
        (y + hitboxRadius > hitboxes.rectangle1.y)&&(y - hitboxRadius < hitboxes.rectangle1.y + hitboxes.rectangle1.rectangleHeight)) {
        player.modifyPower(powerNumber);
        powerActive= false;
      }
    }
  }


  void move() {
    y += velocityY;
  }
}
