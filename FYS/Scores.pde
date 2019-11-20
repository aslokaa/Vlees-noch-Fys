int score = 0;

class Scores {


  int textsize = 30;
  int time=0;


  void update() {

    if (score <= 0) {
      score = 0;
    }

    time+=1;
  }

  void display() {

    textSize(textsize);
    text("SCORE:", width*0.93, height*0.95);
    text(score, width*0.93, height*0.98);

    text("TIME:"+time/60+"s", width*0.93, height*0.87);

    text("AMMO:" + player.ammo, width*0.93, height*0.79);

    text("WAVE  " + gamefield.waveCounter, width*0.93, height*0.05);
  }
}
