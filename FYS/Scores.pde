//Mika Spoelstra, 500826255

int score = 0;

class Scores {


  int textSize = 30;
  int time = 0;
  int min = 0;


  void update() {

    if (score <= 0) {// score can't go lower than 0
      score = 0;
    }

    time+=1;

    if (time/60 == 60) {//every 60 seconds counts as one minute and resets seconds to 0
      time = 0;
      min = min + 1;
    }
  }

  void display() {
    fill(Colors.BLUE);
    rect(gamefield.GAMEFIELD_WIDTH, 0, width, height);
    textSize(textSize);
    fill(Colors.WHITE);

    text("SCORE:", width*0.91, height*0.25);//displays the score throughout the game
    text(score, width*0.97, height*0.25);

    text("TIME", width*0.90, height*0.15);

    if ( time/60 < 10) {//the first 9 seconds have  dubbel digits.
      text(min+":"+"0"+time/60, width*0.95, height*0.15);
    }
    if ( time/60 > 9) {//10 to 60 seconds are the same.
      text(min+":"+time/60, width*0.95, height*0.15);
    }
    image( player.getHasImmune() ? shieldPowerImg : shieldPlaceholder, width*0.91, height*0.70, 80, 80 );
    image( aButtonImg, width*0.97, height*0.7, width*0.03,width*0.03);
    
    image( bulletPlaceholder, width*0.91, height*0.79, 80, 60);
    image( bButtonImg, width*0.97, height*0.79, width*0.03,width*0.03);
    fill(Colors.RED);
    textSize(textSize*1.5);
    text( player.getAmmo(), width*0.94, height*0.81);
    fill(Colors.WHITE);
    textSize(textSize);


    text("WAVE  " + gamefield.waveCounter, width*0.93, height*0.05);//every completed wave counts up the wavecounter by 1
  }
}
