class ScreenScore {

  float comboScoreX, comboScoreY;
  float textSize;
  float scoreTimer;
  float comboScore;

  ScreenScore() {

    comboScoreX = 0;
    comboScoreY = 0;
    scoreTimer = 0;
    textSize = 40;
    comboScore = 0;
  }

  
  void updateScore(float enemyX,float enemyY) {
    comboScoreX = enemyX;
    comboScoreY = enemyY;
    comboScore ++;
    scoreTimer = 180;
    textSize(textSize*comboScore);
    text("+" + comboScore * 100, comboScoreX, comboScoreY);
    println(comboScore);
    drawScore();
    scoreTimer--;
  }
  
  
  void drawScore(){
   if ( scoreTimer > 0){
    text("+" + comboScore * 100, comboScoreX, comboScoreY);
   }
  }
  
}
