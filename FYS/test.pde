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
      player.modifyPower(PowerUps.INVERTED);
    }
    if (keysPressed['o'])
    {
      println("o gain 1 bullet");
      player.gainAmmo(1);
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
    //println(frameRate);
    if (keysPressed['e'])
    {
     Rectangles hitboxes = player.getHitboxes();
     println(hitboxes.rectangle0.x,hitboxes.rectangle0.y,hitboxes.rectangle0.rectangleWidth,hitboxes.rectangle0.rectangleHeight,hitboxes.rectangle1.exists);
     println(hitboxes.rectangle1.x,hitboxes.rectangle1.y,hitboxes.rectangle1.rectangleWidth,hitboxes.rectangle1.rectangleHeight,hitboxes.rectangle1.exists);
    }
  }
}
