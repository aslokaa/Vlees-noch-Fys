//Niklas Leeuwin
//500784205
//


//This is the class that handles the object the player controlls. 
//of je moet hier in de player 4 bools bijhouden van welke pijltjes er om de player gedisplayed 
//moeten worden of je maak er een aparte class van die een instance heeft in de player.
//aparte class is handig want die houdt zelf bij welk pijltje hij moet tekenen
//en tekent ze dan zelf.

class Player
{
  public final float
    PLAYER_START_WIDTH              = gamefield.GAMEFIELD_WIDTH * 0.17, 
    PLAYER_START_HEIGHT             = height * 0.05, 
    PLAYER_START_X                  = gamefield.GAMEFIELD_WIDTH / 2-PLAYER_START_WIDTH/2, 
    PLAYER_START_Y                  = height/2 - PLAYER_START_HEIGHT, 
    PLAYER_START_ACCELERATION_X     = gamefield.GAMEFIELD_WIDTH * 0.0035, 
    PLAYER_VELOCITY_X_MAX           = gamefield.GAMEFIELD_WIDTH * 0.014, 
    BALL_HIT_MODIFIER               = 0.01, 
    PLAYER_START_DECELERATE_X       = 0.85, 
    PLAYER_START_DECELERATE_Y       = 0.85, 
    PLAYER_START_ACCELERATION_Y     = height * 0.003, 
    PLAYER_VELOCITY_Y_MAX           = height * 0.012, 
    PLAYER_MIN_WIDTH                = PLAYER_START_WIDTH*0.4, 
    PLAYER_MAX_WIDTH                = gamefield.GAMEFIELD_WIDTH*0.45, 
    VELOCITY_MIN                    = PLAYER_START_ACCELERATION_Y*0.015, 
    ROCKET_SPRITE_HEIGHT            = height * 0.09, 
    ROCKET_SPRITE_WIDTH             = ROCKET_SPRITE_HEIGHT*0.8, 
    MOVEMENT_ARROW_SIZE             = gamefield.GAMEFIELD_WIDTH*0.08, 
    MOVEMENT_ARROW_OFFSET           = gamefield.GAMEFIELD_WIDTH*0.2, 
    SPLIT_WIDTH_MODIFIER            = 0.75, 
    BALL_HIT_Y_MODIFIER             = 0.35, 
    BALL_HIT_HEIGHT_MAX_MODIFIER    = 0.5, 
    BALL_HIT_HEIGHT_MIN_MODIFIER    = 0.3, 
    BALL_HIT_SMALLER_HEIGHT_MODIFIER= 0.8, 
    BOUNCE_MODIFIER                 = -0.3, 
    SECOND                          = 60, //one second
    INVERTED_STARTING_TIMER         = SECOND*4, 
    IMMUNE_STARTING_TIMER           = SECOND*5, 
    SLOW_STARTING_TIMER             = SECOND*2, 
    SHAKE_MODIFIER                  = gamefield.GAMEFIELD_WIDTH *0.01, 
    SHAKE_STARTING_TIMER            = SECOND*0.7, 
    SHOOT_STARTING_TIMER            = SECOND*0.75, 
    BALL_HIT_STARTING_TIMER         = SECOND*0.4, 
    SPLIT_STARTING_TIMER            = SECOND*15, 
    SHRINK_MARGIN                   = 5, 
    SHIELD_DOT_WIDTH                = 30, 
    SHIELD_DOT_HEIGHT               = 15, 
    POWER_BLINK_DELAY               = 10;

  public final int
    ROCKET_PARTICLES                = 20, 
    BULLET_PARTICLES                = 100, 
    DAMAGE_FRAMES                   = 6, 
    STARTING_BULLETS                = 5;
  PImage 
    currentImg;

  private float 
    x, 
    xSplit, 
    y, 
    minY, 
    playerWidth, 
    playerHeight, 
    accelerationX, 
    accelerationY, 
    velocityX, 
    velocityXSplit, 
    velocityY, 
    decelerateX, 
    decelerateY, 
    ballHitHeight, 
    widthSplit0, 
    widthSplit1;
  private boolean 
    inverted, //The direction the paddle moves in.
    immune, // immunes the paddle into 2.
    slow, //slows the paddle
    shake, //shakes the paddle
    hasImmune, //if the player is holding an immunity buff
    split; //splits the paddle
  private boolean[]
    moved;
  private float //Duration of effects.
    invertedTimer, 
    immuneTimer, 
    slowTimer, 
    shakeTimer, 
    splitTimer, 
    ballHitTimer, 
    shootTimer; 
  private int 
    ballHitState, //keeps track of how the paddle should interact with the fact it has hit a ball 
    ammo; //amount of ammo 
  private Rectangles
    hitboxes;
  private PImage image;


