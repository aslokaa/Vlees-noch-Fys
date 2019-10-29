/*brent sijm 500829125
 script van de bal.
 bal kan bewegen, en interacteren met enemies en de player.
 
 */
class Ball {
  float x, y, speedX, speedY;
  float radius, diameter;
  int colorBall;
  boolean active;
  float maxSpeedX;

  Ball() {
    x= width/2;
    y = height/2;
    speedX = 0;
    speedY = 10;
    radius = 25;
    colorBall = Colors.BLUE;
    active = true;
    diameter = radius*2;
    maxSpeedX = 10;
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
      ellipse(x, y, diameter, diameter);
    }
  }
  void moveBall() {
    x = x + speedX;
    y = y + speedY;
  }
  void bounceWall() {
    if (x > width - radius) {
      speedX = -speedX;
    }
    if (x < radius) {
      speedX *= -1;
    }
    if (y > height ) {

      x= width/2;
      y = height /2;
    }
    if (y < radius) {
      speedY *= -1;
    }
  }


  void interactPlayer() {
    Rectangles hitboxes = player.getHitboxes();
    if (hitboxes.rectangle0.exists)
    {

      if (( x + radius > hitboxes.rectangle0.x)&&(x -radius < hitboxes.rectangle0.x + hitboxes.rectangle0.rectangleWidth)&&
        (y + radius > hitboxes.rectangle0.y)&&(y - radius < hitboxes.rectangle0.y + hitboxes.rectangle0.rectangleHeight)) {

        speedY *= -1;
        y = hitboxes.rectangle0.y - 1 - radius;
        speedX += (x - (hitboxes.rectangle0.x + hitboxes.rectangle0.rectangleWidth / 2)) / 15;
      }
    }
    if (hitboxes.rectangle1.exists)
    {

      if (( x + radius > hitboxes.rectangle1.x)&&(x -radius < hitboxes.rectangle1.x + hitboxes.rectangle1.rectangleWidth)&&
        (y + radius > hitboxes.rectangle1.y)&&(y - radius < hitboxes.rectangle1.y + hitboxes.rectangle1.rectangleHeight)) {

        speedY *= -1;
        y = hitboxes.rectangle1.y - 1 - radius;
        speedX += (x - (hitboxes.rectangle1.x + hitboxes.rectangle1.rectangleWidth / 2)) / 15;
      }
    }
    if (speedX > maxSpeedX) {
      speedX = maxSpeedX;
    } else if (speedX < -maxSpeedX) {
      speedX = -maxSpeedX;
    }
  }
  void interactEnemy() {
    for (Enemy enemy : enemies) {
      if (dist(x, y, enemy.x, enemy.y)< radius + enemy.hitboxRadius) {
        enemy.destroy();
        speedY *= -1;
        //speedX += ( x - (enemy.x + enemy.hitboxDiameter / 2)) / 15;
      }
    }
  }
}
