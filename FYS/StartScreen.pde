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
  boolean 
    drawn              =false, //checks if the start screen has been drawn.
    soundsInitialized  =false; //checks if sounds are initialized.

  void update()
  {
    updateGameStates();
    if ( drawn )
    {
      setupGame();
    } 
    if ( soundsInitialized )
    {
      menuSounds.stop(Sounds.END_MUSIC);
    }
  }
  void display()
  {
    displayBackground();
    displayText();
    if (!introMusic.isPlaying())
    {      
      introMusic.play();
    }
    drawn=true;
  }
  //loads game
  void setupGame()
  {
    if ( !soundsInitialized )
    {
      playerSounds  = new PlayerSounds();
      menuSounds    = new MenuSounds();
      soundsInitialized=true;
    }
  }
  //draws the background
  void displayBackground()
  {
    background(Colors.WHITE);
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
    if (soundsInitialized)
    {
      text("Press Any Key To Continue.", SUBTITLE_X, SUBTITLE_Y);
    } else
    {
      text("LOADING", SUBTITLE_X, SUBTITLE_Y);
    }
  }
  //changes the gameState
  void updateGameStates()
  {
    if (checkInput())
    {
      introMusic.stop();
      menuSounds.play(Sounds.START_GAME);
      stateStart=false;
      statePlaying=true;
    }
  }
  //checks if the user enters any key.
  boolean checkInput()
  {
    return (soundsInitialized &&(keyCodesPressed[LEFT]||keyCodesPressed[RIGHT]||keyCodesPressed[DOWN]||keyCodesPressed[UP]
      ||keysPressed['z']||keysPressed['x']||keysPressed['a']||keysPressed['s']));
  }
}
