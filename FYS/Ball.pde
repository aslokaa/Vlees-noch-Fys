/*brent sijm 500829125
 script van de bal.
 bal kan bewegen en interacteren met enemies en de player.
 
 */
class Ball {
  float x, y, speedX, speedY;
  float radius, diameter;
  int colorBall;
  boolean active;
  float maxSpeedX;

  Ball() {
    x= gamefield.GAMEFIELD_WIDTH/2;
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
  //gravity
  void moveBall() {
    x = x + speedX;
    y = y + speedY;
  }
  //bounce on walls end respawned if its lost.
  void bounceWall() {
    if (x > gamefield.GAMEFIELD_WIDTH - radius) {
      speedX = -speedX;
    }
    if (x < radius) {
      speedX *= -1;
    }
    if (y > height ) {

      x= gamefield.GAMEFIELD_WIDTH/2;
      y = height /2;
      player.dealDamage(20,true);
      player.dealDamage(20,false);
    }
    if (y < radius) {
      speedY *= -1;
    }
  }


  void interactPlayer() {
    Rectangles hitboxes = player.getHitboxes();
    //check if player exist.
    if (hitboxes.rectangle0.exists)
    {
      //collision with player check.
      if (( x + radius > hitboxes.rectangle0.x)&&(x -radius < hitboxes.rectangle0.x + hitboxes.rectangle0.rectangleWidth)&&
        (y + radius > hitboxes.rectangle0.y)&&(y - radius < hitboxes.rectangle0.y + hitboxes.rectangle0.rectangleHeight)) {
        //ball bounce with player.
        speedY *= -1;
        y = hitboxes.rectangle0.y - 1 - radius;
        speedX += (x - (hitboxes.rectangle0.x + hitboxes.rectangle0.rectangleWidth / 2)) / 15;
      }
    }
    // check if player 2(if player is split) exist.
    if (hitboxes.rectangle1.exists)
    {
      //collision with player 2 check.
      if (( x + radius > hitboxes.rectangle1.x)&&(x -radius < hitboxes.rectangle1.x + hitboxes.rectangle1.rectangleWidth)&&
        (y + radius > hitboxes.rectangle1.y)&&(y - radius < hitboxes.rectangle1.y + hitboxes.rectangle1.rectangleHeight)) {
        //ball bounce with player 2.
        speedY *= -1;
        y = hitboxes.rectangle1.y - 1 - radius;
        speedX += (x - (hitboxes.rectangle1.x + hitboxes.rectangle1.rectangleWidth / 2)) / 15;
      }
    }
    //fixes max speed of the ball
    if (speedX > maxSpeedX) {
      speedX = maxSpeedX;
    } else if (speedX < -maxSpeedX) {
      speedX = -maxSpeedX;
    }
  }
  void interactEnemy() {
    for (Enemy enemy : enemies) {
      //collision with enemie check.
      if (dist(x, y, enemy.x, enemy.y)< radius + enemy.hitboxRadius) {
        //enemie destroyd end ball bounces off
        enemy.destroy();
        speedY *= -1;
       
      }
    }
  }
}
