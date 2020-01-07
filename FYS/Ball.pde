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
  boolean safetyWallActive;
  float maxSpeedX;
  float ballRespawnTimer, timerCount;
  float bomRadius;
  Animation animation;

  ArrayList<PVector> history;



  Ball() {
    x= gamefield.GAMEFIELD_WIDTH/2;
    y = height/2;
    speedX = 0;
    speedY = height * 0.013;
    radius = 25;
    colorBall = Colors.BLUE;
    active = false;
    ballRespawn=false;
    diameter = radius*2;
    maxSpeedX = height * 0.013;
    ballRespawnTimer = 0;
    timerCount = 60;
    isChargedBom = false;
    bomRadius = 600;
    setAnimation();

    history = new ArrayList<PVector>();
  }

  Ball(float x)
  {
    this();
    this.x=x;
  }

  void setAnimation()
  {
    if (!isChargedBom) {
      for ( Animation newAnimation : animations )
      {
        if ( !newAnimation.active )
        {
          animation = newAnimation; 
          animation.initializeAnimation(ballAnimation, 3, 15, diameter);
          break;
        }
      }
    }
  }

  void updateBall() {
    if ( active )
    {

      if (!ballRespawn) {
        moveBall();
        interactPlayer();
        interactEnemy();
        interactBossLester();
        interactBossPing();
      }
      bounceWall();
      countdownBallRespawn();

      PVector v = new PVector(x, y);
      history.add(v);
      if (history.size() > 15) {
        history.remove(0);
      }
    }
  }

  void drawBall() {
    if ( active )
    {
      animation.display(x, y);
      noFill();
      if (!isChargedBom) { 
        stroke(Colors.BLUE);
        strokeWeight(5);
        ellipse(x, y, diameter, diameter);
      } else { 
        stroke(Colors.RED);
        strokeWeight(5);
        ellipse(x, y, diameter, diameter);
        ellipse(x, y, bomRadius, bomRadius);
      }
      for (int i = 0; i< history.size(); i++) {
        PVector current = history.get(i);

        fill(255, 100, 100, i*20);
        ellipse(current.x, current.y, 15 + i, 15 + i);
      }
    }
  }

  //gravity
  void moveBall() {
    x = x + speedX;
    y = y + speedY;
  }
  //bounce on walls 
  void bounceWall() {
    if ( safetyWallActive )
    {
      if ( y + radius > gamefield.GAMEFIELD_HEIGHT )
      {
        y = gamefield.GAMEFIELD_HEIGHT - radius;
        speedY *= -1;
      }
    }
    if (x > gamefield.GAMEFIELD_WIDTH - radius) {
      speedX = -speedX;
    }
    if (x < radius) {
      speedX *= -1;
    }
    if (y > gamefield.GAMEFIELD_HEIGHT && !ballRespawn) { // damage to player end start respawn

      ballRespawn = true ;
      ballRespawnTimer = timerCount;
      player.dealDamage(20, true);
      player.dealDamage(20, false);
      x= gamefield.GAMEFIELD_WIDTH/2;
      y = gamefield.GAMEFIELD_HEIGHT /2;
      speedX = 0;
      gamefield.scoreCounter = gamefield.scoreCounter - 200;
      gamefield.scoreCounter -= gamefield.scoreDamage;
      //gamefield.scoreDamageColor = Colors.RED;
      gamefield.damageTimer = 60;
    }
    if (y < radius) {
      if (!stateBossPing) {
        speedY *= -1;
        y = radius + 1;
      } else {
        ballRespawn = true;
        ballRespawnTimer = timerCount;

        x= gamefield.GAMEFIELD_WIDTH/2;
        y = gamefield.GAMEFIELD_HEIGHT /2;
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

        player.collideBall(speedY);
        speedY *= -1;
        y = hitboxes.rectangle0.y - 1 - radius;
        speedX += (x - (hitboxes.rectangle0.x + hitboxes.rectangle0.rectangleWidth / 2)) / 20;//ball bounce with player.
      }
    }

    if (hitboxes.rectangle1.exists)  // check if player 2(if player is split) exist.
    {

      if (( x + radius > hitboxes.rectangle1.x)&&(x -radius < hitboxes.rectangle1.x + hitboxes.rectangle1.rectangleWidth)&&  //collision with player 2 check.
        (y + radius > hitboxes.rectangle1.y)&&(y - radius < hitboxes.rectangle1.y + hitboxes.rectangle1.rectangleHeight)) {

        player.collideBall(speedY);
        speedY *= -1;
        y = hitboxes.rectangle1.y - 1 - radius;
        speedX += (x - (hitboxes.rectangle1.x + hitboxes.rectangle1.rectangleWidth / 2)) / 20;  //ball bounce with player 2.
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
          radius = 300;

          for (Enemy enemyBomb : enemies) {
            if (dist(x, y, enemyBomb.x, enemyBomb.y)< radius + enemyBomb.hitboxRadius) { 
              enemyBomb.destroy();  //enemie destroyd
              speedY *= -1;  // enemie bounce off
              isChargedBom = false;



              // spawn particles vanaf de ball.
            }
          }
          radius = 25;
        } else {
          enemy.destroy();  //enemie destroyd
          speedY *= -1;  // enemie bounce off
        }
      }
    }
  }

  void activate(float x, float y)
  {
    active = true;
    this.x = x;
    this.y = y;
    ballRespawn = true;
    ballRespawnTimer = timerCount;
  }

  //Eele & Brent
  void interactBossLester()
  {
    if ( stateBossLester )
    {
      if ( lester.active )
      {
        if (lester.hitboxLeft.active && dist(x, y, lester.hitboxLeft.x, lester.hitboxLeft.y) < radius + lester.hitboxLeft.HITBOX_RADIUS) {  //collision with enemie check.

          lester.hitboxLeft.HP--;  //enemie destroyd 
          speedY *= -1;  // enemie bounce off
          if (speedY < 0) {
            y = lester.hitboxLeft.y - lester.hitboxLeft.HITBOX_RADIUS - radius;
          } else {
            y = lester.hitboxLeft.y + lester.hitboxLeft.HITBOX_RADIUS + radius;
          }
        }
        if (lester.hitboxBottom.active && dist(x, y, lester.hitboxBottom.x, lester.hitboxBottom.y)< radius + lester.hitboxBottom.HITBOX_RADIUS) {  //collision with enemie check.

          lester.hitboxBottom.HP--;  //enemie destroyd 
          speedY *= -1;  // enemie bounce off
          if (speedY < 0) {
            y = lester.hitboxBottom.y - lester.hitboxBottom.HITBOX_RADIUS - radius;
          } else {
            y = lester.hitboxBottom.y + lester.hitboxBottom.HITBOX_RADIUS + radius;
          }
        }
        if (lester.hitboxRight.active && dist(x, y, lester.hitboxRight.x, lester.hitboxRight.y)< radius + lester.hitboxRight.HITBOX_RADIUS) {  //collision with enemie check.

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
      if ((x + radius > ping.getX())&&(x - radius < ping.getX() + ping.getWidth()) &&(y + radius > ping.getY())&&(y - radius < ping.getY() + ping.getHeight()) ) {
        speedY *= -1;
        y = ping.getY() + ping.getHeight() + 1 + radius;
      }
    }
  }
}
