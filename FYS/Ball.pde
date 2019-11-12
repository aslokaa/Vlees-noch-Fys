/*brent sijm 500829125
 script van de bal.
 bal kan bewegen en interacteren met enemies en de player.
 
 */
class Ball {
  float x, y, speedX, speedY;
  float radius, diameter;
  int colorBall;
  boolean active;
  boolean ballRespawn;
  boolean isChargedBom;
  float maxSpeedX;
  float ballRespawnTimer, timerCount;

  Ball() {
    x= gamefield.GAMEFIELD_WIDTH/2;
    y = height/2;
    speedX = 0;
    speedY = height * 0.013;
    radius = 25;
    colorBall = Colors.BLUE;
    active = true;
    ballRespawn=false;
    diameter = radius*2;
    maxSpeedX = height * 0.013;
    ballRespawnTimer = 0;
    timerCount = 60;
    isChargedBom = false;
  }

  void updateBall() {
    //if (active) {
    //drawBall();
    if (!ballRespawn) {
      moveBall();
      interactPlayer();
      interactEnemy();
      interactBossLester();
      interactBossPing();
    }
    bounceWall();
    countdownBallRespawn();
    //}
  }

  void drawBall() {
    //if (active) {
    fill(colorBall);
    ellipse(x, y, diameter, diameter);
    //}
  }
  //gravity
  void moveBall() {
    x = x + speedX;
    y = y + speedY;
  }
  //bounce on walls 
  void bounceWall() {
    if (x > gamefield.GAMEFIELD_WIDTH - radius) {
      speedX = -speedX;
    }
    if (x < radius) {
      speedX *= -1;
    }
    if (y > height && !ballRespawn) { // damage to player end start respawn

      ballRespawn = true ;
      ballRespawnTimer = timerCount;
      player.dealDamage(20, true);
      player.dealDamage(20, false);
      x= gamefield.GAMEFIELD_WIDTH/2;
      y = height /2;
    }
    if (y < radius) {
      if (!stateBossPing) {
        speedY *= -1;
      } else {
        ballRespawn = true ;
        ballRespawnTimer = timerCount;

        x= gamefield.GAMEFIELD_WIDTH/2;
        y = height /2;
        ping.recieveDamage(1);
      }
    }
  }
  //timer for respawn ball
  void countdownBallRespawn() {

    if (ballRespawn)
    {
      ballRespawnTimer--;

      if ( ballRespawnTimer <= 0 )
      {
        ballRespawn=false;
      }
    }
  }
  void ballChargedBom() {
    if (isChargedBom) {
      diameter = 100;
    }
  }


  void interactPlayer() {
    Rectangles hitboxes = player.getHitboxes();

    if (hitboxes.rectangle0.exists)  //check if player exist.
    {

      if (( x + radius > hitboxes.rectangle0.x)&&(x -radius < hitboxes.rectangle0.x + hitboxes.rectangle0.rectangleWidth)&&  //collision with player check.
        (y + radius > hitboxes.rectangle0.y)&&(y - radius < hitboxes.rectangle0.y + hitboxes.rectangle0.rectangleHeight)) {

        speedY *= -1;
        y = hitboxes.rectangle0.y - 1 - radius;
        speedX += (x - (hitboxes.rectangle0.x + hitboxes.rectangle0.rectangleWidth / 2)) / 15;  //ball bounce with player.
      }
    }

    if (hitboxes.rectangle1.exists)  // check if player 2(if player is split) exist.
    {

      if (( x + radius > hitboxes.rectangle1.x)&&(x -radius < hitboxes.rectangle1.x + hitboxes.rectangle1.rectangleWidth)&&  //collision with player 2 check.
        (y + radius > hitboxes.rectangle1.y)&&(y - radius < hitboxes.rectangle1.y + hitboxes.rectangle1.rectangleHeight)) {

        speedY *= -1;
        y = hitboxes.rectangle1.y - 1 - radius;
        speedX += (x - (hitboxes.rectangle1.x + hitboxes.rectangle1.rectangleWidth / 2)) / 15;  //ball bounce with player 2.
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
      if (dist(x, y, enemy.x, enemy.y)< radius + enemy.hitboxRadius) {  //collision with enemie check.
        if (isChargedBom) {
          radius = 100;
          for (Enemy enemyBomb : enemies) {
            if (dist(x, y, enemyBomb.x, enemyBomb.y)< radius + enemyBomb.hitboxRadius) { 
              enemyBomb.destroy();  //enemie destroyd
              speedY *= -1;  // enemie bounce off
              isChargedBom = false;
              radius = 25;
            }
          }
        } else {
          enemy.destroy();  //enemie destroyd
          speedY *= -1;  // enemie bounce off
        }
      }
    }
  }

  //Eele & Brent
  void interactBossLester()
  {
    if ( stateBossLester )
    {
      if ( lester.active )
      {
        if (lester.hitboxLeft.active && dist(x, y, lester.hitboxLeftPos.x, lester.hitboxLeftPos.y)< radius + lester.hitboxLeft.HITBOX_RADIUS) {  //collision with enemie check.

          lester.hitboxLeft.HP--;  //enemie destroyd 
          speedY *= -1;  // enemie bounce off
          if (speedY < 0) {
            y = lester.hitboxLeft.y - lester.hitboxLeft.HITBOX_RADIUS - radius;
          } else {
            y = lester.hitboxLeft.y + lester.hitboxLeft.HITBOX_RADIUS + radius;
          }
        }
        if (lester.hitboxBottom.active && dist(x, y, lester.hitboxBottomPos.x, lester.hitboxBottomPos.y)< radius + lester.hitboxBottom.HITBOX_RADIUS) {  //collision with enemie check.

          lester.hitboxBottom.HP--;  //enemie destroyd 
          speedY *= -1;  // enemie bounce off
          if (speedY < 0) {
            y = lester.hitboxBottom.y - lester.hitboxBottom.HITBOX_RADIUS - radius;
          } else {
            y = lester.hitboxBottom.y + lester.hitboxBottom.HITBOX_RADIUS + radius;
          }
        }
        if (lester.hitboxRight.active && dist(x, y, lester.hitboxRightPos.x, lester.hitboxRightPos.y)< radius + lester.hitboxRight.HITBOX_RADIUS) {  //collision with enemie check.

          lester.hitboxRight.HP--;  //enemie destroyd 
          speedY *= -1;  // enemie bounce off
          if (speedY < 0) {
            y = lester.hitboxRight.y - lester.hitboxRight.HITBOX_RADIUS - radius;
          } else {
            y = lester.hitboxRight.y + lester.hitboxRight.HITBOX_RADIUS + radius;
          }
        }
      }
    }
  }
  void interactBossPing() {
    if (stateBossPing) {
      if((x + radius > ping.x)&&(x - radius < ping.x + ping.bossWidth) &&(y + radius > ping.y)&&(y - radius < ping.y + ping.bossHeight) ){
        speedY *= -1;
        y = ping.y + ping.bossHeight + 1 + radius;
      }
    }
  }
}
