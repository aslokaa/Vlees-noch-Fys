class Scores {

  int score = 0;
  int textsize = 30;
  int time=0;
     

  void update() {

    if (score <= 0) {
      score = 0;
    }

    time+=1;
  }

  void display() {
    
    score = 0; 

    textSize(textsize);
    text("SCORE:"+score, width*0.92, height*0.95);

    text("TIME:"+time/60+"s", width*0.92, height*0.87);
    
    text("AMMO:" + player.ammo, width*0.92, height*0.79);
    
     text("WAVE  " + gamefield.waveCounter, width*0.92, height*0.05);
  }
}
