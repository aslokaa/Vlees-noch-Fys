//Mika Spoelstra, 500826255

class Space {



  float[] x = new float[Arrays.STAR_COUNT]; 
  float[] y = new float[Arrays.STAR_COUNT];
  float[] speed = new float[Arrays.STAR_COUNT]; 
  float[] diameter = new float[Arrays.STAR_COUNT]; 

  float planetX = width/2;
  int planetD = 250;
  int planetY = 0;
  int planetSpeed = 1;
  int planetNum = 0;



  Space () { 

    for (int i = 0; i < Arrays.STAR_COUNT; i++) {
      x[i] = random(gamefield.GAMEFIELD_WIDTH);
      y[i] = random(gamefield.GAMEFIELD_HEIGHT);
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
      //planetY = planetY + planetSpeed;
    }
    if (planetY - planetD > gamefield.GAMEFIELD_HEIGHT) {
      planetY =  -planetD;
      planetX = random(width*0.30, width*0.70);
      planetNum++;
    }
  }

  void display() {

    for ( int i = 0; i < Arrays.STAR_COUNT; i++) {
      image(star, x[i], y[i], diameter[i], diameter[i]);
    }
    planetY = planetY + planetSpeed;
    image(planets[int(planetNum)], planetX, planetY, planetD, planetD);
  }
}
