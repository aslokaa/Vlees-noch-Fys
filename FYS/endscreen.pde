//Niklas Leeuwin
//500784205
//

//this class handles the endscreen.
class Endscreen
{
  public void display()
  {
    background(Colors.WHITE);
    fill(Colors.BLACK);
    text("Press Select to restart.", width/2,height*0.3);
    text("Your score was " + score + " which you achieved in " + gamefield.getWaveCounter() + " waves.", width/2, height/2);
    menuSounds.play(Sounds.END_MUSIC);
  }
  public void update()
  {
    if (score <= 0) {// score can't go lower than 0
      score = 0;
    }
    restart();
  }

  //restarts the game
  private void restart()
  {
    if (checkInput())
    {
      player            = new Player();
      gamefield         = new Gamefield();
      stateStart        = true; 
      statePlaying      = false;
      statePaused       = false;
      stateEnd          = false;
      stateBossPing     = false;
      stateBossLester   = false;
      scores            = new Scores();
      for ( Enemy enemy : enemies )
      {
        enemy.destroy();
      }
      for (int i = 0; i < powers.length; i++)
      {
        powers[i].powerActive=false;
      }
      for (int i =0; i<particles.length; i++){
       particles[i].active=false; 
      }
      score             = 0;
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
