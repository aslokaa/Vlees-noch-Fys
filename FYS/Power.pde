//Olger Klok, 50082502
//Inverted, Invisable, Slow, Split, Ammo, HpUp

class Power {

  float x, y;
  float velocityX, velocityY;
  float hitboxDiameter;
  float hitboxRadius;
  boolean powerActive;
  int powerNumber;
  

  Power(float x, float y, float velocityX) { //Constructor
    this.x = x;
    this.y = y;
    this.velocityX = velocityX;
    velocityX = 0;
    velocityY = PowerFinals.VELOCITY_Y;
    hitboxDiameter = PowerFinals.HITBOX_DIAMETER;
    hitboxRadius = hitboxDiameter / 2;
    powerActive = false;
  }

  void update() { //Updates the power if its active
    if (powerActive) {
      move();
      checkOffscreen();
      powerPickedUp();
    }
  }

  void display() { //Gets a random number out of enemyDave and spawns the power with that number
    if (powerActive) {
      switch(powerNumber) {
      case PowerUpTypes.INVERTED : 
        fill(Colors.DARK_GREEN);
        image(invertedPowerImg, x, y, hitboxDiameter, hitboxDiameter);
        break;
      case PowerUpTypes.IMMUNE : 
        fill(Colors.WHITE);
        image(shieldPowerImg, x, y, hitboxDiameter, hitboxDiameter);
        break;
      case PowerUpTypes.SLOW :
        fill(Colors.BLUE);
        image(snailPowerImg, x, y, hitboxDiameter, hitboxDiameter);
        break;
      case PowerUpTypes.HP_UP :
        fill(Colors.GREEN);
        image(powerHpUpImg, x, y, hitboxDiameter, hitboxDiameter);
        break;
      case  PowerUpTypes.AMMO_UP:
        fill(Colors.YELLOW);
        image(bulletPowerImg, x, y, hitboxDiameter, hitboxDiameter);
        break;
      case PowerUpTypes.BOOM_BALL :
        fill(Colors.MAGENTA);
        image(bombPowerImg, x, y, hitboxDiameter, hitboxDiameter);
        break;
      case PowerUpTypes.SPLIT :
        fill(Colors.PINK);
        image(splitPowerImg, x, y, hitboxDiameter, hitboxDiameter);
        break;
      case PowerUpTypes.EXTRA_BALL :
        image(ballAnimation[1],x,y,hitboxDiameter,hitboxDiameter);
        break;
      case PowerUpTypes.SPIKE_BALL :
        image(spikeBallImg, x, y, hitboxDiameter, hitboxDiameter);
        break;
      default:
      }
    }
  }

  void drop(float spawnX, float spawnY, int powerNumberNew) { //Spawns the power at the point where an enemy died
    x = spawnX;
    y = spawnY;
    powerNumber = powerNumberNew;
    powerActive = true;
    spawned[powerNumberNew]++;
  }

  void checkOffscreen() {  //Checks if the power fell off the screen and deactivates it if it is
    if ( y - hitboxRadius > gamefield.GAMEFIELD_HEIGHT) {
      powerActive = false;
    }
  }

  void powerPickedUp() {  //Checks the collision with the player with and without the split function active
    Rectangles hitboxes = player.getHitboxes();

    if (hitboxes.rectangle0.exists)  //check if player exist.
    {

      if (( x + hitboxRadius > hitboxes.rectangle0.x)&&(x - hitboxRadius < hitboxes.rectangle0.x + hitboxes.rectangle0.rectangleWidth)&&  //collision with player check.
        (y + hitboxRadius > hitboxes.rectangle0.y)&&(y - hitboxRadius < hitboxes.rectangle0.y + hitboxes.rectangle0.rectangleHeight)) {
        pickUps[powerNumber]++;
        player.modifyPower(powerNumber);
        powerActive= false;
      }
    }

    if (hitboxes.rectangle1.exists)  // check if player 2(if player is split) exist.
    {

      if (( x + hitboxRadius > hitboxes.rectangle1.x)&&(x - hitboxRadius < hitboxes.rectangle1.x + hitboxes.rectangle1.rectangleWidth)&&  //collision with player 2 check.
        (y + hitboxRadius > hitboxes.rectangle1.y)&&(y - hitboxRadius < hitboxes.rectangle1.y + hitboxes.rectangle1.rectangleHeight)) {
        pickUps[powerNumber]++;
        player.modifyPower(powerNumber);
        powerActive= false;
      }
    }
  }


  void move() { //Moves the player down each frame
    y += velocityY;
  }
}
