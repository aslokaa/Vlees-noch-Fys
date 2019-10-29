class Space {



  float[] x = new float[Arrays.STAR_COUNT]; 
  float[] y = new float[Arrays.STAR_COUNT];
  float[] speed = new float[Arrays.STAR_COUNT]; 
  float[] diameter = new float[Arrays.STAR_COUNT]; 

  Space () { 



    for (int i = 0; i < x.length; i++) {
      x[i] = random(width*0.87);
      y[i] = random(0, height);
      speed[i] = random(0.5, 0.75);
      diameter[i] = random(1.5, 2);
    }
  }


void update() {

  for ( int i = 0; i < Arrays.STAR_COUNT-1; i++) {

    y[i] = y[i] + speed[i];
    if (y[i]-diameter[i] > height) {
      y[i] = 0;
      println(i);
    }
  }
}




void display() {

  for ( int i = 0; i < Arrays.STAR_COUNT-1; i++) {

    fill(255);
    ellipse(x[i], y[i], diameter[i], diameter[i]);
  }
}
}
