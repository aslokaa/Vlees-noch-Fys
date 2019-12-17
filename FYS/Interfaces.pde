//Niklas Leeuwin
//500784205
//

//Adding readability to the powerUps.
interface PowerUpTypes 
{ 
  public final int
    INVERTED     = 0, 
    IMMUNE       = 1, 
    SLOW         = 2,
    HP_UP        = 3,
    AMMO_UP      = 4,
    BOOM_BALL    = 5,
    EXTRA_BALL   = 8,
    SPLIT        = 6;
}  

//public finals for all enemies.
interface EnemyFinals
{

  public final float DAVE_GRID_HEIGHT       = 100;
  public final float DAVE_HITBOX_RADIUS     = 40;
  public final color DAVE_COLOR             = #ff0000;
  public final float CHAD_HITBOX_RADIUS     = 40;
  public final color CHAD_COLOR             = #ff0000;
  public final float ENEMY_GRAVEYARD_X      = -500;
  public final float ENEMY_GRAVEYARD_Y      = -500;
}
//public finals for powerups
interface PowerFinals
{
  public final float HITBOX_DIAMETER = 50;
  public final float VELOCITY_Y = 5;
}
//adding readability to the colors
interface Colors
{
  public final color
    PINK       = #FF69B4, 
    GREEN      = #00FF00, 
    WHITE      = #FFFFFF, 
    BLUE       = #0000FF, 
    YELLOW     = #FFFF00, 
    RED        = #FF0000,
    BLOOD_RED  = #8A0707,
    BLACK      = #000000,
    MAGENTA    = #FF00FF,
    DARK_GREEN = #008F11;
}

//stores array amounts.
interface Arrays
{
  public final int
    STAR_COUNT    = 300, 
    BULLET_COUNT  = 150, 
    OPTION_COUNT  = 3, 
    DAVE_COUNT    = 10,
    POWER_COUNT   = 5,
    PARTICLE_COUNT = 2000,
    ANIMATION_COUNT = 2500,
    DAVE_MAX = 50,
    CHAD_MAX = 10,
    WAVE_FORMATS = 10;
    
}

//adding readability
interface Sounds
{
  public final int
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

//adding readability
interface BossID
{
  public final int
    PING                =0, 
    LESTER              =1;
}
