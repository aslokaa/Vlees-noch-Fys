/* //waves hardcoden, randomisen met parameters, of nieuwe format maken voor waves? //<>// //<>// //<>// //<>//
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

/*
 we hebben max ongeveer 20 waves, daarom kunnen we iedere wave formateren, we kunnen 
 de methods checkBoss en spawnwave herschrijven in 1 method die een lange string/INTarray
 neemt om te kijken wat er gespawned moet worden, dit zorgt voor veel hardcoden maar waves maken
 en balancen word makkelijker. we kunnen ook iets van een switch statement maken die de rondes checkt
 en de goede acties uitvoert zoals nu wordt gedaan maar met de tutorial waves erbij.
 */
class Gamefield
{
  public final float 
    GAMEFIELD_WIDTH                 = width, 
    GAMEFIELD_HEIGHT                = height * 0.90, 
    PLAYER_MIN_Y                    = height / 2, 
    ENEMY_MAX_Y                     = height, 
    ENEMY_START_Y                   = height * -0.13, 
    ENEMY_START_X                   = GAMEFIELD_WIDTH * 0.06, 
    ENEMY_START_X_ALT               = GAMEFIELD_WIDTH * 0.94;

  private final int 
    CHAD_COUNTER_START              = 0, 
    DAVE_COUNTER_START              = 10, 
    CHAD_MAX                        = 10, 
    AMOUNT_OF_BOSSES                = 2, 
    WAVES_UNTILL_DAVE               = 1, 
    WAVE3_CHADS                     = 1, 
    WAVES_UNTILL_CHAD               = 3, 
    WAVES_UNTILL_BOSS               = 5, 
    DAVE_COUNTER_WAVE9              = 30, 
    DAVE_MAX                        = 50; 

  private int  

    chadSpawnDelay = 180, 
    dullChadCounter = 0, 
    roundStartCounter = 0, 
    roundLengthCounter, 
    scorePlus, 
    scoreDamage, 
    powerUpSize, 
    colorTimer, 
    textPowerUp, 
    comboScore, 
    daveCounter, 
    chadCounter, 
    davesKilled, 
    waveBumpDelay;

  public int //Used for database
    waveCounter, 
    scoreCounter;
  private final float
    DAVE_SPEED_MAX                  = 7.5, 
    DAVE_SPEED_START                = 2.5, 
    DAVE_SPEED_INCREASE             = 0.4;


  public float 

    powerTimer, 
    damageTime, 
    daveSpeed;

  private boolean
    pingActivated, 
    lesterActivated, 
    spawnPing, 
    spawnLester, 
    ballActive, 
    safetyFloorActive, 
    roundSkippable;

  private WaveFormat currentWave = new WaveFormat(0, 0, 0, 60, 0, false, false, false, false, false);


  public Gamefield()
  {
    waveBumpDelay = 60;
    daveSpeed = DAVE_SPEED_START;
  }

  public void update()
  {
    if (waveCounter<8) {
      bumpWave();
      handleWave();
    } else {
      spawnWave(checkEnemies());
    }
  }

  private void bumpWave()
  {
    if ( currentWave.roundLengthCounter > 0 )
    {
      currentWave.roundLengthCounter--;
    } else 
    {
      if ( checkWaveBumpDelay() )
      {
        nextWave();
      }
    }
    if (checkWaveCleared())
    {
      if ( checkWaveBumpDelay() )
      {
        nextWave();
      }
    }
    if ( waveCounter == 1 && player.hasMoved())
    {
      nextWave();
    }
  }

  private void nextWave()
  {
    currentWave = waveFormats[waveCounter];
    waveBumpDelay = int(currentWave.minRoundLength);
    daveCounter=currentWave.daveCounter;
    waveCounter++;
    increaseDaveSpeed();
    davesKilled=0;
    setConditions();
  }

  private boolean checkWaveBumpDelay()
  {
    if ( waveBumpDelay <= 0 )
    {
      return true;
    }
    waveBumpDelay--;
    return false;
  }

  private void setConditions()
  {
    if ( waveCounter - 1 == 3 )
    {
      player.setPosition( gamefield.GAMEFIELD_WIDTH / 2 - player.playerWidth / 2, height -300);
      spawnDullChad();
      chadCounter = -1;
      for ( Power power : powers )
      {
        if ( !power.powerActive )
        {
          power.drop(GAMEFIELD_WIDTH / 2, -50, 4);
          //restrict player movement
          break;
        }
      }
    }
    if ( currentWave.ballActive )
    {
      //activate ball 
      if ( !areBallsActive() )
      {
        for (Ball ball : balls) {
          ball.activate(GAMEFIELD_WIDTH / 2, height / 2);
          break;
        }
      }
    } else
    {
      //deactivate ball
      for (Ball ball : balls) {
        ball.active = false;
        println("oi");
      }
    }

    if ( currentWave.safetyFloorActive )
    {
      //activate safetyfloor 
      for (Ball ball : balls) {
        ball.safetyWallActive = true;
      }
    } else
    {
      //deactivate safetyfloor
      for (Ball ball : balls) {
        ball.safetyWallActive = false;
      }
    }
  }

  public boolean areBallsActive() {
    for (Ball ball : balls) {
      if (ball.active==true) {
        return true;
      }
    }
    return false;
  }

