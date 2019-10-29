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
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<PlayerBullet> playerBullets = new ArrayList<PlayerBullet>();
ArrayList<Ball> balls = new ArrayList<Ball>();
Power[] powers = new Power[12];
Space[] space = new Space[Arrays.STAR_COUNT];
boolean stateStart=true, statePlaying=false, statePaused=false, stateEnd=false, stateBossPing=false;
Gamefield gamefield;
Startscreen startscreen;
Pausescreen pausescreen;
Endscreen endscreen;
PlayerSounds playerSounds;
MenuSounds menuSounds;
PFont font;
SoundFile introMusic;
BossPing ping;
BossLester lester;


void setup()
{
  size( 1600, 900, P2D ); //16:9
  smooth(0);
  introMusic = new SoundFile(this, "menuSounds" + '/' + "introMusic.wav");
  gamefield = new Gamefield();
  player = new Player();
  ping = new BossPing();
  lester = new BossLester(width / 2, 100);
  test = new Test();
  balls.add(new Ball());
  
  for ( int daves = 0; daves < 10; daves++ )
  {
    enemies.add(new EnemyDave( 100, -daves * gamefield.ENEMY_START_Y , EnemyFinals.DAVE_HITBOX_RADIUS ));
  }
  enemies.add(new EnemyChad( 600, 200, EnemyFinals.CHAD_HITBOX_RADIUS));
  for (int i = 0; i < Arrays.BULLET_COUNT; i++) {
    playerBullets.add( new PlayerBullet(0, 0));
  }
  startscreen   = new Startscreen();
  pausescreen   = new Pausescreen();
  endscreen     = new Endscreen();
  font          = loadFont("ComicSansMS-BoldItalic-40.vlw");
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
      if (stateBossPing)
      {
        ping.update();
      }
      for ( Enemy enemy : enemies )
      {
        enemy.executeBehavior();//handles movement paterns
      }

      player.update();
      lester.update();
      test.test();

      for ( PlayerBullet playerBullet : playerBullets)
      {
        playerBullet.update();
      }
      for (Ball ball : balls) {
        ball.updateBall();
      }
    }
  } else if (stateEnd)
  {
    endscreen.update();
  }
  for ( int i = 0; i < space.length; i++ )
  {
   // space[i].update();
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
    fill(Colors.RED);
    rect(gamefield.GAMEFIELD_WIDTH,0,width,height);
    for ( int i = 0; i < space.length; i++ )
    {
//      space[i].display();
    }
    
      if (stateBossPing)
      {
        ping.display();
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
    player.checkDisplay();
    lester.display();
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
