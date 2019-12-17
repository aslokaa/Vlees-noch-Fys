class ScreenScore {

  float comboScoreX, comboScoreY;
  float textSize;
  float scoreTimer;
  int comboScore;
  int maxTextSize;

  ScreenScore() {

    comboScoreX = 0;
    comboScoreY = 0;
    scoreTimer = 0;
    textSize = 60;
    comboScore = 0;
    maxTextSize = 90;
  }


  void updateScore(float enemyX, float enemyY) {
    comboScoreX = enemyX;
    comboScoreY = enemyY;
    comboScore += 100;
    scoreTimer = 60;
    textSize = comboScore/4+1;
  }


  void drawScore() {
    fill(Colors.YELLOW);

    if (textSize >= maxTextSize) {
      textSize = maxTextSize;
    }

    if (textSize == 1) {
      textSize = 1;
    } else {
      textSize = textSize - 0.5;
    }
    
    if(comboScore > 1){
     scoreTimer--; 
    }
    if(scoreTimer == 0){
     scoreTimer = 0;
     comboScore = 0;
    }

    textSize(textSize);
    if (scoreTimer >= 1) {
      text("+" + comboScore, comboScoreX, comboScoreY);
    }
  }
}
