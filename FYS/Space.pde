class Space {

  float x = random(width);
  float y = random(-height, height);
  float speed = random(1, 2);
  float d = random(2, 3);

  void show() {

    y = y + speed;
    if (y-d > height) 
      y = random(-height, 0);


    fill(255);
    ellipse(x, y, d, d);
  }
}
