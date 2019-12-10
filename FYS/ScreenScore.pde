class ScreenScore {

  float comboScoreX, comboScoreY;
  float textSize;
  float scoreTimer;
  int comboScore;
  int maxTextSize;
  int alpha;

  ScreenScore() {

    comboScoreX = 0;
    comboScoreY = 0;
    scoreTimer = 0;
    textSize = 60;
    comboScore = 0;
    maxTextSize = 90;
    alpha = 255;
  }


  void updateScore(float enemyX, float enemyY) {
    comboScoreX = enemyX;
    comboScoreY = enemyY;
    comboScore += 100;
    scoreTimer = 60;
    textSize = 60;
    alpha = 255;
  }


  void drawScore() {
    fill(255, 255, 0, alpha);
    alpha--;
    if (textSize < 1) {
      textSize = 1;
    }
    textSize( comboScore / 5 + 1);

    text("+" + comboScore, comboScoreX, comboScoreY);
  }
}
