//Niklas Leeuwin
//500784205
//

//this class handles pausing the game.
class Pausescreen
{
  final float
    TITLE_SIZE            = width * 0.09, 
    SUBTITLE_SIZE         = width * 0.04, 
    TEXT_CENTER_X         = width * 0.5, 
    TITLE_Y               = height * 0.5;
  final String
    option0               = "Press escape to unpause", 
    option1               = "Press A to increase the volume", 
    option2               = "Press S to decrease the volume", 
    option3               = "press Z to mute";
  boolean 
    escapePressed         =false;
  Text[] option = new Text[Arrays.OPTION_COUNT];

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
      if (statePaused)
      {
        menuSounds.play(Sounds.UNPAUSE);
      } else
      {
        menuSounds.play(Sounds.PAUSE);
      }
      statePaused=!statePaused;
      escapePressed=false;
    }
  }
  void initializeOptions()
  {
    //option[0]=new Text(TEXT_CENTER_X,);
    //option[1]=new Text(TEXT_CENTER_X,);
    //option[2]=new Text(TEXT_CENTER_X,);
    //option[3]=new Text(TEXT_CENTER_X,);
  }

  //displays text
  void displayText()
  {
    textFont(font, TITLE_SIZE);
    fill(Colors.RED);
    text("PAUSED", TEXT_CENTER_X, TITLE_Y);
    textFont(font, SUBTITLE_SIZE);
    //for (int i = 0; i<OPTIONS; i++)
    //{
    //  text("Press Escape to unpause", OPTION0_X, OPTION1_Y);
    //}
  }
  class Text
  {
    float   x, y;
    String  text;
    Text(float xT, float yT, String textT)
    {
      x    = xT;
      y    = yT;
      text = textT;
    }
  }
}