  public Player() //Constructor
  {
    x                 = PLAYER_START_X;
    y                 = PLAYER_START_Y;
    playerWidth       = PLAYER_START_WIDTH;
    playerHeight      = PLAYER_START_HEIGHT;
    accelerationX     = PLAYER_START_ACCELERATION_X;
    accelerationY     = PLAYER_START_ACCELERATION_Y;
    decelerateX       = PLAYER_START_DECELERATE_X;
    decelerateY       = PLAYER_START_DECELERATE_Y;
    hitboxes          = new Rectangles();
    ammo              = STARTING_BULLETS;
    image             = playerForcefieldImg;
    moved             = new boolean[4];
    ballHitState      = BallHit.NOTHING;
  }

  //updates the player
  public void update()
  {
    println(PLAYER_START_HEIGHT, playerHeight, PLAYER_START_HEIGHT*BALL_HIT_SMALLER_HEIGHT_MODIFIER);
    detectInput();
    decelerate();
    checkMove();
    detectCollisionEdge();
    powerCountdown();
    updateHitboxes();
  }

  //checks how to player should be drawn.
  public void checkDisplay()
  {
    noStroke();
    image=changeImage();
    if (!hasMoved()) {
      displayArrows();
    }
    checkBallHitState();
    imageMode(CORNER);
    if (shake)
    {
      shake();
    } else {
      checkSplit();
    }
    imageMode(CENTER);
  }

  private void checkBallHitState() {
    switch (ballHitState) {
    case BallHit.GROW:
      growBallHit();
      break;
    case BallHit.SHRINK:
      shrinkPaddleBallHit();
      break;
    case BallHit.REGROW:
      regrowPaddleBallHit();
      break;
    }
  }
  
  //increases the paddleheight after hitting a ball.
  private void growBallHit() {
    playerHeight+=(ballHitHeight-playerHeight)/BALL_HIT_STARTING_TIMER;
  }
  
  //shrinks the paddle after it grew from hitting a ball.
  private void shrinkPaddleBallHit() {
    playerHeight+=(PLAYER_START_HEIGHT*BALL_HIT_SMALLER_HEIGHT_MODIFIER-playerHeight)/BALL_HIT_STARTING_TIMER;
    if (playerHeight - SHRINK_MARGIN< PLAYER_START_HEIGHT*BALL_HIT_SMALLER_HEIGHT_MODIFIER) {
      ballHitState=BallHit.REGROW;
    }
  }

  //makes the paddle the starting height after shrinking from hitting a ball.
  private void regrowPaddleBallHit() {
    if (playerHeight < PLAYER_START_HEIGHT) {
      playerHeight+=( PLAYER_START_HEIGHT-playerHeight)/(BALL_HIT_STARTING_TIMER/2);
    }
    if (playerHeight+playerHeight*BALL_HIT_MODIFIER>PLAYER_START_HEIGHT)
    {
      ballHitState=BallHit.NOTHING;
    }
  }


