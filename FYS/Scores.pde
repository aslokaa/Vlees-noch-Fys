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
    text("SCORE:", width*0.88, height*0.90);
    text(score, width*0.88, height*0.95);

    text("TIME:", width*0.88, height*0.80);
    text(time, width*0.88, height*0.85);
  }
}