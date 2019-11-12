class Scores {

  int score = 0;
  int time;
  int textsize = 30;

  void update() {

    if (score <= 0) {
      score = 0;
    }

    time = millis()/1000;
  }

  void display() {

    score = 0; 

    textSize(textsize);
    text("SCORE:"+score, width*0.92, height*0.95);

    text("TIME:"+time+"s", width*0.92, height*0.87);
  }
}
