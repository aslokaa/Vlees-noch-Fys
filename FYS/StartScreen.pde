//Niklas Leeuwin
//500784205
//

//this class handles the startscreen.
class Startscreen
{
  final float
    TITLE_SIZE      = width * 0.09, 
    SUBTITLE_SIZE   = width * 0.04, 
    TITLE_X         = width * 0.5, 
    TITLE_Y         = height * 0.2, 
    SUBTITLE_X      = width * 0.5, 
    SUBTITLE_Y      = height * 0.4;
  boolean 
    drawn              =false, //checks if the start screen has been drawn.
    davesInitialized   =false, //checks if daves are initialized.
    chadsInitialized   =false, //checks if chads are initialized.
    bulletsInitialized =false, //checks if bullets are initialized.
    soundsInitialized  =false, //checks if sounds are initialized.
    powerInitialized   =false; //checks if powers are intitialized.

  void update()
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
  void display()
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
  void setupGame()
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
  }
  //initializes sound
  void loadSounds()
  {
    playerSounds  = new PlayerSounds();
    menuSounds    = new MenuSounds();
    soundsInitialized=true;
  }

  //initializes daves
  void loadDaves()
  {
    for ( int i = 0; i < gamefield.DAVE_MAX; i++ )
    {
      enemies.add(new EnemyDave( EnemyFinals.ENEMY_GRAVEYARD_X, EnemyFinals.ENEMY_GRAVEYARD_Y, EnemyFinals.DAVE_HITBOX_RADIUS ));
    }
    davesInitialized = true;
  }

  //initializes the chads
  void loadChads()
  {
    for (int i = 0; i < gamefield.CHAD_MAX; i++ )
    {
      enemies.add(new EnemyChad( 600, 200, EnemyFinals.CHAD_HITBOX_RADIUS));
    }
    chadsInitialized = true;
  }

  //initializes the bullets
  void loadBullets()
  {
    for (int i = 0; i < Arrays.BULLET_COUNT; i++) 
    {
      playerBullets.add( new PlayerBullet(0, 0));
      enemyBullets.add( new EnemyBullet());
    }

    bulletsInitialized = true;

  }

  void loadPowers()
  {
    for (int i = 0; i < Arrays.POWER_COUNT; i++) 
    {
      powers[i] =  new Power(-100, -100, 0);
    }
    powerInitialized = true;
  }

  //draws the background
  void displayBackground()
  {
    background(Colors.BLACK);
  }
  //draws the text.
  void displayText()
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
  void updateGameStates()
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
  boolean checkInput()
  {
    return (soundsInitialized &&(keyCodesPressed[LEFT]||keyCodesPressed[RIGHT]||keyCodesPressed[DOWN]||keyCodesPressed[UP]
      ||keysPressed['z']||keysPressed['x']||keysPressed['a']||keysPressed['s']));
  }
}
