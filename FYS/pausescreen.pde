//Niklas Leeuwin
//500784205
//

//this class handles pausing the game.
class Pausescreen
{
  private final float
    TITLE_SIZE                    = width * 0.09, 
    SUBTITLE_SIZE                 = width * 0.04, 
    TEXT_CENTER_X                 = width * 0.5, 
    OPTION_SPACING_Y              = height * 0.1, 
    OPTION_Y                      = height * 0.6, 
    TITLE_Y                       = height * 0.5;

  private final String[] OPTIONS_STRINGS  = new String[]
    {
  /*   0    */    "Press escape to unpause", 
  /*   1    */    "Press Z to end the game", 
  /*   2    */    //"Press S to decrease the volume", 
  /*   3    */    //"press Z to mute"
  };
  private boolean 
    escapePressed;

  Pausescreen() {
  }

  Text[] option = new Text[Arrays.OPTION_COUNT];

  public void display()
  {
    displayText();
  }

  public void update()
  {
    changePausedState();
    detectInput();
  }

  // pauses or unpauses the game.
  private void changePausedState()
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

  //detects player input
  private void detectInput()
  {
    if (statePaused)
    {
      if (keysPressed['z'])
      {
        endscreen.loseGame();
      }
    }
  }

  //displays text
  private void displayText()
  {
    textFont(font, TITLE_SIZE);
    fill(Colors.RED);
    text("PAUSED", TEXT_CENTER_X, TITLE_Y);
    textFont(font, SUBTITLE_SIZE);
    for (int i = 0; i<OPTIONS_STRINGS.length; i++)
    {
      text(OPTIONS_STRINGS[i], TEXT_CENTER_X, OPTION_Y+OPTION_SPACING_Y*i);
    }
  }

//handles the text for the pausescreen
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
