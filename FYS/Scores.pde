//Mika Spoelstra, 500826255

class Scores {

  final int LIT_SCORE= 420420;

  int textSize = 30;

  boolean splitEnded, 
    dash = true;

  float scoreX;

  void update() {

    checkScoreAchievement();
    scoreUpdates();
    updateTime();
  }

  int timer = 60;
  int time = 0;
  int min = 0;
  int totalTime = 0;

  void updateTime() {   

    time+=1;
    totalTime++;

    if (time/60 == 60) {//every 60 seconds counts as one minute and resets seconds to 0
      time = 0;
      min = min + 1;
    }
  }

  float scoreTenThousand = width * 0.07;
  float scoreZero = width * 0.048;
  float scorePlusZero = width * 0.06;

  void scoreUpdates() {

    if (gamefield.scoreCounter <= 0) {// score can't go lower than 0
      gamefield.scoreCounter = 0;
    }

    if (gamefield.scoreCounter >= 10000) {//re-positions the text from score to allign with the text from time below when score digits change
      scoreX = scoreTenThousand;
    }

    if (gamefield.scoreCounter == 0) {//re-positions the text from score to allign with the text from time below when score digits change
      scoreX = scoreZero;
      gamefield.scoreDamage = 0;
    }

    if (gamefield.scoreCounter > 0) {//re-positions the text from score to allign with the text from time below when score digits change
      scoreX = scorePlusZero ;
    }
  }

  void checkScoreAchievement() {
    if (gamefield.scoreCounter >= LIT_SCORE) {
      achievement.increaseProgress(AchievementID.LIT);
    }
  }



  void display() {

    displayScoreCounter();
    displayCurrentWave();
    displayEnemiesAlive();
    displayTime();
    displayShieldReady();
    displayShootButton();
    displayAmmoCounter();
    displayDashedLine();
    displayDamageScore();
    displayActivePowerUp();
  }

  float scoreCounterX = width * 0.06;
  float scoreCounterY = height*0.94;

  void displayScoreCounter() {

    fill(Colors.WHITE);
    textSize(textSize);
    text("SCORE:"+gamefield.scoreCounter, scoreCounterX, scoreCounterY);//displays the score throughout the game
  }

  float waveCounterX = width*0.05;
  float wavecounterY = height*0.05;

  void displayCurrentWave() {

    text("WAVE  " + gamefield.waveCounter, waveCounterX, wavecounterY);//every completed wave counts up the wavecounter by 1
  }

  float daveImgX = width*0.04;
  float daveImgY = height*0.10;
  float daveImgSize = width*0.03;

  float chadImgX = width*0.04;
  float chadImgY = height*0.15;
  float chadImgSize = width*0.03;

  float daveCounterX = width*0.07;
  float daveCounterY = height*0.10;

  float chadCounterX = width*0.07;
  float chadCounterY = height*0.15;


  void displayEnemiesAlive() {

    image(enemyDaveImg, daveImgX, daveImgY, daveImgSize, daveImgSize);//dave image
    image(enemyChadImg, chadImgX, chadImgY, chadImgSize, chadImgSize);//chad image

    text("x"+-gamefield.daveCounter, daveCounterX, daveCounterY);//daves alive counter
    text("x"+gamefield.chadCounter, chadCounterX, chadCounterY);//chads alive counter
  }

  float timeX = width*0.03;
  float timeY = height*0.98;
  float updatedTimeX = width*0.09;

  void displayTime() {

    text("TIME", timeX, timeY);

    if ( time/60 < 10) {//the first 9 seconds have  dubbel digits.
      text(min+":"+"0"+time/60, updatedTimeX, timeY);
    }
    if ( time/60 > 9) {//10 to 60 seconds are the same.
      text(min+":"+time/60, updatedTimeX, timeY);
    }
  }

  float sHolderX = width*0.86;
  float sHolderY = height * 0.95;
  float sHolderSize = 80;

  float aButtonX = width*0.90;
  float aButtonY = height * 0.95;
  float aButtonSize = width*0.03;

  void displayShieldReady() {

    image( player.getHasImmune() ? shieldPowerImg : shieldPlaceholder, sHolderX, sHolderY, sHolderSize, sHolderSize );//shield image is dark, and glows up when the shield powerup is picked up.
    image( aButtonImg, aButtonX, aButtonY, aButtonSize, aButtonSize);//button "A" to activate shield
  }

  float bButtonImgX = width*0.98;
  float bButtonImgY = height*0.95;
  float bButtonImgSize = width*0.03;

  void displayShootButton() {

    image( bButtonImg, bButtonImgX, bButtonImgY, bButtonImgSize, bButtonImgSize);//button "B" to shoot
  }

  float bulletHolderX = width*0.94;
  float bulletHolderY = height*0.95;
  float bHolderImgX = 80;
  float bHolderImgY = 60;

  float ammoCounterX = width*0.95;
  float ammoCounterY = height*0.95;

  void displayAmmoCounter() {    

    image( bulletPlaceholder, bulletHolderX, bulletHolderY, bHolderImgX, bHolderImgY);//ammo image
    noStroke();
    fill(Colors.RED);
    textSize(textSize*1.5);
    text( player.getAmmo(), ammoCounterX, ammoCounterY);//ammo counter
  }

  float lineX = height*0.90;
  float lineY = height*0.90;
  float lineSpacing = 20;

  void displayDashedLine() {

    for (int i = 0; i < width; i+=lineSpacing) {//dashed white line across the screen to indicate gamefield end 
      if (dash) {
        stroke(0);
      } else {
        stroke(255);
      }
      line(i, lineX, i+lineSpacing/2, lineY);
      dash = !dash;
    }
  }

  float scoredamageX = width*0.15;
  float scoredamageY = height*0.94;
  int scoreDamage = 200;
  int damageTimer = 1000;

  void displayDamageScore() {//score goes -200 when taking damage

    if (millis() < gamefield.damageTime + damageTimer) {
      textSize(textSize);
      gamefield.scoreDamage = scoreDamage;
      text("-" + gamefield.scoreDamage, scoredamageX, scoredamageY);
    }
  }

  float timerX = width*0.78;
  float timerY = height*0.96;

  int textPowerUpSize = 30;

  float powerImgX = width*0.73;
  float powerImgY = height*0.95;

  void displayActivePowerUp() {

    if (!splitEnded) {
      fill(gamefield.colorTimer);
      gamefield.textPowerUp = textPowerUpSize;
      textSize(gamefield.textPowerUp);
      text(gamefield.powerTimer, timerX, timerY);//power up timer
      image(black, powerImgX, powerImgY, gamefield.powerUpSize, gamefield.powerUpSize);//power up image
    }
  }
}
