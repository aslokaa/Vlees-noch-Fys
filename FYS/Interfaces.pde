//Niklas Leeuwin
//500784205
//

//Adding readability to the powerUps.
interface PowerUpTypes 
{ 
  public final int
    INVERTED     = 0, 
    IMMUNE       = 2, 
    SLOW         = 1, 
    HP_UP        = 3, 
    AMMO_UP      = 4, 
    BOOM_BALL    = 5, 
    EXTRA_BALL   = 6, 
    SPLIT        = 7, 
    SPIKE_BALL   = 9;
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
    BALL_COUNT    = 4,
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

interface BallHit
{
  public final int
    GROW      =0, 
    SHRINK    =1, 
    REGROW    =2, 
    NOTHING   =3;
}

interface AchievementID
{
  public final int 
    AMERICAN        =0, //achieve the maximum player size.
    PING_PONG       =1, //defeat Ping
    LIT             =2, //achieve a score of 420420.
    I_CONCEDE       =3, //give up.
    ONE_PERCENT     =4, //get over a 100 bullets
    HAMMER_TIME     =5, //pause the game.
    UNALIVED        =6, //Die.
    PEW_PEW_PEW     =7, //Shoot a bullet
    A_LITTLE_BIT    =8, //Kill 100 enemies.
    SOME_OF_THE     =9, //Kill 500 enemies.
    ALL_THE_MURDER  =10, //kill 1000 enemies.
    THE_COLLECTOR   =11; //get all achievements.
}
