class Test
{
  void damage()
  {
    if (keysPressed['j']) 
    {
      player.dealDamage(10);
    }
    if (keysPressed['k'])
    {
     player.restoreHealth(10);
    }
  }
}
