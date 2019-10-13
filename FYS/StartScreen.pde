//Niklas Leeuwin
//500784205
//

//this class handles the start screen.
class Startscreen
{
  final float
    titleSize      = width * 0.09, 
    subTitleSize   = width * 0.04, 
    titleX         = width * 0.5, 
    titleY         = height * 0.2, 
    subTitleX      = width * 0.5, 
    subTitleY      = height * 0.4;


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
    textFont(font, titleSize);
    textAlign(CENTER);
    fill(Colors.WHITE);
    text("Galaxy Defence Force", titleX, titleY);
    textFont(font, subTitleSize);
    fill(Colors.YELLOW);
    text("Press Any Key To Continue.", subTitleX, subTitleY);
  }
  //changes the gameState
  void updateGameStates()
  {
    if (checkInput())
    {
      state0=false;
      state1=true;
    }
  }
//checks if the user enters any key.
  boolean checkInput()
  {
    return (keyCodesPressed[LEFT]||keyCodesPressed[RIGHT]||keyCodesPressed[DOWN]||keyCodesPressed[UP]
      ||keysPressed['z']||keysPressed['x']||keysPressed['a']||keysPressed['s']);
  }
}
