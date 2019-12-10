//Niklas Leeuwin
//500784205
//


//This is the class that handles the object the player controlls. 

class Player
{
  public final float
    PLAYER_START_WIDTH              = gamefield.GAMEFIELD_WIDTH * 0.17, 
    PLAYER_START_HEIGHT             = height * 0.045, 
    PLAYER_START_X                  = gamefield.GAMEFIELD_WIDTH / 2-PLAYER_START_WIDTH/2, 
    PLAYER_START_Y                  = height - PLAYER_START_HEIGHT, 
    PLAYER_START_ACCELERATION_X     = gamefield.GAMEFIELD_WIDTH * 0.0035, 
    PLAYER_VELOCITY_X_MAX           = gamefield.GAMEFIELD_WIDTH * 0.014, 
    GROWTH_MODIFIER                 = 0.01, 
    PLAYER_START_DECELERATE_X       = 0.85, 
    PLAYER_START_DECELERATE_Y       = 0.85, 
    PLAYER_START_ACCELERATION_Y     = height * 0.003, 
    PLAYER_VELOCITY_Y_MAX           = height * 0.012, 
    PLAYER_MIN_WIDTH                = PLAYER_START_WIDTH*0.4, 
    PLAYER_MAX_WIDTH                = gamefield.GAMEFIELD_WIDTH*0.45, 
    VELOCITY_MIN                    = PLAYER_START_ACCELERATION_Y*0.01, 
    ROCKET_SPRITE_HEIGHT            = height * 0.09, 
    ROCKET_SPRITE_WIDTH             = ROCKET_SPRITE_HEIGHT*0.8, 
    SLOW_MODIFIER                   = 0.5, 
    SPLIT_WIDTH_MODIFIER            = 0.75, 
    BALL_HIT_MODIFIER               = 0.35, 
    BOUNCE_MODIFIER                 = -0.8, 
    SECOND                          = 60, //one second
    INVERTED_STARTING_TIMER         = SECOND*4, 
    IMMUNE_STARTING_TIMER           = SECOND*5, 
    SLOW_STARTING_TIMER             = SECOND*2, 
    SHAKE_MODIFIER                  = gamefield.GAMEFIELD_WIDTH *0.01, 
    SHAKE_STARTING_TIMER            = SECOND*0.5, 
    SHOOT_STARTING_TIMER            = SECOND*0.75, 
    BALL_HIT_STARTING_TIMER         = SECOND*0.3, 
    SPLIT_STARTING_TIMER            = SECOND*15;

  public final int
    ROCKET_PARTICLES                = 20,
    BULLET_PARTICLES                = 70,
    DAMAGE_FRAMES                   = 6,
    STARTING_BULLETS                = 5;

