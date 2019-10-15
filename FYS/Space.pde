class Space {

  float x = random(width*0.87);
  float y = random(-height, height);
  float speed = random(0.5, 0.75);
  float d = random(1.5, 2);
  int score = 0;
  int time;
  int textsize = 30;

  void update() {

    y = y + speed;
    if (y-d > height) {
      y = 0;
    }
    
     if (score <= 0) {
      score = 0;
    }
    time = millis()/1000;
  }

  void display() {


    fill(255);
    ellipse(x, y, d, d);


    score = 0; 

    textSize(textsize);
    text("SCORE:", width*0.88, height*0.90);
    text(score, width*0.88, height*0.95);

    text("TIME:", width*0.88, height*0.80);
    text(time, width*0.88, height*0.85);
  }
}


void intializeBackgroundStars()
{
  for (int i = 0; i <Arrays.STAR_COUNT; i++)
  {
    space[i] = new Space();
  }
}
