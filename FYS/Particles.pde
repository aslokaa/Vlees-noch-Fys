// Mika Spoelstra & Brent Sijm


class Particle {

  float x, y;
  float velocityX, velocityY;
  float diameter;
  boolean active;
  int lifeTime;
  color drawColor = color(255, 255, 255);
  float spinSpeed;
  float drawAngle;
  Animation particleAnimation;

  Particle(float x, float y, float diameter, float velocityX, float velocityY) {
    
    this.x = x;
    this.y = y;
    this.diameter = diameter;
    this.velocityX = velocityX;
    this.velocityY = velocityY;
    active = false;
    drawAngle = 0;
    spinSpeed = 0;
  }

  void update() {
    if ( active ) {

      move();
      checkFrames();
      updateAngle();
    }
  }

  void display() {
    if (active) {
      
      if (!statePaused) { //prevents nullpointer
        pushMatrix();
        translate( x, y );
        rotate(drawAngle);
        particleAnimation.display(0, 0);
        rotate( -drawAngle );
        translate( -x, -y );
        popMatrix();
      }
    }
  }
  
  void move() {
    x += velocityX;
    y += velocityY;
  }
  
  void checkFrames() { // here you say when the particles have to disapear
    lifeTime --;
    if (lifeTime < 0) {
      active = false;
      particleAnimation.active = false;
    }
  }

  void updateAngle() {
    drawAngle += spinSpeed;
    if ( drawAngle < 0 && drawAngle < 2 * -PI )
    {
      drawAngle %= (2 * -PI);
    } else if ( drawAngle > 0 && drawAngle > 2 * PI)
    {
      drawAngle %= (2 * -PI);
    }
  }

  void activateParticle(float x, float y, float diameter, float velocityX, float velocityY, int lifeTime) { //here you activate the particles
    this.x = x;
    this.y = y;
    this.diameter = diameter;
    this.velocityX = velocityX;
    this.velocityY = velocityY;
    this.lifeTime = lifeTime;
    active = true;
    spinSpeed = random( -0.2, 0.2);
    setAnimation();
  }

  void setAnimation() {
    
    for ( Animation animation : animations )
    {
      if ( !animation.active )
      {
        particleAnimation = animation; 
        particleAnimation.initializeAnimation(explosionAnimation, 5, ceil(lifeTime / 4), diameter);
        break;
      }
    }
  }
}
