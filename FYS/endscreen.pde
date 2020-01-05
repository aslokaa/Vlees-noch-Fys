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
    textSize(40);
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
        enemy.active=false;
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
    achievement.increaseProgress(AchievementID.A_LITTLE_BIT,totalEnemiesKilled-achievement.getEnemiesTriggered());
    
    //updates the score, wave, time and amount of enemies killed and saves the amount of powers uses, pickups, spawned for each game and each power
    sql.query("UPDATE Game SET `score` ="+ score+",`wave` = "+ gamefield.waveCounter+",`time` = "+ scores.totalTime/secondsPerMinute+",`enemieskilled` = "+ totalEnemiesKilled+" WHERE idgame = "+idCurrentGame);
    //Unused powerups in array therefor no for loop used
    sql.query("INSERT INTO `Game_has_Power` (`uses`, `pickups`, `spawned`, `Game_idgame`, `Powers_name`) VALUES ("+uses[PowerUpTypes.IMMUNE]+", "+pickUps[PowerUpTypes.IMMUNE]+", "+spawned[PowerUpTypes.IMMUNE]+", "+idCurrentGame+", 'Immune')" );
    sql.query("INSERT INTO `Game_has_Power` (`uses`, `pickups`, `spawned`, `Game_idgame`, `Powers_name`) VALUES ("+uses[PowerUpTypes.SPLIT]+", "+pickUps[PowerUpTypes.SPLIT]+", "+spawned[PowerUpTypes.SPLIT]+", "+idCurrentGame+", 'Split')" );
    sql.query("INSERT INTO `Game_has_Power` (`uses`, `pickups`, `spawned`, `Game_idgame`, `Powers_name`) VALUES ("+uses[PowerUpTypes.HP_UP]+", "+pickUps[PowerUpTypes.HP_UP]+", "+spawned[PowerUpTypes.HP_UP]+", "+idCurrentGame+", 'Hp_Up')" );
    sql.query("INSERT INTO `Game_has_Power` (`uses`, `pickups`, `spawned`, `Game_idgame`, `Powers_name`) VALUES ("+uses[PowerUpTypes.AMMO_UP]+", "+pickUps[PowerUpTypes.AMMO_UP]+", "+spawned[PowerUpTypes.AMMO_UP]+", "+idCurrentGame+", 'Ammo_Up')" );
    sql.query("INSERT INTO `Game_has_Power` (`uses`, `pickups`, `spawned`, `Game_idgame`, `Powers_name`) VALUES ("+uses[PowerUpTypes.BOOM_BALL]+", "+pickUps[PowerUpTypes.BOOM_BALL]+", "+spawned[PowerUpTypes.BOOM_BALL]+", "+idCurrentGame+", 'Boom_Ball')" );
    
  }
}
