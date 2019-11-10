//Niklas Leeuwin
//500784205
//

//this class handles the endscreen.
class Endscreen
{
  void display()
  {
    background(Colors.WHITE);
    fill(Colors.BLACK);
    text("Press Z to restart", width/2, height/2);
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
      player            = new Player();
      gamefield         = new Gamefield();
      stateStart        =true; 
      statePlaying      =false;
      statePaused       =false;
      stateEnd          =false;
      stateBossPing     =false;
      stateBossLester   =false;
      for ( Enemy enemy : enemies )
      {
        enemy.destroy();
      }
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
