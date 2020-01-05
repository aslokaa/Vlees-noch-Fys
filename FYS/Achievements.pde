//Niklas Leeuwin
//500784205
//

//handles the achievements. the non capital ints indicate it is acquired progress and the capitalized indicate it is required.
class Achievements
{

  private final float
    TEXT_X    =gamefield.GAMEFIELD_WIDTH*0.9, 
    TEXT_Y    =height*0.9, 
    TEXTSIZE  =width * 0.04;

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
  private boolean databaseReady;

  Achievements() {
    lastGottenAchievement="404";
  }

  //gets called on by another class to increase the progress an achievemnt has.


  public void update() {
    countDown();
    if (!databaseReady) {
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
    String t0 = "SELECT achievement.name as AName, player.name as PName,achievement.requiredProgress  FROM player_has_achievement INNER JOIN player ON player_has_achievement. player_idplayer = player.idplayer INNER JOIN achievement ON player_has_achievement.achievement_idachievement = achievement.idachievement Where player_has_achievement.progress = achievement.requiredProgress AND player.idplayer ="+idPlayer;
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

  public void clean() {
    String t = "DELETE FROM `player_has_achievement` WHERE `progress`=0";
    sql.query(t);
  }
  public void givePlayerEmptyAchievements() {
    for (int i=0; i< AchievementID.THE_COLLECTOR; i++) {
      String t="INSERT INTO `player_has_achievement` (`player_idplayer`, `achievement_idachievement`, `progress`) VALUES ('"+idPlayer+"', '"+i+"', '0')";
      sql.query(t);
    }
    achievement.databaseReady=true;
  }
  public void increaseProgress(int id) {
    switch (id) {
    case AchievementID.A_LITTLE_BIT :
      increaseProgress(AchievementID.SOME_OF_THE);
      break;
    case AchievementID.SOME_OF_THE :
      increaseProgress(AchievementID.ALL_THE_MURDER);
      break;
    }
    if (!isComplete(id)) {
      String t0="UPDATE `player_has_achievement` SET `progress`= progress+1 WHERE player_idplayer = "+idPlayer+" AND achievement_idachievement="+id;
      sql.query(t0);
      if (isComplete(id)) {
        String t1 = "SELECT name FROM `achievement` WHERE idAchievement="+id ;
        sql.query(t1);
        while (sql.next())
        {
          achievement.setLastGottenAchievement(sql.getString("name"));
          achievement.increaseProgress(AchievementID.THE_COLLECTOR);
        }
      }
    }
  }
   public int getProgress(int id) {
      String t="SELECT progress FROM `player_has_achievement` WHERE achievement_idAchievement="+id+" AND player_idplayer="+idPlayer;
      sql.query(t);
      while (sql.next())
      {
        return sql.getInt("progress");
      }
      return 0;
    }
    public int getCompletion(int id) {
      String t="SELECT requiredprogress FROM `achievement` WHERE idAchievement="+id;
      sql.query(t);
      while (sql.next())
      {
        return sql.getInt("requiredprogress");
      }
      return 0;
    }

    public boolean isComplete(int id) {
      return getProgress(id)>=getCompletion(id);
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
