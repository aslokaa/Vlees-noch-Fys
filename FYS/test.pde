class Test
{
  void test()
  {
    if (keysPressed['j']) 
    {
      println("j deal damage");
      player.dealDamage(60, true);
    }
    if (keysPressed['k'])
    {
      println("k restore health" );
      player.restoreHealth(10);
    }
    if (keysPressed['l'])
    {
      println("l inverted");
      //powers[1].drop(width/2,0,PowerUpTypes.SPIKE_BALL);
    }
    if (keysPressed['o'])
    {
      println("o gain 100 bullet");
      player.gainAmmo(100);
      keysPressed['o']=false;
    }
    if (keysPressed['i'])
    {
      println("i slow");
      player.modifyPower(PowerUpTypes.SLOW);
    }
    if (keysPressed['u'])
    {
      println("u immune");
      player.modifyPower(PowerUpTypes.IMMUNE);
    }
    if (keysPressed['y'])
    {
      println("y split");
      player.modifyPower(PowerUpTypes.SPLIT);
    }
    if (keysPressed['e'])
    {
      println("e frameRate", frameRate);
      fill(Colors.WHITE);
      textSize(height*0.1);
      text(frameRate, width*0.95, height*0.1);
    }
    if (keysPressed['m'])
    {
      if (stateBossPing)
      {
        println("m Boss Ping leaving the game");
        ping.killPing();
      } else
      {
        println("m Boss Ping Entering the game");
        ping= new BossPing();
        stateBossPing=true;
      }
      keysPressed['m']=false;
    }
    if (keysPressed['n'])
    {
      if (stateBossLester)
      {
        println("n Boss Lester leaving the game");
        stateBossLester=false;
      } else
      {
        println("n Boss Lester Entering the game");
        lester           = new BossLester(width / 2, 100);
        stateBossLester=true;
      }
      keysPressed['n']=false;
    }
  }
}
