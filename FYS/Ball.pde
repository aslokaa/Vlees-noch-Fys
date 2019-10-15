class Ball {
  float x, y, speedX, speedY;
  float radius;
  int colorBall;

  Ball() {
    x= width/2;
    y = height/2;
    speedX = 5;
    speedY = 5;
    radius = 10;
    colorBall = Colors.BLUE;
  }

  void updateBall() {
  }

  void drawBall() {
    fill(colorBall);
    ellipse(x, y, radius*2, radius*2);
  }
  void moveBall() {
    x = x + speedX;
    y = y + speedY;
  }
  void bounceWall() {
    if (x > width) {
      speedX = -speedX;
    }
    if (x < 0) {
      speedX = speedX +2;
    }
    if (y > height) {

      x= width/2;
      y = height /2;
    }
    if (y < 0) {
      speedY = speedY +2;
    }
  }
  void interactPlayer() {
    Rectangles hitboxes = player.getHitboxes();
    if (hitboxes.rectangle0.exists)
    {
      if(( x + radius > hitboxes.rectangle0.x)&&(x -radius < hitboxes.rectangle0.x)&&
      (y + radius > hitboxes.rectangle0.y)){
         speedY *= -1;
      }
    }
  }
  void interactEnemy() {
    for(Enemy enemy: enemies){
    if (dist(x, y, enemy.x, enemy.y)< radius + enemy.hitboxRadius){
      //enemy.destroy;
    }
    }
  }
}
