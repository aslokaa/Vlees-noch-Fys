//Mika Spoelstra, 500826255

int score = 0;

class Scores {


  int textsize = 30;
  int time = 0;
  int min = 0;


  void update() {

    if (score <= 0) {
      score = 0;
    }

    time+=1;

    if (time/60 == 60) {
      time = 0;
      min = min + 1;
    }
  }

  void display() {

    textSize(textsize);

    text("SCORE:", width*0.93, height*0.95);
    text(score, width*0.93, height*0.98);

    text("TIME", width*0.93, height*0.86);
   
    if( time/60 < 10) {
    text(min+":"+"0"+time/60, width*0.93, height*0.89);
    }
    if( time/60 > 9) {
    text(min+":"+time/60, width*0.93, height*0.89);
    }


    text("AMMO:" + player.getAmmo(), width*0.93, height*0.79);

    text("WAVE  " + gamefield.waveCounter, width*0.93, height*0.05);
  }
}
