 //Galaxy Defence Force
//IG101-2, Vlees noch FYS
//Niklas Leeuwin, Brent Sijm, Olger Klok ,Tim Brouwenstijn, Mika Spoelstra, Eele Roet, 

PlayerControlled player;
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


void setup()
{
  size( 1280, 720, P2D ); //16:9
  smooth(0);
  player = new PlayerControlled();
  test = new Test();
  enemies.add(new EnemyDave( 100, 0, DAVE_HITBOX_RADIUS ));
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
  background(0);

  for ( Enemy enemy : enemies )
  {
    enemy.display();//shows enemies on screen
  }
  player.checkDisplay();
  for ( PlayerBullet playerBullet : playerBullets )
  {
  playerBullet.display();
  }
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