  //displays the movement tutorial arrows
  public void displayArrows() {
    if (!moved[0]) { //left
      image(arrowImg, x+playerWidth/2-MOVEMENT_ARROW_OFFSET, y+playerHeight/2, MOVEMENT_ARROW_SIZE, MOVEMENT_ARROW_SIZE);
    }
    if (!moved[1]) { //right
      pushMatrix();
      translate(x+playerWidth/2+MOVEMENT_ARROW_OFFSET, y+playerHeight/2);
      rotate(PI);
      image(arrowImg, 0, 0, MOVEMENT_ARROW_SIZE, MOVEMENT_ARROW_SIZE);
      popMatrix();
    }
    if (!moved[2]) { //up
      pushMatrix();
      translate(x+playerWidth/2, y+playerHeight/2-MOVEMENT_ARROW_OFFSET);
      rotate(0.5*PI);
      image(arrowImg, 0, 0, MOVEMENT_ARROW_SIZE, MOVEMENT_ARROW_SIZE);
      popMatrix();
    }
    if (!moved[3]) { // down
      pushMatrix();
      translate(x+playerWidth/2, y+playerHeight/2+MOVEMENT_ARROW_OFFSET);
      rotate(PI*1.5);
      image(arrowImg, 0, 0, MOVEMENT_ARROW_SIZE, MOVEMENT_ARROW_SIZE);
      popMatrix();
    }
  }
  //draws the standard player.
  private void display()
  {  
    if ( hasImmune ) //not made by Niklas
    {
      for ( int j = 0; j < 2; j++ )
      {
        for ( int i = 0; i < round( playerWidth / 50); i++ )
        {
          fill(255);
          rect( x + 50 * i, y - SHIELD_DOT_HEIGHT / 2 + ( j * (playerHeight + SHIELD_DOT_HEIGHT / 2) ), SHIELD_DOT_WIDTH, SHIELD_DOT_HEIGHT / 2);
        }
      }
      for ( int j = 0; j < 2; j++ )
      {
        for ( int i = 0; i < round( playerHeight / 50); i++ )
        {
          fill(255);
          arc( x + ( SHIELD_DOT_WIDTH / 2 ) + 50 * i, y + ( j * playerHeight ), SHIELD_DOT_WIDTH, SHIELD_DOT_WIDTH, PI + ( j * PI), TAU + ( j * PI ) );
          //rect( x + 50 * i, y - SHIELD_DOT_HEIGHT / 2 + ( j * (playerHeight + SHIELD_DOT_HEIGHT / 2) ), SHIELD_DOT_WIDTH, SHIELD_DOT_HEIGHT / 2);
        }
      }
    }

    if ( immune )
    {
      strokeWeight(SHIELD_DOT_HEIGHT);
      stroke(255);
      noFill();
      rect(x, y, playerWidth, playerHeight);
      noStroke();
    }
    image(image, x, y, playerWidth, playerHeight );
    image(playerSidesImg, x, y + playerHeight, ROCKET_SPRITE_WIDTH, ROCKET_SPRITE_HEIGHT);
    image(playerSidesImg, x + playerWidth - ROCKET_SPRITE_WIDTH, y + playerHeight, ROCKET_SPRITE_WIDTH, ROCKET_SPRITE_HEIGHT);
    if (checkVelocity()) {
      emitParticles(x+playerWidth-ROCKET_SPRITE_WIDTH/2, y+playerHeight+ROCKET_SPRITE_HEIGHT, ROCKET_PARTICLES, true);
      emitParticles(x+ROCKET_SPRITE_WIDTH/2, y+playerHeight+ROCKET_SPRITE_HEIGHT, ROCKET_PARTICLES, true);
    }
  }

  //checks if the split should be displayed
  private void checkSplit() {
    if (split)
    {
      displaySplit();
    } else
    {
      display();
    }
  }

  //returns true if any velocity exists
  private boolean checkVelocity() {
    return !(velocityX==0 && velocityY ==0);
  }

  //shakes the player
  private void shake()
  {
    float xModifier = random( -SHAKE_MODIFIER, SHAKE_MODIFIER );
    float yModifier = random( -SHAKE_MODIFIER, SHAKE_MODIFIER );
    x += xModifier;
    y += yModifier;
    checkSplit();
    x -=xModifier;
    y -=yModifier;
  }

