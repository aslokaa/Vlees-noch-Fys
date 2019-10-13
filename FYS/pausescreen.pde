//Niklas Leeuwin
//500784205
//

//this class handles pausing the game.
class Pausescreen
{
  final float
    titleSize      = width * 0.09, 
    titleX         = width * 0.5, 
    titleY         = height * 0.5;
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
    textFont(font, titleSize);
    fill(Colors.RED);
    text("PAUSED", titleX, titleY);
  }
}
