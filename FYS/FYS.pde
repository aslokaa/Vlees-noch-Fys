//Galaxy Defence Force
//IG101-2, Vlees noch FYS
//Niklas Leeuwin, Brent Sijm, Olger Klok ,Tim Brouwenstijn, Mika Spoelstra, Eele Roet, 
// x is bottom keys

//import processing.sound.*;


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
boolean state0=true,state1=false;

void setup()
{
  size( 1280, 720, P2D ); //16:9
  smooth(0);
  player = new Player();
  test = new Test();
  enemies.add(new EnemyDave( 100, 0, DAVE_HITBOX_RADIUS ));
  enemies.add(new EnemyChad( 600, 200, CHAD_HITBOX_RADIUS));
  intializeBackgroundStars(); 
}

void updateGame()
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

void drawGame()
{
  if (state0)
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
}

// Keyboard handling...
void keyPressed() {  
  if (keyCode >= KEY_LIMIT) return; //safety: if keycode exceeds limit, exit methhod ('return').
  keyCodesPressed[keyCode] = true; // set its boolean to true
  if (key>=KEY_LIMIT) return;
  keysPressed[key] = true;
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
