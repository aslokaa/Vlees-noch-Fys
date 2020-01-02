//Niklas Leeuwin
//500784205
//

//handles the achievements. the non capital ints indicate it is acquired progress and the capitalized indicate it is required.
class Achievements
{
  private Achievement
    american, 
    pingPong, 
    lit, 
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

  private final String //the displayed name of achievements
    AMERICAN_NAME       ="The American", 
    PING_PONG_NAME      ="Pong", 
    LIT_NAME            ="Lit!", 
    I_CONCEDE_NAME      ="Intresting moves, You concede", 
    ONE_PERCENT_NAME    ="You are the 1%", 
    HAMMER_TIMER_NAME   ="STOP. It's Hammer Time", 
    UNALIVED_NAME       ="They unalived you.", 
    PEW_PEW_PEW_NAME    ="PEW!PEW!PEW!", 
    A_LITTLE_BIT_NAME   ="A little bit of murder?", 
    SOME_OF_THE_NAME    ="Some of the murder.", 
    ALL_THE_MURDER_NAME ="ALL OF THE MURDER!", 
    THE_COLLECTOR_NAME  ="The collecter";

  Achievements() {
    american    = new Achievement(AchievementID.AMERICAN, AMERICAN, AMERICAN_NAME);
    pingPong    = new Achievement(AchievementID.PING_PONG, PING_PONG, PING_PONG_NAME); 
    lit         =new Achievement(AchievementID.LIT, LIT, LIT_NAME);
    iConcede    = new Achievement(AchievementID.I_CONCEDE, I_CONCEDE, I_CONCEDE_NAME); 
    onePercent  = new Achievement(AchievementID.ONE_PERCENT, ONE_PERCENT, ONE_PERCENT_NAME); 
    hammerTime  = new Achievement(AchievementID.HAMMER_TIMER, HAMMER_TIMER, HAMMER_TIMER_NAME);
    unalived    = new Achievement(AchievementID.UNALIVED, UNALIVED, UNALIVED_NAME);  
    pewPewPew   = new Achievement(AchievementID.PEW_PEW_PEW, PEW_PEW_PEW, PEW_PEW_PEW_NAME); 
    aLittleBit  = new Achievement(AchievementID.A_LITTLE_BIT, A_LITTLE_BIT, A_LITTLE_BIT_NAME); 
    someOfThe   = new Achievement(AchievementID.SOME_OF_THE, SOME_OF_THE, SOME_OF_THE_NAME); 
    allTheMurder= new Achievement(AchievementID.ALL_THE_MURDER, ALL_THE_MURDER, ALL_THE_MURDER_NAME); 
    theCollector= new Achievement(AchievementID.THE_COLLECTOR, THE_COLLECTOR, THE_COLLECTOR_NAME);
  }
  public void retrieveSQL() {
  }

  public void updateSQL() {
  }

  //gets called on by another class to increase the progress an achievemnt has.
  public void increaseProgress(int achievementID) {
    switch (achievementID) {
    case AchievementID.AMERICAN : 
      american.increaseProgress();
      break;
    case AchievementID.PING_PONG :
      pingPong.increaseProgress();
      break;
    case AchievementID.LIT :
      lit.increaseProgress();
      break;
    case AchievementID.I_CONCEDE :
      iConcede.increaseProgress();
      break;
    case AchievementID.ONE_PERCENT :
      onePercent.increaseProgress();
      break;
    case AchievementID.HAMMER_TIMER :
      hammerTime.increaseProgress();
      break;
    case AchievementID.UNALIVED :
      unalived.increaseProgress();
      break;
    case AchievementID.PEW_PEW_PEW :
      pewPewPew.increaseProgress();
      break;
    case AchievementID.A_LITTLE_BIT :
      aLittleBit.increaseProgress();
      break;
    case AchievementID.SOME_OF_THE :
      someOfThe.increaseProgress();
      break;
    case AchievementID.ALL_THE_MURDER :
      allTheMurder.increaseProgress();
      break;
    case AchievementID.THE_COLLECTOR :
      theCollector.increaseProgress();
      break;
    }
  }


  public void update() {
    countDown();
  }

  public void display() {
  }

  public void displayPaused() {
  }

  private void countDown() {
  }
}

class Achievement
{
  private int 
    id, 
    progress, 
    completion; 
  private String name; 



  Achievement(int id, int completion, String name) {
    this.id=id; 
    this.completion=completion; 
    this.name=name;
  }
  Achievement(int id, int progress, int completion, String name) {
    this(id, completion, name);
    this.progress=progress;
  }

  public void increaseProgress() {
    if (!isComplete()) {
      progress++;
      if (isComplete()) {
      }
    }
  }

  public int getId() {
    return id;
  }

  public int getProgress() {
    return progress;
  }

  public int getCompletion() {
    return completion;
  }

  public String getName() {
    return name;
  }

  public boolean isComplete() {
    return progress>=completion;
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
 THE_COLLECTOR   =11; //get all achievements.
