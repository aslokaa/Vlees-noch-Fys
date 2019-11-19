// Mika Spoelstra & Brent Sijm

//float[] x = new float[Arrays.PARTICLE_COUNT]; 
//float[] y = new float[Arrays.PARTICLE_COUNT];
//float[] velocityX = new float[Arrays.PARTICLE_COUNT]; 
//float[] velocityY = new float[Arrays.PARTICLE_COUNT]; 
//float[] diameter = new float[Arrays.PARTICLE_COUNT]; 

class Particle {

  float x, y;
  float velocityX, velocityY;
  float diameter;
  boolean active = false;
  int lifeTime;
  int particleNumber;
  color drawColor = color(255, 255 ,255);

  Particle(float x, float y, float diameter, float velocityX, float velocityY) {
    //Particle() {
    this.x = x;
    this.y = y;
    this.diameter = diameter;
    this.velocityX = velocityX;
    this.velocityY = velocityY;
    active = false;

    for (int i = 0; i < Arrays.PARTICLE_COUNT; i++) {
      x = 0;
      y = 0;
      velocityX = 0;
      velocityY = 0;
      diameter = random(1.5, 2);
    }
  }

  void update() {
    move();
    checkFrames();
  }

  void display() {
    if (active) {
      fill(drawColor);
        ellipse(x, y, diameter, diameter);
      
      /*switch(particleNumber) {
      case 0:
        fill(Colors.DARK_GREEN);
        ellipse(x, y, diameter, diameter);
        break;
      case 1:
        fill(Colors.WHITE);
        ellipse(x, y, diameter, diameter);
        break;
      case 2:
        fill(Colors.BLUE);
        ellipse(x, y, diameter, diameter);
        break;
      case 3:
        fill(Colors.GREEN);
        ellipse(x, y, diameter, diameter);
        break;
      case 4:
        fill(Colors.YELLOW);
        ellipse(x, y, diameter, diameter);
        break;
      }*/
    }
  }
  void move() {
    velocityX *= velocityX;
    velocityY *= velocityY;
  }
  void checkFrames() {
    lifeTime --;
    if (lifeTime < 0) {
      active = false;
    }
  }

  void activateParticle(float x, float y, float diameter, float velocityX, float velocityY, int lifeTime) {
    this.x = x;
    this.y = y;
    this.diameter = diameter;
    this.velocityX = velocityX;
    this.velocityY = velocityY;
    this.lifeTime = lifeTime;
    active = true;
  }
}
