//Niklas Leeuwin
//500784205
//

//this class handles the startscreen.

class Startscreen
{
  private final float
    TITLE_SIZE      = width * 0.09, 
    SUBTITLE_SIZE   = width * 0.04, 
    TITLE_X         = width * 0.5, 
    TITLE_Y         = height * 0.2, 
    SUBTITLE_X      = width * 0.5, 
    SUBTITLE_Y      = height * 0.4;
  public boolean 
    drawn              =false, //checks if the start screen has been drawn.
    davesInitialized   =false, //checks if daves are initialized.
    chadsInitialized   =false, //checks if chads are initialized.
    bulletsInitialized =false, //checks if bullets are initialized.
    soundsInitialized  =false, //checks if sounds are initialized.
    powerInitialized   =false, //checks if powers are intitialized.
    particleInitialized = false, 
    ballsInitialized = false, 
    animationInitialized = false,
    waveFormatsInitialized = false;

  Startscreen()
  {
    
    setupGame();
    
  }

  public void update()
  {
    updateGameStates();
    if ( drawn )
    {
      setupGame();
    } 
    if ( soundsInitialized )
    {
      menuSounds.stop(Sounds.END_MUSIC);
    }
  }
  public void display()
  {
    displayBackground();
    displayText();
    if (!introMusic.isPlaying())
    {      
      introMusic.play();
    }
    drawn=true;
  }
  //loads game
  private void setupGame()
  {
     
    if ( !soundsInitialized )
    {
      text("LOADING SOUND", SUBTITLE_X, SUBTITLE_Y);
      loadSounds();
    }
    if ( !davesInitialized )
    {
      text("LOADING DAVES", SUBTITLE_X, SUBTITLE_Y);
      loadDaves();
    }
    if ( !chadsInitialized)
    {
      text("LOADING CHADS", SUBTITLE_X, SUBTITLE_Y);
      loadChads();
    }
    if ( !bulletsInitialized )
    {
      text("LOADING BULLETS", SUBTITLE_X, SUBTITLE_Y);
      loadBullets();
    }
    if ( !powerInitialized )
    {
      text("LOADING POWERS", SUBTITLE_X, SUBTITLE_Y);
      loadPowers();
    }
    if ( !particleInitialized )
    {
      text("LOADING PARTICLES", SUBTITLE_X, SUBTITLE_Y);
      loadParticles();
    }
    if ( !animationInitialized )
    {
      text("LOADING ANIMATIONS", SUBTITLE_X, SUBTITLE_Y);
      loadAnimations();
    }
    if (!ballsInitialized) {
      loadBalls();
    }
    
    if ( !waveFormatsInitialized )
    {
      loadWaveFormats();
    }
    
    
    
  }
  //initializes sound
  private void loadSounds()
  {
    playerSounds  = new PlayerSounds();
    menuSounds    = new MenuSounds();
    soundsInitialized=true;
  }

  private void loadBalls() {
    balls.add(new Ball());
    ballsInitialized=true;
  }

  //initializes daves
  private void loadDaves()
  {
    for ( int i = 0; i < Arrays.DAVE_MAX; i++ )
    {
      enemies.add(new EnemyDave( EnemyFinals.ENEMY_GRAVEYARD_X, EnemyFinals.ENEMY_GRAVEYARD_Y, 0, EnemyFinals.DAVE_HITBOX_RADIUS));
    }
    davesInitialized = true;
  }

  //initializes the chads
  private void loadChads()
  {
    for (int i = 0; i < Arrays.CHAD_MAX; i++ )
    {
      enemies.add(new EnemyChad( EnemyFinals.ENEMY_GRAVEYARD_X, EnemyFinals.ENEMY_GRAVEYARD_Y, EnemyFinals.CHAD_HITBOX_RADIUS));
    }
    enemies.add( new EnemyDullChad ( EnemyFinals.ENEMY_GRAVEYARD_X, EnemyFinals.ENEMY_GRAVEYARD_Y, EnemyFinals.CHAD_HITBOX_RADIUS));
    chadsInitialized = true;
  }

  //initializes the bullets
  private void loadBullets()
  {
    for (int i = 0; i < Arrays.BULLET_COUNT; i++) 
    {
      playerBullets.add( new PlayerBullet(0, 0));
      enemyBullets.add( new EnemyBullet());
    }

    bulletsInitialized = true;
  }

  private void loadPowers()
  {
    for (int i = 0; i < Arrays.POWER_COUNT; i++) 
    {
      powers[i] =  new Power(-100, -100, 0);
    }
    powerInitialized = true;
  }

  private void loadParticles()
  {
    for (int i = 0; i < Arrays.PARTICLE_COUNT; i++) 
    {
      particles[i] =  new Particle(-100, -100, 0, 0, 0);
    }
    particleInitialized = true;
  }

  private void loadAnimations()
  {
    for (int i = 0; i < Arrays.ANIMATION_COUNT; i++) 
    {
      animations[i] =  new Animation();
    }
    animationInitialized = true;
  }
  
  private void loadWaveFormats()
  {
      waveFormats[0] =  new WaveFormat( 0, 0, 0, 1000, 1000, false, false, false, false, false );
      waveFormats[1] =  new WaveFormat( 0, 0, 0, 800, 800, false, false, true, true, true );
      waveFormats[2] =  new WaveFormat( 20, 0, 0, 60, 3600  , false, false, true, true, true );
      waveFormats[3] =  new WaveFormat( 0, 0, 0, 300, 600, false, false, false, false, true );
      waveFormats[4] =  new WaveFormat( 25, 2, 0, 300, 2000, false, false, true, false, true );
      waveFormats[5] =  new WaveFormat( 30, 4, 0, 300, 2000, false, false, true, false, true );
      waveFormats[6] =  new WaveFormat( 0, 0, 0, 300, 6000, false, true, true, false, false );
      waveFormats[7] =  new WaveFormat( 0, 0, 0, 300, 6000, true, false, true, false, false );

      
      
      
    
    waveFormatsInitialized = true;
  }
  
  

  //draws the background
  private void displayBackground()
  {
    background(Colors.BLACK);
  }
  //draws the text.
  private void displayText()
  {
    textFont(font, TITLE_SIZE);
    textAlign(CENTER);
    fill(Colors.WHITE);
    text("Galaxy Defence Force", TITLE_X, TITLE_Y);
    textFont(font, SUBTITLE_SIZE);
    fill(Colors.YELLOW);
    if (soundsInitialized)
    {
      text("Press Any Key To Continue.", SUBTITLE_X, SUBTITLE_Y);
    } else
    {
      text("LOADING", SUBTITLE_X, SUBTITLE_Y);
    }
  }
  //changes the gameState
  private void updateGameStates()
  {
    if (checkInput())
    {
      introMusic.stop();
      menuSounds.play(Sounds.START_GAME);
      stateStart=false;
      statePlaying=true;
    }
  }
  //checks if the user enters any key.
  private boolean checkInput()
  {
    return (soundsInitialized &&(keyCodesPressed[LEFT]||keyCodesPressed[RIGHT]||keyCodesPressed[DOWN]||keyCodesPressed[UP]
      ||keysPressed['z']||keysPressed['x']||keysPressed['a']||keysPressed['s']));
  }
}
