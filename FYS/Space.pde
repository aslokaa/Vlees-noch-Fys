//Mika Spoelstra, 500826255

class Space {



  float[] x = new float[Arrays.STAR_COUNT]; 
  float[] y = new float[Arrays.STAR_COUNT];
  float[] speed = new float[Arrays.STAR_COUNT]; 
  float[] diameter = new float[Arrays.STAR_COUNT]; 
  float starColor = 255;

  Space () { 

    for (int i = 0; i < Arrays.STAR_COUNT; i++) {
      x[i] = random(0, gamefield.GAMEFIELD_WIDTH);
      y[i] = random(0, height);
      speed[i] = random(0.5, 0.75);
      diameter[i] = random(2, 3);
    }
  }


  void update() {

    for ( int i = 0; i < Arrays.STAR_COUNT; i++) {
      y[i] = y[i] + speed[i];
      if (y[i]-diameter[i] > height) {
        y[i] = 0;
      }
    }
  }

  void display() {

    
    image(earth, 750, 800, 800, 800);
    
    fill(starColor);
    for ( int i = 0; i < Arrays.STAR_COUNT; i++) {
    ellipse(x[i], y[i], diameter[i], diameter[i]);
    }
  }
}