  //draws the splitted player.
  private void displaySplit()
  {
    image(image, x, y, widthSplit0, playerHeight );
    image(playerSidesImg, x, y + playerHeight, ROCKET_SPRITE_WIDTH, ROCKET_SPRITE_HEIGHT);
    image(playerSidesImg, x + widthSplit0 - ROCKET_SPRITE_WIDTH, y + playerHeight, ROCKET_SPRITE_WIDTH, ROCKET_SPRITE_HEIGHT);
    image(image, xSplit, y, widthSplit1, playerHeight );
    image(playerSidesImg, xSplit, y + playerHeight, ROCKET_SPRITE_WIDTH, ROCKET_SPRITE_HEIGHT);
    image(playerSidesImg, xSplit + widthSplit1 - ROCKET_SPRITE_WIDTH, y + playerHeight, ROCKET_SPRITE_WIDTH, ROCKET_SPRITE_HEIGHT);
    if (checkVelocity()) {
      emitParticles(xSplit+widthSplit1-ROCKET_SPRITE_WIDTH/2, y+playerHeight+ROCKET_SPRITE_HEIGHT, ROCKET_PARTICLES/2, true);
      emitParticles(xSplit+ROCKET_SPRITE_WIDTH/2, y+playerHeight+ROCKET_SPRITE_HEIGHT, ROCKET_PARTICLES/2, true);
      emitParticles(x+ROCKET_SPRITE_WIDTH/2, y+playerHeight+ROCKET_SPRITE_HEIGHT, ROCKET_PARTICLES/2, true );
      emitParticles(x+widthSplit0-ROCKET_SPRITE_WIDTH/2, y+playerHeight+ROCKET_SPRITE_HEIGHT, ROCKET_PARTICLES/2, true);
    }
  }

  //detects user inputs.
  private void detectInput()//spawn "rook" particles als de player links recht up en down beweegt. see activate method in Particle
  {
    if ( keyCodesPressed[LEFT] ) 
    {
      moved[0]=true;
      velocityX -= accelerationX ; //Accelerates to the left.
      if (split)
      {
        velocityXSplit += accelerationX;
      }
    }
    if ( keyCodesPressed[RIGHT] ) 
    {
      moved[1]=true;
      velocityX += accelerationX; //Accelerates to the right.
      if (split)
      {
        velocityXSplit -= accelerationX;
      }
    }
    if ( keyCodesPressed[UP] )
    {
      moved[2]=true;
      velocityY -= accelerationY; //Accelerates to upwards.
    }
    if ( keyCodesPressed[DOWN] )
    {
      moved[3]=true;
      velocityY += accelerationY; //Accelerates to downwards.
    }
    if ( keysPressed['x'] && shootTimer <= 1 )
    {
      shoot();
    }
    if (keysPressed['a']) {
      activateImmune();
    }
  }


  //copied from enemies. emits smoke.
  private void emitParticles(float xSmoke, float ySmoke, int amountOfParticles, boolean rocket) {
    for ( int i = 0; i < amountOfParticles; i++ )
    {
      for ( Particle particle : particles )
      {
        if (!particle.active)
        {
          float particleAngle = random(0, 1)>0.5 ? random( 0, 0.5*PI ) : random(1.5*PI, 2*PI);
          float particleSpeed = rocket ? random( 5, 10 ) : random(1, 5);
          if (rocket) {
            particleAngle = random( 0.8 * PI, 1.2 *PI );
          }
          float particleSize = random( 20, 30 );
          float particleSpeedX = particleSpeed * sin(particleAngle) + velocityX / 2;
          float particleSpeedY = velocityY>-1 ? particleSpeed * -cos(particleAngle) + velocityY / 2 : particleSpeed * -cos(-particleAngle) + velocityY / 2;
          int particleLifespan = round(particleSize * 0.3 );
          particle.activateParticle( xSmoke, ySmoke, particleSize, particleSpeedX, particleSpeedY, particleLifespan );
          break;
        }
      }
    }
  }
  //checks what powers should affect the movement.
  private void checkMove()
  {
    checkVelocityMax();
    //if (slow) // slows the player
    //{
    //  velocityX *= SLOW_MODIFIER;
    //  velocityY *= SLOW_MODIFIER;
    //}
    if (inverted) // inverts the player
    {
      moveInverted();
    } else if (!inverted) // moves the player normally.
    {
      move();
    }
  }

  //makes sure the player doesn't go to fast
  private void checkVelocityMax()
  {
    if (velocityX > PLAYER_VELOCITY_X_MAX)
    {
      velocityX = PLAYER_VELOCITY_X_MAX;
    }
    if (velocityX < -PLAYER_VELOCITY_X_MAX)
    {
      velocityX = -PLAYER_VELOCITY_X_MAX;
    }
    if (split && velocityXSplit > PLAYER_VELOCITY_X_MAX)
    {
      velocityXSplit = PLAYER_VELOCITY_X_MAX;
    }
    if (velocityY > PLAYER_VELOCITY_Y_MAX)
    {
      velocityY = PLAYER_VELOCITY_Y_MAX;
    }
    if (velocityY < -PLAYER_VELOCITY_Y_MAX)
    {
      velocityY = -PLAYER_VELOCITY_Y_MAX;
    }
  }
  // modifies the X and Y positions
  private void move()
  {
    x += velocityX;
    y += velocityY;
    if (split)
    {
      xSplit+=velocityXSplit;
    }
  }
  //modifies the X and Y posistions but inverted.
  private void moveInverted()
  {
    x -= velocityX;
    y -= velocityY;
    if (split)
    {
      xSplit-=velocityXSplit;
    }
  }

