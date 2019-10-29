/*
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
 */
class Gamefield
{
  final float 
    PLAYER_MIN_Y                    = height / 2,
    ENEMY_MAX_Y                     = height,
    GAMEFIELD_WIDTH                 = width * 0.87;  


  //finals listed above
  //nieuwe class area aanmaken of rectangle gebruiken als area?
  //waves hardcoden, randomisen met parameters, of nieuwe format maken voor waves?
  //afstanden baseren op pixels of relatieve afstanden?
  Gamefield()
  {
  }

  void setupField()
  {
    //sets enemies to not active, sets player position to start position, sets up/resets space and score.
  }

  void spawnWave()
  {
    //checks what wave is active and spawns in enemies accordingly.
  }
}
