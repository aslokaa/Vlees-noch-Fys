//Galaxy Defence Force
//IG101-2, Vlees noch FYS
//Niklas Leeuwin, Brent Sijm, Olger Klok , Mika Spoelstra, Eele Roet, 
// x is bottom keys

import processing.sound.*;


Player player;
Test test;
// Arrays of booleans for Keyboard handling. One boolean for each keyCode from FYS
final int KEY_LIMIT = 1024;
boolean[] keyCodesPressed = new boolean[KEY_LIMIT];
boolean[] keysPressed = new boolean[KEY_LIMIT];
final float DAVE_GRID_HEIGHT = 100;
final float DAVE_HITBOX_RADIUS = 40;
final color DAVE_COLOR = color(255, 20, 20);
final float CHAD_HITBOX_RADIUS = 40;
final color CHAD_COLOR = color(255, 20, 20);
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<PlayerBullet> playerBullets = new ArrayList<PlayerBullet>();
Space[] space = new Space[Arrays.STAR_COUNT];
boolean stateStart=true, statePlaying=false, statePaused=false,stateEnd=false;
Startscreen startscreen;
Pausescreen pausescreen;
Endscreen endscreen;
PlayerSounds playerSounds;
MenuSounds menuSounds;
PFont font;
SoundFile introMusic;


void setup()
{
  size( 1600, 900, P2D ); //16:9
  smooth(0);
  introMusic = new SoundFile(this, "menuSounds" + '/' + "introMusic.wav");
  player = new Player();
  test = new Test();
  enemies.add(new EnemyDave( 100, 0, DAVE_HITBOX_RADIUS ));
  //enemies.add(new EnemyChad( 600, 200, CHAD_HITBOX_RADIUS));
  for (int i = 0; i < Arrays.BULLET_COUNT; i++){
   playerBullets.add( new PlayerBullet(0,0));
  }
  intializeBackgroundStars();
  startscreen   = new Startscreen();
  pausescreen   = new Pausescreen();
  endscreen     = new Endscreen();
  font = loadFont("ComicSansMS-BoldItalic-40.vlw");
}

void updateGame()
{
  if (stateStart)
  {
    startscreen.update();
  } else if (statePlaying)
  {
    pausescreen.update();
    if (!statePaused)
    {
      for ( Enemy enemy : enemies )
      {
        enemy.executeBehavior();//handles movement paterns
      }

      player.update();
      test.test();
      for ( PlayerBullet playerBullet : playerBullets)
      {
        playerBullet.update();
      }
    }
  } else if (stateEnd)
  {
    endscreen.update();
  }
}

void drawGame()
{
  if (stateStart)
  {
    startscreen.display();
  } else if (statePlaying)
  {
    background(0);
    for ( int i = 0; i < space.length; i++ )
    {
      space[i].display();
    }
    for ( Enemy enemy : enemies )
    {
      enemy.display();//shows enemies on screen
    }
    for ( PlayerBullet playerBullet : playerBullets )
    {
      playerBullet.display();
    }
    player.checkDisplay();
    if (statePaused)
    {
      pausescreen.display();
    }
  } else if (stateEnd)
  {
    endscreen.display();
  }
}

// Keyboard handling...
void keyPressed() {  
  if (keyCode >= KEY_LIMIT) return; //safety: if keycode exceeds limit, exit methhod ('return').
  keyCodesPressed[keyCode] = true; // set its boolean to true
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
