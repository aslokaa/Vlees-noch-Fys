//Galaxy Defence Force
//IG101-2, Vlees noch FYS
//Niklas Leeuwin, Brent Sijm, Olger Klok , Mika Spoelstra, Eele Roet, 

import processing.sound.*;

import de.bezier.data.sql.*;

Player player;
Test test;
// Arrays of booleans for Keyboard handling. One boolean for each keyCode from FYS
final int KEY_LIMIT = 1024;
boolean[] keyCodesPressed              = new boolean[KEY_LIMIT];
boolean[] keysPressed                  = new boolean[KEY_LIMIT];
ArrayList<Enemy> enemies               = new ArrayList<Enemy>();
ArrayList<EnemyBullet> enemyBullets    = new ArrayList<EnemyBullet>();
ArrayList<PlayerBullet> playerBullets  = new ArrayList<PlayerBullet>();
Power[] powers                         = new Power[Arrays.POWER_COUNT];
Particle[] particles                   = new Particle[Arrays.PARTICLE_COUNT];
Animation[] animations                 = new Animation[Arrays.ANIMATION_COUNT];
ArrayList<Ball> balls                  = new ArrayList<Ball>();
WaveFormat[] waveFormats               = new WaveFormat[Arrays.WAVE_FORMATS];
Button[] buttons                       = new Button[2];

int idPlayer, idCurrentGame;
int secondsPerMinute = 60;
int totalEnemiesKilled = 0;
int amountPowers = 8;
int[] pickUps = new int[amountPowers];
int[] uses = new int[amountPowers];
int[] spawned = new int[amountPowers];

boolean stateStart=true, stateLogin = false, statePlaying=false, statePaused=false, stateEnd=false, stateBossPing=false, stateBossLester=false;

Gamefield gamefield;
Space space;
Scores scores;
Startscreen startscreen;
Loginscreen loginscreen;
Pausescreen pausescreen;
Achievements achievement;
Endscreen endscreen;
PlayerSounds playerSounds;
MenuSounds menuSounds;
PFont font;
SoundFile introMusic;
BossPing ping;
BossLester lester;
ScreenScore screenScore;
TextKeyboard keyboard;
int loggedInPlayerID = 0;




void setup()
{
  size( 1600, 900, P2D); //16:9

  smooth(2);
  introMusic               = new SoundFile(this, "menuSounds" + '/' + "introMusic.wav");


  gamefield = new Gamefield(); 
  space                    = new Space();
  scores                   = new Scores();
  screenScore              = new ScreenScore();
  player                   = new Player();
  ping                     = new BossPing();
  lester                   = new BossLester(gamefield.GAMEFIELD_WIDTH / 2, -300);
  test                     = new Test();
  startscreen              = new Startscreen();
  loginscreen              = new Loginscreen();
  pausescreen              = new Pausescreen();
  endscreen                = new Endscreen();
  font                     = loadFont("ComicSansMS-BoldItalic-40.vlw");
  loadAssets();
  imageMode(CENTER);

  //instantiateBoxes();
  //textboxes[textBoxesIndex = 1].isFocused = true;
}

void updateGame()
{ 
  if (stateStart)
  {
    startscreen.update();
  } else if ( stateLogin )
  {
    loginscreen.update();
  } else if (statePlaying)
  {
    pausescreen.update();
    if (!statePaused)
    {
      gamefield.update();
      player.update();
      if (stateBossPing)
      {
        ping.update();
      }
      if (stateBossLester)
      {
        lester.update();
      }
      for ( Enemy enemy : enemies )
      {
        enemy.executeBehavior();//handles movement paterns
      }

      for ( int i = 0; i < Arrays.POWER_COUNT; i++ )
      {
        powers[i].update();
      }
      for ( int i = 0; i < Arrays.PARTICLE_COUNT; i++ )
      {
        particles[i].update();
      }

      test.test();
      scores.update();


      for ( PlayerBullet playerBullet : playerBullets)
      {
        playerBullet.update();
      }
      for ( EnemyBullet bullet : enemyBullets )
      {
        bullet.update();
      }
      for (Ball ball : balls) {
        ball.updateBall();
      }
    }
  } else if (stateEnd)
  {
    endscreen.update();
  }
  //achievement.update();
  space.update();
}

void drawGame()
{ 
  if (stateStart)
  {
    startscreen.display();
  } else if ( stateLogin )
  {
    background(0);
    loginscreen.display();
  } else if (statePlaying)
  {
    background(player.giveBackgroundColor());

    space.display();

    for ( int i = 0; i < Arrays.POWER_COUNT; i++ )
    {
      powers[i].display();
    }

    for ( int i = 0; i < Arrays.PARTICLE_COUNT; i++ )
    {
      particles[i].display();
    }


    if (stateBossPing)
    {
      ping.display();
    }
    if (stateBossLester)
    {
      for ( EnemyBullet bullet : enemyBullets )
      {
        bullet.display();
      }
      lester.display();
    }
    for ( Enemy enemy : enemies )
    {
      enemy.display();//shows enemies on screen
    }
    for ( PlayerBullet playerBullet : playerBullets )
    {
      playerBullet.display();
    }

    for (Ball ball : balls) {
      ball.drawBall();
    }
    player.display();
    gamefield.displayWallFX();
    screenScore.drawScore();
    if (statePaused)
    {
      pausescreen.display();
    }
    //achievement.display();
    scores.display();
    gamefield.displayWallFX();
  } else if (stateEnd)
  {
    endscreen.display();
  }
}

// Keyboard handling...
void keyPressed() {  
  if (keyCode >= KEY_LIMIT) return; //safety: if keycode exceeds limit, exit methhod ('return').
  keyCodesPressed[keyCode] = true; // set its boolean to true
  if ( stateLogin )
  {
    if ( loginscreen.pickingOption )
    {
      handleButtonNav();
    } else {
      keyboard.handleTextInput();
    }
  }
  if (key>=KEY_LIMIT) return;
  keysPressed[key] = true;

  if ( keyCode == ESC ) 
  {
    if (statePlaying)
    {
      pausescreen.escapePressed=true; //changes pause state
    }
    key=0; //now the game doesn't exit after escape is pressed.
  }
  gamefield.checkRoundSkip();
}

//..and with each key Released vice versa from FYS
void keyReleased() {
  if (keyCode >= KEY_LIMIT) return;
  keyCodesPressed[keyCode] = false;
  if (key>=KEY_LIMIT) return;
  keysPressed[key] = false;
}

void draw()
{
  updateGame();
  drawGame();
}
