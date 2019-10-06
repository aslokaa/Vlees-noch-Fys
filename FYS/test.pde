class Test
{
  void test()
  {
    if (keysPressed['j']) 
    {
      println("j deal damge");
      player.dealDamage(10);
    }
    if (keysPressed['k'])
    {
      println("k restore health" );
      player.restoreHealth(10);
    }
    if (keysPressed['l'])
    {
      println("l inverted");
      player.modifyPower(PowerUps.INVERTED);
    }
    if (keysPressed['o'])
    {
      println("o gain 1 bullet");
      player.gainBullets(1);
    }
     if (keysPressed['i'])
    {
      println("i slow");
      player.modifyPower(PowerUps.SLOW);
    }
    if (keysPressed['u'])
    {
      println("u invisible");
      player.modifyPower(PowerUps.INVISIBLE);
    }
    if (keysPressed['y'])
    {
      println("y split");
      player.modifyPower(PowerUps.SPLIT);
    }
  }
}