  private void handleWave()
  {
    if ( currentWave.roundStartCounter > 0 )
    {
      currentWave.roundStartCounter--;
    } else
    { 
      if ( currentWave.daveCounter > 0 && checkDaveSpawnCollision() )
      {
        spawnDaves();
        currentWave.daveCounter--;
      }
      if ( currentWave.chadCounter > 0 && frameCount % chadSpawnDelay == 0 )
      {
        spawnChads();
        currentWave.chadCounter--;
        gamefield.chadCounter++;
      }
      if ( currentWave.spawnLester  && !lester.active)
      {
        activateLester();
        currentWave.spawnLester = false;
      }
      if ( currentWave.spawnPing && !pingActivated )
      {
        activatePing();
        currentWave.spawnPing = false;
      }
    }
  }

  private boolean checkDaveSpawnCollision()
  {
    for (Enemy enemy : enemies)
    {
      if (enemy instanceof EnemyDave)
      {
        if (enemy.active && enemy.y - enemy.hitboxRadius * 2.2 < ENEMY_START_Y )
        {
          return false;
        }
      }
    }
    return true;
  }

  public void setDaveMoveSpeed()
  {
    //daveSpeed=abs((DAVE_SPEED_MAX - daveSpeed) / davesKilled+1);
    for ( Enemy enemy : enemies )
    {
      if ( enemy.active && enemy instanceof EnemyDave )
      {
        enemy.setMoveSpeed(map(davesKilled, 0, daveCounter, daveSpeed, DAVE_SPEED_MAX));
      }
    }
  }

  private void increaseDaveSpeed() {
    if (daveSpeed< DAVE_SPEED_MAX) {
      daveSpeed +=DAVE_SPEED_INCREASE;
    } else {
      daveSpeed=DAVE_SPEED_MAX;
    }
  }

  //activates the spawn functions.
  private void spawnWave(boolean spawnWave)
  {
    if (waveCounter==9) {
      daveCounter=DAVE_COUNTER_WAVE9;
      chadCounter=5;
    }
    if (spawnWave && !stateBossLester && !stateBossPing)
    {
      waveCounter++;
      davesKilled=0;
      increaseDaveSpeed();
      // davesAlive = gamefield.currentWave.daveCounter;
      //chadsAlive = gamefield.currentWave.chadCounter;
      if (waveCounter > 1) {
        scorePlus = 300;
        scoreCounter = scoreCounter + scorePlus;
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
        spawnChads();
      }
      updateWaves();
    }
  }

  private void spawnDullChad()
  {
    for (Enemy enemy : enemies)
    {
      if (enemy instanceof EnemyDullChad)
      {
        if (!enemy.active)
        {
          enemy.activate(GAMEFIELD_WIDTH / 2, - 100);
          return;
        }
      }
    }
  }

  //spawns daves
  private void spawnDaves()
  {
    for (Enemy enemy : enemies)
    {
      if (enemy instanceof EnemyDave)
      {
        if (!enemy.active)
        {
          enemy.activate(ENEMY_START_X, ENEMY_START_Y);
          break;
        }
      }
    }
  }

  //spawns daves
  private void spawnDaves(int index)
  {
    for (Enemy enemy : enemies)
    {
      if (enemy instanceof EnemyDave)
      {
        if (!enemy.active)
        {
          enemy.activate(ENEMY_START_X, ENEMY_START_Y-((EnemyFinals.DAVE_HITBOX_RADIUS*2.5)*index));
          break;
        }
      }
    }
  }

  //spawns chads
  private void spawnChads()
  {
    for (Enemy enemy : enemies)
    {
      if (enemy instanceof EnemyChad)
      {
        if (!enemy.active)
        {
          enemy.activate(random( 0, 600), random(-500, -100));
          return;
        }
      }
    }
  }


  //checks if all enemies are dead
  private boolean checkWaveCleared()
  {
    return checkEnemies()&&checkBosses();
  }

  //checks if all daves are dead
  private boolean checkEnemies()
  {

    for (Enemy enemy : enemies)
    {
      if (enemy instanceof EnemyDullChad)
      {
        if (enemy.active)
        {
          return false;
        }
      }
    }
    for (Enemy enemy : enemies)
    {
      if (enemy instanceof EnemyDave)
      {
        if (enemy.active)
        {
          return false;
        }
      }
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

  private boolean checkBosses()
  {
    if ( !lester.active && !pingActivated )
    {
      return true;
    }
    return false;
  }


  //modifies the makeup of waves.
  private void updateWaves()
  {
    if ( daveCounter < DAVE_MAX )
    {
      if ( waveCounter % WAVES_UNTILL_DAVE == 0) {
        daveCounter+=1;
      }
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
      //chooseBoss();
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
    println("yet");
    lester.activate();
    lesterActivated  = true;
    stateBossLester  = true;
    spawnLester      = false;
  }


  public int getWaveCounter() {
    return waveCounter;
  }

  private void displayWallFX()
  {
    //ball near wall effect.
    //safetyWall bottom.
    if ( currentWave.safetyFloorActive )
    {
      fill( 255 );
      rect(0, GAMEFIELD_HEIGHT-5, GAMEFIELD_WIDTH, 10);
    }
    //tweening easing/ squishy walls ofzo.
  }

  public void checkRoundSkip()
  {
    if ( keysPressed['s'] )
    {
      if ( currentWave.roundSkippable )
      { 
        nextWave();
      }
    }
  }
}
