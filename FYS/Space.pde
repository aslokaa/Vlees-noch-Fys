class Space {

  float x = random(width*0.87);
  float y = random(0, height);
  float speed = random(0.5, 0.75);
  float d = random(1.5, 2);

  void update() {

    y = y + speed;
    if (y-d > height) {
      y = 0;
    }
  }

  void display() {

    fill(255);
    ellipse(x, y, d, d);
  }
}
