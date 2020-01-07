//Mika Spoelstra, 500826255

class Scores {

  final int LIT_SCORE= 420420;

  int textSize = 30;
  int timer = 60;
  int time = 0;
  int min = 0;
  int totalTime = 0;

  boolean dash = true;

  float scoreY = height * 0.95;
  float scoreX = width * 0.06;


  void update() {

    if (gamefield.scoreCounter <= 0) {// score can't go lower than 0
      gamefield.scoreCounter = 0;
    }
    checkScoreAchievement();
    time+=1;
    totalTime++;

    if (time/60 == 60) {//every 60 seconds counts as one minute and resets seconds to 0
      time = 0;
      min = min + 1;
    }
    if (gamefield.scoreCounter >= 10000) {//re-positions the text from score to allign with the text from time below when score digits change
      scoreX = width * 0.07;
    }

    if (gamefield.scoreCounter == 0) {//re-positions the text from score to allign with the text from time below when score digits change
      scoreX = width * 0.048;
      gamefield.scoreDamage = 0;
    }

    if (gamefield.scoreCounter > 0) {//re-positions the text from score to allign with the text from time below when score digits change
      scoreX = width * 0.06;
    }
    /*if (gamefield.scoreDamageColor == Colors.RED) {//displays damage text in red until timer ends 
      gamefield.damageTimer--;
    }

    if (gamefield.damageTimer == 0) {//reset timer to 0 when ends and returns damage text to black 
      gamefield.damageTimer = 0;
      gamefield.scoreDamageColor = 0;
    }*/
  }

  void checkScoreAchievement() {
    if (gamefield.scoreCounter >= LIT_SCORE) {
      achievement.increaseProgress(AchievementID.LIT);
    }
  }

  void display() {

    fill(Colors.WHITE);
    textSize(textSize);
    text("SCORE:"+gamefield.scoreCounter, scoreX, height*0.94);//displays the score throughout the game

    text("WAVE  " + gamefield.waveCounter, width*0.05, height*0.05);//every completed wave counts up the wavecounter by 1

    image(enemyDaveImg, width*0.04, height*0.10, width*0.03, width*0.03);
    image(enemyChadImg, width*0.04, height*0.15, width*0.03, width*0.03);

    text("x"+-gamefield.daveCounter, width*0.07, height*0.10);
    text("x"+-gamefield.chadCounter, width*0.07, height*0.15);

    text("TIME", width*0.03, height*0.98);

    if ( time/60 < 10) {//the first 9 seconds have  dubbel digits.
      text(min+":"+"0"+time/60, width*0.09, height*0.98);
    }
    if ( time/60 > 9) {//10 to 60 seconds are the same.
      text(min+":"+time/60, width*0.09, height*0.98);
    }

    image( player.getHasImmune() ? shieldPowerImg : shieldPlaceholder, width*0.86, scoreY, 80, 80 );
    image( aButtonImg, width*0.90, scoreY, width*0.03, width*0.03);

    image( bulletPlaceholder, width*0.94, scoreY, 80, 60);
    image( bButtonImg, width*0.98, scoreY, width*0.03, width*0.03);

    for (int i = 0; i < width; i+=20) {//dashed white line across the screen to indicate gamefield end better
      if (dash) {
        stroke(0);
      } else {
        stroke(255);
      }
      line(i, height*0.90, i+10, height*0.90);
      dash = !dash;
    }         

    noStroke();
    fill(Colors.RED);
    textSize(textSize*1.5);
    text( player.getAmmo(), width*0.95, scoreY);

   /* if (gamefield.damageTimer >= 1) {
      fill(gamefield.scoreDamageColor);
      gamefield.scoreDamageColor = 30;
      textSize(gamefield.scoreDamageColor);
      text("-" + gamefield.scoreDamage, width*0.15, height*0.94);
    }*/


      fill(gamefield.colorTimer);
      gamefield.textPowerUp = 30;
      textSize(gamefield.textPowerUp);
      text(gamefield.powerTimer, width*0.78, height*0.96);  
      image(black, width*0.73, scoreY, gamefield.powerUpSize, gamefield.powerUpSize);
    }
  }
