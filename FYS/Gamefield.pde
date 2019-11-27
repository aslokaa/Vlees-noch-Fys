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
  public final float 
    GAMEFIELD_WIDTH                 = width * 0.87, 
    PLAYER_MIN_Y                    = height / 2, 
    ENEMY_MAX_Y                     = height, 
    ENEMY_START_Y                   = height * -0.13, 
    ENEMY_START_X                   = GAMEFIELD_WIDTH * 0.06, 
    ENEMY_START_X_ALT               = GAMEFIELD_WIDTH * 0.94;

  private final int 
    CHAD_COUNTER_START              = 0, 
    DAVE_COUNTER_START              = 10, 
    CHAD_MAX                        = 10, 
    AMOUNT_OF_BOSSES                = 2, //<>//
    WAVES_UNTILL_DAVE               = 1,
    WAVE3_CHADS                     = 2,
    WAVES_UNTILL_CHAD               = 3, 
    WAVES_UNTILL_BOSS               = 5, 
    DAVE_MAX                        = 50; //<>//

  private int 
    waveCounter, 
    daveCounter, 
    chadCounter;
  private boolean
    pingActivated, 
    lesterActivated, 
    spawnPing, 
    spawnLester;

  public Gamefield()
  {
    daveCounter        =DAVE_COUNTER_START;
    chadCounter        =CHAD_COUNTER_START;
  }

  public void update()
  {
    checkBossRotation();
    spawnWave(checkWave());
  }

  //activates the spawn functions.
  private void spawnWave(boolean spawnWave)
  {
    if (spawnWave && !stateBossLester && !stateBossPing)
    {
      waveCounter+=1;
      if (waveCounter > 1) {
        score = score + 500;
      }

      if (waveCounter==3)
      {
        spawnWave3();
        return;
      }
      if (spawnPing)
      {
        activatePing();
        updateWaves();
        return;
      }
      if (spawnLester)
      {
        activateLester();
        updateWaves();
        return;
      }
      for ( int i=0; i<daveCounter; i++)
      {
        spawnDaves(i);
      }
      for ( int i=0; i<chadCounter; i++)
      {
        spawnChads(i);
      }
      updateWaves();
    }
  }

  //spawns daves
  private void spawnDaves(int yModifier)
  {
    for (Enemy enemy : enemies)
    {
      if (enemy instanceof EnemyDave)
      {
        if (!enemy.active)
        {
          enemy.activate(ENEMY_START_X, ENEMY_START_Y*(yModifier+1));
          break;
        }
      }
    }
  }

  //spawns chads
  private void spawnChads(int yModifier)
  {
    for (Enemy enemy : enemies)
    {
      if (enemy instanceof EnemyChad)
      {
        if (!enemy.active)
        {
          float xTemp=ENEMY_START_X;
          if (random(0, 1)>0.5)
          {
            xTemp=ENEMY_START_X_ALT;
          }
          enemy.activate(xTemp, ENEMY_START_Y*(yModifier+1));
          break;
        }
      }
    }
  }


  //checks if all enemies are dead
  private boolean checkWave()
  {
    return checkDave()&&checkChad();
  }

  //checks if all daves are dead
  private boolean checkDave()
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

  //checks if all chads are dead
  private boolean checkChad()
  {
    for (Enemy enemy : enemies)
    {
      if (enemy instanceof EnemyChad)
      {
        if (enemy.active)
        {
          return false;
        }
      }
    }
    return true;
  }


  //a special wave that only spawns 2 chads
  private void spawnWave3()
  {
    for (int i =0; i<WAVE3_CHADS; i++) {
      spawnChads(i);
    }
  }

  //modifies the makeup of waves.
  private void updateWaves()
  {
    if ( daveCounter < DAVE_MAX )
    {
      if ( waveCounter % WAVES_UNTILL_DAVE == 0)
        daveCounter+=1;
    }
    if ( chadCounter < CHAD_MAX )
    {
      if ( waveCounter % WAVES_UNTILL_CHAD == 0 )
      {
        chadCounter+=1;
      }
    }
    if ( waveCounter % WAVES_UNTILL_BOSS == 0 )
    {
      if (waveCounter==5) //forces PING as first boss
      {
        spawnPing=true;
      } else
        chooseBoss();
    }
  }

  //selects a random boss
  private void chooseBoss()
  {
    switch ((int)random(0, AMOUNT_OF_BOSSES))
    {
    case BossID.PING:
      if (pingActivated)
      {
        chooseBoss();
      } else
      {
        spawnPing=true;
      }
      break;
    case BossID.LESTER:
      if (lesterActivated)
      {
        chooseBoss();
      } else
      {
        spawnLester=true;
      }
      break;
    default:
      chooseBoss();
    }
  }

  //starts the ping boss fight
  private void activatePing()
  {
    ping             = new BossPing();
    pingActivated    = true;
    stateBossPing    = true;
    spawnPing        = false;
  }

  //starts the lester boss fight
  private void activateLester()
  {
    lester           = new BossLester(width / 2, 100);
    lesterActivated  = true;
    stateBossLester  = true;
    spawnLester      = false;
  }

  //checks if all bosses have been activated
  private void checkBossRotation()
  {
    if ( pingActivated && lesterActivated )
    {
      pingActivated=false;
      lesterActivated=false;
    }
  }

  public int getWaveCounter() {
    return waveCounter;
  }
}
