//Mika Spoelstra, 500826255

class Space {



  float[] x = new float[Arrays.STAR_COUNT]; 
  float[] y = new float[Arrays.STAR_COUNT];
  float[] speed = new float[Arrays.STAR_COUNT]; 
  float[] diameter = new float[Arrays.STAR_COUNT]; 


  Space () { 

    for (int i = 0; i < Arrays.STAR_COUNT; i++) {
      x[i] = random(0, gamefield.GAMEFIELD_WIDTH);
      y[i] = random(0, gamefield.GAMEFIELD_HEIGHT);
      speed[i] = random(0.5, 0.75);
      diameter[i] = random(12, 10);
    }
  }


  void update() {

    for ( int i = 0; i < Arrays.STAR_COUNT; i++) {
      y[i] = y[i] + speed[i];
      if (y[i]-diameter[i] > gamefield.GAMEFIELD_HEIGHT) {
        y[i] = 0;
      }
    }
  }

  void display() {

    for ( int i = 0; i < Arrays.STAR_COUNT; i++) {
      image(star, x[i], y[i], diameter[i], diameter[i]);
    }
    image(earth, 800, 800, 850, 650);
  }
}
