//Mika Spoelstra, 500826255

class Space {


  //stars
  float[] x = new float[Arrays.STAR_COUNT]; 
  float[] y = new float[Arrays.STAR_COUNT];
  float[] speed = new float[Arrays.STAR_COUNT]; 
  float[] diameter = new float[Arrays.STAR_COUNT]; 

  float randomSpeed = random(0.5, 0.75);
  float randomDiameter = random(12, 10);

  //planets
  float minPlanetX = width*0.30;
  float maxPlanetX = width*0.70;
  float planetX = random(minPlanetX, maxPlanetX);
  int planetD = 250;
  int planetY = 0;
  int planetSpeed = 1;
  int planetNum = 0;



  Space () { 

    for (int i = 0; i < Arrays.STAR_COUNT; i++) {
      x[i] = random(gamefield.GAMEFIELD_WIDTH);
      y[i] = random(gamefield.GAMEFIELD_HEIGHT);
      speed[i] = randomSpeed;
      diameter[i] = randomDiameter;
    }
  }


  void update() {

    for ( int i = 0; i < Arrays.STAR_COUNT; i++) {
      y[i] = y[i] + speed[i];
      if (y[i]-diameter[i] > gamefield.GAMEFIELD_HEIGHT) {
        y[i] = 0;
      }
    }

    if (planetY - planetD > gamefield.GAMEFIELD_HEIGHT) {
      planetY =  -planetD;
      planetX = random(minPlanetX, maxPlanetX);;
      planetNum++;
    }
  }

  void display() {

    for ( int i = 0; i < Arrays.STAR_COUNT; i++) {
      image(star, x[i], y[i], diameter[i], diameter[i]);
    }
    planetY = planetY + planetSpeed;
    try{
    image(planets[planetNum], planetX, planetY, planetD, planetD);
    } catch (IndexOutOfBoundsException e){
      planetNum=0;
    }
  }
}
