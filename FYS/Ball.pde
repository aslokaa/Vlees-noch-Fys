class Ball {
  float x, y, speedX, speedY;
  float radius;
  int colorBall;
  boolean active;

  Ball() {
    x= width/2;
    y = height/2;
    speedX = 5;
    speedY = 5;
    radius = 10;
    colorBall = Colors.BLUE;
    active = true;
  }

  void updateBall() {
    if (active) {
      drawBall();
      moveBall();
      interactPlayer();
      interactEnemy();
      bounceWall();
    }
  }

  void drawBall() {
    if (active) {
      fill(colorBall);
      ellipse(x, y, radius*2, radius*2);
    }
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
      println(1);
      if (( x + radius > hitboxes.rectangle0.x)&&(x -radius < hitboxes.rectangle0.x + hitboxes.rectangle0.rectangleWidth)&&
        (y + radius > hitboxes.rectangle0.y)&&(y - radius < hitboxes.rectangle0.y + hitboxes.rectangle0.rectangleHeight)) {
          println(2);
        speedY *= -1;
        y = hitboxes.rectangle0.y - 1 - radius;
      }
    }
  }
  void interactEnemy() {
    for (Enemy enemy : enemies) {
      if (dist(x, y, enemy.x, enemy.y)< radius + enemy.hitboxRadius) {
        enemy.destroy();
      }
    }
  }
}
