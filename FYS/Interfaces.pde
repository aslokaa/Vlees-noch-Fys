//Niklas Leeuwin
//500784205
//

//Adding readability to the powerUps.
interface PowerUps 
{ 
  final int
    INVERTED     = 0, 
    INVISIBLE    = 1, 
    SLOW         = 2, 
    SPLIT        = 3;
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
    BLACK      = #FFFFFF;
}

//stores array amounts.
interface Arrays
{
  final int
    STAR_COUNT  = 300;
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
    INVISIBLE         = 1000;
}
