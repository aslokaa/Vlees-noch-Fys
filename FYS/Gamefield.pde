/*
  //waves hardcoden, randomisen met parameters, of nieuwe format maken voor waves?
 this class keeps track of where elements are spawned and the boundries they are allowed to be in.
 contains list of finals for outlining:
 where the player is allowed to move to,
 where the enemies are allowed to move to,
 where enemies are spawned in,
 a counter to keep track of rounds/waves of enemies,
 where the scorebar is placed,
 where the space class is used,
 where the player starts.
 
 Eele Roet 500795948
 Niklas Leeuwin  500784205
 */
class Gamefield
{
  final float 
    GAMEFIELD_WIDTH                 = width * 0.87, 
    PLAYER_MIN_Y                    = height / 2, 
    ENEMY_MAX_Y                     = height, 
    ENEMY_START_Y                   = height * -0.18, 
    ENEMY_START_X_LEFT              = GAMEFIELD_WIDTH * 0.06, 
    ENEMY_START_X_RIGHT             = GAMEFIELD_WIDTH * 0.94;  
  final int 
    CHAD_COUNTER_START              = 0, 
    DAVE_COUNTER_START              = 5, 
    CHAD_MAX                        = 10, 
    AMOUNT_OF_BOSSES                = 2, 
    DAVE_MAX                        = 50;

  int 
    waveCounter, 
    daveCounter, 
    chadCounter;
  boolean
    pingActivated, 
    lesterActivated;

  Gamefield()
  {
    daveCounter=DAVE_COUNTER_START;
    chadCounter=CHAD_COUNTER_START;
    waveCounter=9;
    pingActivated=false; 
    lesterActivated=false;
  }

  void update()
  {
    checkBossRotation();
    spawnWave(checkWave());
  }

  void setupField()
  {
    //sets enemies to not active, sets player position to start position, sets up/resets space and score.
  }

  //activates the spawn functions.
  void spawnWave(boolean spawnWave)
  {
    if (spawnWave)
    {
      for ( int i=0; i<daveCounter; i++)
      {
        spawnDaves(i);
      }
      waveCounter+=1;
      updateWaves();
    }
  }

  //spawns daves
  void spawnDaves(int yModifier)
  {
    for (Enemy enemy : enemies)
    {
      if (enemy instanceof EnemyDave)
      {
        if (!enemy.active)
        {
          float xT=ENEMY_START_X_LEFT;
          if (random(1)>0.5)
          {
            xT=ENEMY_START_X_RIGHT;
          }
          enemy.activate(xT, ENEMY_START_Y*(yModifier+1));
          break;
        }
      }
    }
  }

  //checks if all enemies are dead
  boolean checkWave()
  {
    return checkDave();
  }

  //checks if all daves are dead
  boolean checkDave()
  {
    for (Enemy enemy : enemies)
    {
      if (enemy instanceof EnemyDave)
      {
        if (enemy.active)
        {
          return false;
        }
      }
    }
    return true;
  }

  //modifies the makeup of waves.
  void updateWaves()
  {
    if ( daveCounter < DAVE_MAX )
    {
      daveCounter+=1;
    }
    if ( chadCounter < CHAD_MAX )
    {
      if ( waveCounter%3 == 0 )
      {
        chadCounter+=1;
      }
    }
    if ( waveCounter%10 == 0 )
    {
      chooseBoss();
    }
  }

  //selects a random boss
  void chooseBoss()
  {
    switch ((int)random(0, AMOUNT_OF_BOSSES))
    {
    case BossID.PING:
      if (pingActivated)
      {
        chooseBoss();
      } else
      {
        activatePing();
        println("tttttttt");
      }
      break;
    case BossID.LESTER:
      if (lesterActivated)
      {
        chooseBoss();
      } else
      {
        activateLester();
      }
      break;
    default:
      chooseBoss();
    }
  }

  //starts the ping boss fight
  void activatePing()
  {
    ping = new BossPing();
    pingActivated=true;
    stateBossPing=true;
  }

  //starts the lester boss fight
  void activateLester()
  {
    lester = new BossLester(width / 2, 100);
    lesterActivated=true;
    stateBossLester=true;
  }

  //checks if all bosses have been activated
  void checkBossRotation()
  {
    if ( pingActivated && lesterActivated )
    {
      pingActivated=false;
      lesterActivated=false;
    }
  }
}
