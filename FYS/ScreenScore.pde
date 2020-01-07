class ScreenScore { //shows your + points on the screen

  float comboScoreX, comboScoreY;
  float textSize;
  float scoreTimer;
  int maxTextSize;
  int minTextSize;
  float textSizeChanger;
  float constantTextSizeChanger;

  ScreenScore() {

    comboScoreX = 0;
    comboScoreY = 0;
    scoreTimer = 0;
    textSize = 60;
    gamefield.comboScore = 0;
    maxTextSize = 90;
    minTextSize = 30;
    constantTextSizeChanger = 0.5;
    textSizeChanger = 4;
  }


  void updateScore(float enemyX, float enemyY) { //gets the position of where the last enemy died and sets those coordinates to this x and y , resets the combo timer and adds 100 points to the existing combo score
    comboScoreX = enemyX;
    comboScoreY = enemyY;
    gamefield.comboScore += 100;
    scoreTimer = 60;
    textSize = gamefield.comboScore / textSizeChanger +1;
  }


  void drawScore() { // Changes the textSize of the letters, resets combo score if needed and draws the text on the screen

    fill(Colors.BLACK);
    rect(0, gamefield.GAMEFIELD_HEIGHT, gamefield.GAMEFIELD_WIDTH, height*0.10);
    
    fill(Colors.YELLOW);

    if (textSize >= maxTextSize) {
      textSize = maxTextSize;
    }

    if (textSize == 1) {
      textSize = 1;
    } else {
      textSize = textSize - constantTextSizeChanger;
    }

    if (gamefield.comboScore > 1) {
      scoreTimer--;
    }
    if (scoreTimer == 0) {
      scoreTimer = 0;
      gamefield.comboScore = 0;
    }

    textSize(textSize);
    if (scoreTimer >= 1) {
      text("+" + gamefield.comboScore, comboScoreX, comboScoreY);

      textSize(minTextSize);
      text("+" + gamefield.comboScore, width*0.15, height*0.94);
    }
  }
}