  private float 
    x, 
    xSplit, 
    y, 
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
    ballHit, //enlarges the paddle after hitting the ball.
    split;       //splits the paddle
  private float //Duration of effects.
    invertedTimer, 
    immuneTimer, 
    slowTimer, 
    shakeTimer, 
    splitTimer, 
    ballHitTimer, 
    shootTimer; 
  private int 
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
    velocityY         = PLAYER_VELOCITY_Y_MAX;
    decelerateX       = PLAYER_START_DECELERATE_X;
    decelerateY       = PLAYER_START_DECELERATE_Y;
    hitboxes          = new Rectangles();
    ammo              = STARTING_BULLETS;
    image             = playerForcefieldImg;
  }

  //updates the player
  public void update()
  {
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
    imageMode(CORNER);
    if (ballHit) {
      growBallHit();
    } else { 
      ShrinkPaddleBallHit();
      if (shake)
      {
        shake();
      } else {
        checkSplit();
      }
    }

    imageMode(CENTER);
  }

  //draws the standard player.
  private void display()
  { 
    image(image, x, y, playerWidth, playerHeight );
    image(playerSidesImg, x, y + playerHeight, ROCKET_SPRITE_WIDTH, ROCKET_SPRITE_HEIGHT);
    image(playerSidesImg, x + playerWidth - ROCKET_SPRITE_WIDTH, y + playerHeight, ROCKET_SPRITE_WIDTH, ROCKET_SPRITE_HEIGHT);
    if (checkVelocity()) {
      emitParticles(x+playerWidth-ROCKET_SPRITE_WIDTH/2, ROCKET_PARTICLES);
      emitParticles(x+ROCKET_SPRITE_WIDTH/2, ROCKET_PARTICLES);
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

  //shrinks the paddle after it grew from hitting a ball.
  private void ShrinkPaddleBallHit() {
    if (playerHeight>PLAYER_START_HEIGHT) {
      playerHeight+=(PLAYER_START_HEIGHT-playerHeight)/(BALL_HIT_STARTING_TIMER*3);
    }
    if (playerHeight + playerHeight*GROWTH_MODIFIER< PLAYER_START_HEIGHT || playerHeight < PLAYER_START_HEIGHT) {
      playerHeight=PLAYER_START_HEIGHT;
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

  //increases the paddleheight after hitting a ball.
  private void growBallHit() {
    playerHeight+=(ballHitHeight-playerHeight)/BALL_HIT_STARTING_TIMER;
    if (shake)
    {
      shake();
    } else {
      checkSplit();
    }
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
      emitParticles(xSplit+widthSplit1-ROCKET_SPRITE_WIDTH/2, ROCKET_PARTICLES/2);
      emitParticles(xSplit+ROCKET_SPRITE_WIDTH/2, ROCKET_PARTICLES/2);
      emitParticles(x+ROCKET_SPRITE_WIDTH/2, ROCKET_PARTICLES/2);
      emitParticles(x+widthSplit0-ROCKET_SPRITE_WIDTH/2, ROCKET_PARTICLES/2);
    }
  }

  //detects user inputs.
  private void detectInput()//spawn "rook" particles als de player links recht up en down beweegt. see activate method in Particle
  {
    if ( keyCodesPressed[LEFT] ) 
    {
      velocityX -= accelerationX ; //Accelerates to the left.
      if (split)
      {
        velocityXSplit += accelerationX;
      }
    }
    if ( keyCodesPressed[RIGHT] ) 
    {
      velocityX += accelerationX; //Accelerates to the right.
      if (split)
      {
        velocityXSplit -= accelerationX;
      }
    }
    if ( keyCodesPressed[UP] )
    {
      velocityY -= accelerationY; //Accelerates to upwards.
    }
    if ( keyCodesPressed[DOWN] )
    {
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
  private void emitParticles(float xSmoke, int amountOfParticles) {
    for ( int i = 0; i < amountOfParticles; i++ )
    {
      for ( Particle particle : particles )
      {
        if (!particle.active)
        {
          float particleSpeed = random( 5, 10 );
          float particleAngle = random( 0.8 * PI, 1.2 *PI );
          float particleSize = random( 20, 30 );
          float particleSpeedX = particleSpeed * sin(particleAngle) + velocityX / 2;
          float particleSpeedY = velocityY>-1 ? particleSpeed * -cos(particleAngle) + velocityY / 2 : particleSpeed * -cos(-particleAngle) + velocityY / 2;
          int particleLifespan = round(particleSize * 0.3 );
          particle.activateParticle( xSmoke, y+playerHeight+ROCKET_SPRITE_HEIGHT, particleSize, particleSpeedX, particleSpeedY, particleLifespan );
          break;
        }
      }
    }
  }
  //checks what powers should affect the movement.
  private void checkMove()
  {
    checkVelocityMax();
    if (slow) // slows the player
    {
      velocityX *= SLOW_MODIFIER;
      velocityY *= SLOW_MODIFIER;
    }
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
      playerSounds.play(Sounds.INVERTED);
      inverted = true;
      invertedTimer = INVERTED_STARTING_TIMER;
      break;
    case PowerUpTypes.IMMUNE:
      playerSounds.play(Sounds.IMMUNE);
      hasImmune = true;
      break;
    case PowerUpTypes.SLOW:
      playerSounds.play(Sounds.SLOW);
      slow = true;
      slowTimer = SLOW_STARTING_TIMER;
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

  //Prevents the player from going out of bounds
  private void detectCollisionEdge() 
  {
    //Y
    if ( y < gamefield.PLAYER_MIN_Y )
    {
      y = gamefield.PLAYER_MIN_Y;
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
    if (ballHit) {
      ballHitTimer--;
      if (ballHitTimer <= 0) {
        ballHit=false;
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
  public void spawnBullet(float x){
   activatesBullet(x);
   emitParticles(x, BULLET_PARTICLES);
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
  //
  public void collideBall(float ballVY) {
    ballHitTimer=BALL_HIT_STARTING_TIMER;
    ballHit=true;
    ballHitHeight=random(playerHeight*1.1, playerHeight*1.5);
    velocityY+=(velocityY+ballVY)*BALL_HIT_MODIFIER;
  }

  public color giveBackgroundColor() {
    return shakeTimer>SHAKE_STARTING_TIMER-DAMAGE_FRAMES ? Colors.BLOOD_RED : Colors.BLACK;
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
