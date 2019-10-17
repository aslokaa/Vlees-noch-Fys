class Test
{
  void test()
  {
    if (keysPressed['j']) 
    {
      println("j deal damage");
      player.dealDamage(10, true);
    }
    if (keysPressed['k'])
    {
      println("k restore health" );
      player.restoreHealth(10, true);
    }
    if (keysPressed['l'])
    {
      println("l inverted");
      player.modifyPower(PowerUpTypes.INVERTED);
    }
    if (keysPressed['o'])
    {
      println("o gain 1 bullet");
      player.gainAmmo(1);
    }
    if (keysPressed['i'])
    {
      println("i slow");
      player.modifyPower(PowerUpTypes.SLOW);
    }
    if (keysPressed['u'])
    {
      println("u invisible");
      player.modifyPower(PowerUpTypes.INVISIBLE);
    }
    if (keysPressed['y'])
    {
      println("y split");
      player.modifyPower(PowerUpTypes.SPLIT);
    }
    //println(frameRate);
    if (keysPressed['e'])
    {
    }
  }
}
