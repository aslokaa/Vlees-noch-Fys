//Niklas Leeuwin
//500784205
//

//this class handles pausing the game.
class Pausescreen
{
  final float
    TITLE_SIZE      = width * 0.09, 
    TITLE_X         = width * 0.5, 
    TITLE_Y         = height * 0.5;
  boolean escapePressed=false;

  void display()
  {
    displayText();
  }

  void update()
  {
    changePausedState();
  }
  // pauses or unpauses the game.
  void changePausedState()
  {
    if (escapePressed)
    {
      statePaused=!statePaused;
      escapePressed=false;
    }
  }

  //displays text
  void displayText()
  {
    textFont(font, TITLE_SIZE);
    fill(Colors.RED);
    text("PAUSED", TITLE_X, TITLE_Y);
  }
}