  //Gives the player a powerup or down.
  public void modifyPower( int type )
  {
    switch(type)
    {
    case PowerUpTypes.INVERTED:
      //playerSounds.play(Sounds.INVERTED);
      //inverted = true;
      //invertedTimer = INVERTED_STARTING_TIMER;
      modifyPower(PowerUpTypes.HP_UP);
      break;
    case PowerUpTypes.IMMUNE:
      playerSounds.play(Sounds.IMMUNE);
      hasImmune = true;
      break;
    case PowerUpTypes.SLOW:
      //playerSounds.play(Sounds.SLOW);
      //slow = true;
      //slowTimer = SLOW_STARTING_TIMER;
      modifyPower(PowerUpTypes.HP_UP);
      break;
    case PowerUpTypes.SPLIT:
      playerSounds.play(Sounds.SPLIT);
      if (!split)
      {
        if ( x > gamefield.GAMEFIELD_WIDTH / 2 )
        {
          x = gamefield.GAMEFIELD_WIDTH - x - playerWidth;
        }
      }
      widthSplit0 = playerWidth * SPLIT_WIDTH_MODIFIER ;
      widthSplit1 = playerWidth * SPLIT_WIDTH_MODIFIER;
      xSplit = gamefield.GAMEFIELD_WIDTH - x - widthSplit1;
      split = true;
      splitTimer=SPLIT_STARTING_TIMER;
      break;
    case PowerUpTypes.HP_UP:
      restoreHealth( 30 );
      break;
    case PowerUpTypes.AMMO_UP:
      gainAmmo(5);
      break;
    case PowerUpTypes.BOOM_BALL:
      for (Ball ball : balls) 
      {
        ball.isChargedBom=true;
      }
      break;
    case PowerUpTypes.EXTRA_BALL:
      //balls.add(new Ball(y-500));
      restoreHealth(40);
      break;
    default:
      println("modifyPower default");
    }
  }

  private void activateImmune() {
    if (!hasImmune) {
      return;
    } else {
      hasImmune=false; 
      immune=true;
      immuneTimer=IMMUNE_STARTING_TIMER;
    }
  }

  private float getMinY() {
    return  hasMoved() ? gamefield.PLAYER_MIN_Y : 0 ;
  }

  //Prevents the player from going out of bounds
  private void detectCollisionEdge() 
  {
    //the player is allowd to go everywhere during the movement tutorial
    if ( y < getMinY())
    {
      y = getMinY();
      velocityY *= BOUNCE_MODIFIER;
    }
    if ( y + playerHeight > height  )
    {
      y = height - playerHeight;
      velocityY *= BOUNCE_MODIFIER;
    }
    //Unsplit X
    if (!split)
    {
      if ( x < 0 )
      {
        x = 0;
        velocityX *= BOUNCE_MODIFIER;
      }
      if ( x + playerWidth > gamefield.GAMEFIELD_WIDTH )
      {
        x = gamefield.GAMEFIELD_WIDTH - playerWidth;
        velocityX *= BOUNCE_MODIFIER;
      }
      //Split X
    } else if (split)
    {
      if ( x < 0 )
      {
        x = 0;
        velocityX *= BOUNCE_MODIFIER;
      }
      if ( x + widthSplit0 > gamefield.GAMEFIELD_WIDTH / 2 )
      {
        x = gamefield.GAMEFIELD_WIDTH / 2 - widthSplit0;
        velocityX *= BOUNCE_MODIFIER;
      }
      if ( xSplit < gamefield.GAMEFIELD_WIDTH / 2 )
      {
        xSplit = gamefield.GAMEFIELD_WIDTH / 2;
        velocityXSplit *= BOUNCE_MODIFIER;
      }
      if ( xSplit + widthSplit1 > gamefield.GAMEFIELD_WIDTH )
      {
        xSplit = gamefield.GAMEFIELD_WIDTH - widthSplit1;
        velocityXSplit *= BOUNCE_MODIFIER;
      }
    }
  }

