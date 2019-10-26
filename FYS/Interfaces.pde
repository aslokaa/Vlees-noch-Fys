//Niklas Leeuwin
//500784205
//

//Adding readability to the powerUps.
interface PowerUpTypes 
{ 
  final int
    INVERTED     = 0, 
    IMMUNE    = 1, 
    SLOW         = 2, 
    SPLIT        = 3;
}  

//finals for all enemies.
interface EnemyFinals
{
  final float DAVE_GRID_HEIGHT = 100;
  final float DAVE_HITBOX_RADIUS = 40;
  final color DAVE_COLOR = #ff0000;
  final float CHAD_HITBOX_RADIUS = 40;
  final color CHAD_COLOR = #ff0000;
}
//finals for powerups
interface PowerFinals
{
  final float HITBOX_DIAMETER = 20;
  final float VELOCITY_Y = 5;
}
//adding readability to the colors
interface Colors
{
  final color
    PINK       = #FF00FF, 
    GREEN      = #00FF00, 
    WHITE      = #FFFFFF, 
    BLUE       = #0000FF, 
    YELLOW     = #FFFF00, 
    RED        = #FF0000, 
    BLACK      = #000000,
    DARK_GREEN = #008F11;
}

//stores array amounts.
interface Arrays
{
  final int
    STAR_COUNT    = 1, //changed from 300 to optimize.
    BULLET_COUNT  = 30, 
    OPTION_COUNT  = 3;
}

//adding readability
interface Sounds
{
  final int
    RECIEVE_DAMAGE    = 0, 
    RESTORE_HEALTH    = 1, 
    SHOOT             = 2, 
    SPLIT             = 3, 
    SLOW              = 4, 
    INVERTED          = 5, 
    START_GAME        = 7, 
    GAME_MUSIC0       = 8, 
    GAME_MUSIC1       = 9, 
    GAME_MUSIC2       = 10, 
    END_MUSIC         = 11, 
    PAUSE             = 12, 
    UNPAUSE           = 13, 
    PING_SHOOT        = 14,
    NO_AMMO           = 15,
    IMMUNE            = 1000;
}
