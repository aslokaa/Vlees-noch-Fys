PC player;
Test test;
// Arrays of booleans for Keyboard handling. One boolean for each keyCode from FYS
final int KEY_LIMIT = 1024;
boolean[] keyCodesPressed = new boolean[KEY_LIMIT];
boolean[] keysPressed = new boolean[KEY_LIMIT];

void setup()
{
  size(1280,720); //16:9
  player = new PC();
  test = new Test();
}

void updateGame()
{
  player.update();
  test.damage();
}

void drawGame()
{
  background(0);
  player.display();
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