  //decelerates the player
  private void decelerate()
  {
    if (!(keysPressed[LEFT] || keysPressed[RIGHT]))
    {
      velocityX *= decelerateX;
      velocityX=stopVelocity(velocityX);
      if (split)
      {
        velocityXSplit *= decelerateX;
        velocityXSplit=stopVelocity(velocityXSplit);
      }
    }
    if (!(keysPressed[UP] || keysPressed[DOWN]))
    {
      velocityY *= decelerateY;
      velocityY=stopVelocity(velocityY);
    }
  }

  //returns 0 if the velocity is really low.
  private float stopVelocity(float v) {
    return v<VELOCITY_MIN && v>-VELOCITY_MIN ? 0 : v;
  }
  //shrinks the paddle
  public void dealDamage( float damage, boolean isRight)
  {
    if (shake || immune)
    {
      return;
    } 
    playerSounds.play(Sounds.RECIEVE_DAMAGE);
    shake = true;
    shakeTimer = SHAKE_STARTING_TIMER;
    if (split)//<- als ie shaked moet ie geen dmg nemen, handig voor balancing en betere feel.
    {
      if (isRight)
      {
        widthSplit1 -= damage;
      } else
      {
        widthSplit0 -= damage;
      }
      if (widthSplit0<PLAYER_MIN_WIDTH || widthSplit1 <PLAYER_MIN_WIDTH)
      {
        endSplit();
      }
    } else if (!split)
    {
      playerWidth -= damage;
      if ( playerWidth < PLAYER_MIN_WIDTH )
      {
        endscreen.loseGame();
      }
    }
  }



  //grows the paddle
  public void restoreHealth( float healing)
  {
    playerSounds.play(Sounds.RESTORE_HEALTH);
    if ( widthSplit1 < PLAYER_MAX_WIDTH / 2 ) 
    {
      widthSplit1 += healing;
      x-=healing*0.5;
    }
    if ( widthSplit0 < PLAYER_MAX_WIDTH / 2 )
    {
      widthSplit0 += healing;
      x-=healing*0.5;
    } 
    if ( playerWidth < PLAYER_MAX_WIDTH )
    {
      playerWidth += healing;
      x-=healing*0.5;
    }
  }

  //Keeps track of which powers are active and deactivates them.
  private void powerCountdown()
  {
    if (ballHitState==BallHit.GROW) {
      ballHitTimer--;
      if (ballHitTimer <= 0) {
        ballHitState=BallHit.SHRINK;
      }
    }
    if (inverted)
    {
      invertedTimer--;
      if ( invertedTimer <= 0 )
      {
        inverted=false;
      }
    }
    if (immune)
    {
      immuneTimer--;
      if ( immuneTimer <= 0 )
      {
        immune=false;
      }
    }
    if (slow)
    {
      slowTimer--;
      if ( slowTimer <= 0 )
      {
        slow=false;
      }
    }
    if (shake)
    {
      shakeTimer--;
      slowTimer=0;
      invertedTimer=0;
      if ( shakeTimer <=0 )
      {
        shake=false;
      }
    }
    if (split)
    {
      splitTimer--;
      if ( splitTimer <= 0 )
      {
        endSplit();
      }
    }
    if (shootTimer>0)
    {
      shootTimer--;
    }
  }

  void blinkPower(PImage powerImg)
  {
    if (frameCount % POWER_BLINK_DELAY == 0)
    {
      image = (image == playerForcefieldImg ? powerImg : playerForcefieldImg );
    }
  }

