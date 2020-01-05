//Niklas Leeuwin
//500784205
//

//handles the achievements. the non capital ints indicate it is acquired progress and the capitalized indicate it is required.
class Achievements
{
  public int tempPlayerID;
  public boolean tempB=false;
  String TempString="a";
  private final float
    TEXT_X    =gamefield.GAMEFIELD_WIDTH*0.9, 
    TEXT_Y    =height*0.9, 
    TEXTSIZE  =width * 0.04;
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
    ACHIEVEMENT_TIMER_START    = 4*(int)player.SECOND, 
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

  private String lastGottenAchievement;
  private int achievementTimer;

  Achievements() {
    tempPlayerID=420;
    american    = new Achievement(AchievementID.AMERICAN, AMERICAN );
    pingPong    = new Achievement(AchievementID.PING_PONG, PING_PONG ); 
    lit         =new Achievement(AchievementID.LIT, LIT );
    iConcede    = new Achievement(AchievementID.I_CONCEDE, I_CONCEDE ); 
    onePercent  = new Achievement(AchievementID.ONE_PERCENT, ONE_PERCENT ); 
    hammerTime  = new Achievement(AchievementID.HAMMER_TIMER, HAMMER_TIMER );
    unalived    = new Achievement(AchievementID.UNALIVED, UNALIVED);  
    pewPewPew   = new Achievement(AchievementID.PEW_PEW_PEW, PEW_PEW_PEW ); 
    aLittleBit  = new Achievement(AchievementID.A_LITTLE_BIT, A_LITTLE_BIT ); 
    someOfThe   = new Achievement(AchievementID.SOME_OF_THE, SOME_OF_THE); 
    allTheMurder= new Achievement(AchievementID.ALL_THE_MURDER, ALL_THE_MURDER ); 
    theCollector= new Achievement(AchievementID.THE_COLLECTOR, THE_COLLECTOR);
    lastGottenAchievement="404";
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
    if (!tempB) {
      givePlayerEmptyAchievements();
    }
  }

  public void display() {
    if (achievementTimer>0) {
      fill(Colors.WHITE);
      textSize(TEXTSIZE);
      textMode(CENTER);
      text(lastGottenAchievement, TEXT_X, TEXT_Y);
    }
  }

  public void displayMenu() {
    String t0 = "SELECT achievement.name as AName, player.name as PName FROM player_has_achievement INNER JOIN player ON player_has_achievement. player_idplayer = player.idplayer INNER JOIN achievement ON player_has_achievement.achievement_idachievement = achievement.idachievement Where player_has_achievement.progress = achievement.requiredProgress AND player.idplayer ="+tempPlayerID;
    sql.query(t0);
    while (sql.next())
    {
      println(sql.getString("Aname"));
      println(sql.getString("Pname"));
    }
    String t1 = "";
  }

  private void countDown() {
    if (achievementTimer>0) {
      achievementTimer--;
    }
  }

  public void setLastGottenAchievement(String lastGottenAchievement) {
    this.lastGottenAchievement=lastGottenAchievement;
    achievementTimer=ACHIEVEMENT_TIMER_START;
  }
  
  public void clean(){
    String t = "DELETE FROM `player_has_achievement` WHERE `progress`=0";
    sql.query(t);
  }
}

class Achievement
{
  private int 
    id, 
    completion; 



  Achievement(int id, int completion ) {
    this.id=id; 
    this.completion=completion;
  }

  public void increaseProgress() {
    if (!isComplete()) {
      String t0="UPDATE `player_has_achievement` SET `progress`="+ (getProgress()+1)+" WHERE player_idplayer = "+achievement.tempPlayerID+" AND achievement_idachievement="+id;
      sql.query(t0);
      if (isComplete()) {
        String t1 = "SELECT name FROM `achievement` WHERE idAchievement="+id ;
        sql.query(t1);
        while (sql.next())
        {
          println(sql.getString("name"));
        }
      }
    }
  }
  public int getId() {
    return id;
  }

  public int getProgress() {
     String t="SELECT progress progress FROM `player_has_achievement` WHERE achievement_idAchievement="+id+"AND player_idplayer="+achievement.tempPlayerID;
    sql.query(t);
        while (sql.next())
        {
          return sql.getInt("progress");
        }
        return 0;
  }

  public int getCompletion() {
    return completion;
  }

  public boolean isComplete() {
    return getProgress()>=completion;
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
 */

public void givePlayerEmptyAchievements() {
  for (int i=0; i>= AchievementID.THE_COLLECTOR; i++) {
    String t="INSERT INTO `player_has_achievement` (`player_idplayer`, `achievement_idachievement`, `progress`) VALUES ('"+achievement.tempPlayerID+"', '"+i+"', '0')";
    sql.query(t);
    println(i);
  }
  achievement.tempB=true;
}
