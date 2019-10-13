//Niklas Leeuwin
//500784205
//

//this class handles the endscreen.
class Endscreen
{
  void display()
  {
    background(Colors.BLACK);
    menuSounds.play(Sounds.END_MUSIC);
  }
  void update()
  {
    restart();
  }

  //restarts the game
  void restart()
  {
    if (checkInput())
    {
      player = new Player();
      stateEnd=false;
      stateStart=true;
    }
  }

  //checks wether z is pressed
  boolean checkInput()
  {
    if (keysPressed['z'])
    {
      keysPressed['z']=false;
      return true;
    }
    return false;
  }
  void loseGame()
  {
    statePlaying=false;
    stateEnd=true;
  }
}
