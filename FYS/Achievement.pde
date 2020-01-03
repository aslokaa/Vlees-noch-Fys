//Niklas Leeuwin
//500784205
//

//handles the achievements. the non capital ints indicate it is acquired progress and the capitalized indicate it is required.
class Achievement
{
  private int //keeps track of progress.
    american, 
    pingPong, 
    iConcede, 
    onePercent, 
    hammerTime, 
    unalived, 
    pewPewPew, 
    aLittleBit, 
    someOfThe, 
    allTheMurder, 
    theCollector;

  private final int //required progress to get the achievment
    AMERICAN       =1, 
    PING_PONG      =1, 
    LIT            =1, 
    I_CONCEDE      =1, 
    ONE_PERCENT    =101, 
    HAMMER_TIMER   =1, 
    UNALIVED       =1, 
    PEW_PEW_PEW    =1, 
    A_LITTLE_BIT   =100, 
    SOME_OF_THE    =500, 
    ALL_THE_MURDER =1000, 
    THE_COLLECTOR  =11;

  public void retrieveSQL() {
  }

  public void updateSQL() {
  }

  //gets called on by another class to increase the progress an achievemnt has.
  public void increaseProgress(int achievementID) {
    switch (achievementID) {
    case AchievementID.AMERICAN:
      if (checkComplete(american, AMERICAN)) {
        american++;
        if (checkComplete(american, AMERICAN)) {
          //insert sql
        }
      }
      break;
    }
  }

  private boolean checkComplete(int achievementProgress, int achievementRequired) {
    return achievementProgress<achievementRequired;
  }


  public void update() {
  }

  public void display() {
  }

  public void displayPaused() {
  }

  private void completeAchievements() {
  }
}

/*
 AMERICAN        =0, //achieve the maximum player size.
 PING_PONG       =1, //defeat Ping
 LIT             =2, //achieve a score of 420420.
 I_CONCEDE       =3, //give up.
 ONE_PERCENT     =4, //get over a 100 bullets
 HAMMER_TIMER    =5, //pause the game.
 UNALIVED        =6, //Die.
 PEW_PEW_PEW     =7, //Shoot a bullet
 A_LITTLE_BIT    =8, //Kill 100 enemies.
 SOME_OF_THE     =9, //Kill 500 enemies.
 ALL_THE_MURDER  =10, //kill 1000 enemies.
 THE_COLLECTOR   =99; //get all achievements.
