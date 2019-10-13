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


  void update()
  {
    updateGameStates();
  }
  void display()
  {
    displayBackground();
    displayText();
  }
  //draws the background
  void displayBackground()
  {
    background(0);
    for ( int i = 0; i < space.length; i++ )
    {
      space[i].display();
    }
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
    text("Press Any Key To Continue.", SUBTITLE_X, SUBTITLE_Y);
  }
  //changes the gameState
  void updateGameStates()
  {
    if (checkInput())
    {
      stateStart=false;
      statePlaying=true;
    }
  }
//checks if the user enters any key.
  boolean checkInput()
  {
    return (keyCodesPressed[LEFT]||keyCodesPressed[RIGHT]||keyCodesPressed[DOWN]||keyCodesPressed[UP]
      ||keysPressed['z']||keysPressed['x']||keysPressed['a']||keysPressed['s']);
  }
}