  //Retrieves the color the player should have.
  private PImage changeImage()
  {
    if (shake)
    {
      return playerDmgImg;
    }
    if ( inverted )
    {
      return playerReverseImg;
    } else if (immune)
    {
      if ( immuneTimer < SECOND*3 )
      {
        blinkPower(playerShieldImg);
      }
      return playerShieldImg;
    } else if (slow)
    {
      return playerSlowImg;
    } else
    {
      return playerForcefieldImg;
    }
  }
  //checks if you can shoot a bullet.
  private void shoot()
  {
    if ( ammo<1 )
    {
      playerSounds.play(Sounds.NO_AMMO);
      return;
    } 
    shootTimer=SHOOT_STARTING_TIMER;
    playerSounds.play(Sounds.SHOOT);
    ammo--;
    if (split)
    {
      spawnBullet(x+widthSplit0/2);
      spawnBullet(xSplit+widthSplit1/2);
    } else
    {
      spawnBullet(x+playerWidth/2);
    }
  }
  //adds aditional ammo.
  public void gainAmmo( int newAmmo )
  {
    ammo += newAmmo;
  }

  //shoots a bullet and adds particles
  public void spawnBullet(float x) {
    activatesBullet(x);
    emitParticles(x, y, BULLET_PARTICLES, false);
  }

  //activates a bullet.
  private void activatesBullet(float xT)
  {
    for ( PlayerBullet playerBullet : playerBullets)
    {
      if (!playerBullet.shootBullet)
      {
        playerBullet.createBullet(xT, y);
        return;
      }
    }
  }

  //updates the hitboxes.
  private void updateHitboxes()
  {
    hitboxes.update(x, xSplit, y, playerWidth, widthSplit0, widthSplit1, playerHeight, split );
  }

  //returns the hitboxes
  public Rectangles getHitboxes()
  {
    return hitboxes;
  }

  //unsplits the player
  private void endSplit()
  {
    split=false;
    playerWidth=widthSplit0+widthSplit1;
    if (playerWidth>PLAYER_MAX_WIDTH) {
      playerWidth=PLAYER_MAX_WIDTH;
    }
    splitTimer=0;
    if (widthSplit0>=widthSplit1)
    {
      return;
    } else
    {
      x=xSplit;
    }
  }
  public int getAmmo()
  {
    return ammo;
  }
  public boolean getHasImmune() {
    return hasImmune;
  }

  //returns true if the player has moved in all directions
  public boolean hasMoved() {
    for (int i=0; i<moved.length; i++) {
      if (!moved[i]) {
        return false;
      }
    }
    return true;
  }
  public void setPosition(float x, float y) {
    this.x=x;
    this.y=y;
  }

  //adds juice to hittin the ball
  public void collideBall(float ballVY) {
    ballHitTimer=BALL_HIT_STARTING_TIMER;
    ballHitState=BallHit.GROW;
    ballHitHeight=random(PLAYER_START_HEIGHT*1.1, PLAYER_START_HEIGHT*1.5);
    velocityY+=(velocityY+ballVY)*BALL_HIT_Y_MODIFIER;
  }

  //makes the background red for a couple of frames after getting damaged
  public color giveBackgroundColor() {
    return shakeTimer>SHAKE_STARTING_TIMER-DAMAGE_FRAMES ? Colors.BLOOD_RED : Colors.BLACK;
  }

  //increases powerup spawnchance if the player is damaged
  public float getPowerUpChance() {
    return map (playerWidth, PLAYER_MIN_WIDTH, PLAYER_START_WIDTH, 0.7, 0.3);
  }
}


//stores hitbox information
class Rectangles
{
  public Rectangle rectangle0;
  public Rectangle rectangle1;

  Rectangles()
  {
    rectangle0 = new Rectangle();
    rectangle1 = new Rectangle();
  }
  //updates the rectangles
  public void update( float x, float xSplit, float y, float playerWidth, float widthSplit0, float widthSplit1, float playerHeight, boolean split )
  {
    float w0=playerWidth;
    float w1=playerWidth;

    if (split)
    {
      w0=widthSplit0;
      w1=widthSplit1;
    }
    rectangle0.update(x, y, w0, playerHeight, true);
    rectangle1.update(xSplit, y, w1, playerHeight, split );
  }
}


class Rectangle
{
  public float x, y, rectangleWidth, rectangleHeight;
  public boolean exists;
  public Rectangle()
  {
  }
  //updates the rectangle
  public void update(float x, float y, float rectangleWidth, float rectangleHeight, boolean exists)
  {
    this.x = x;
    this.y = y;
    this.rectangleWidth = rectangleWidth;
    this.rectangleHeight = rectangleHeight;
    this.exists = exists;
  }
}
