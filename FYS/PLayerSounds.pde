//Niklas Leeuwin
//500784205
//

//this class handles the sounds the player makes
class PlayerSounds
{
  final String
    FOLDER_NAME       = "playerSounds";
  final SoundFile 
    RECIEVE_DAMAGE    = new SoundFile(FYS.this, FOLDER_NAME + '/' + "recieveDamage.wav"), 
    RESTORE_HEALTH    = new SoundFile(FYS.this, FOLDER_NAME + '/' + "restoreHealth.wav"), 
    SHOOT             = new SoundFile(FYS.this, FOLDER_NAME + '/' + "shoot.wav"), 
    SPLIT             = new SoundFile(FYS.this, FOLDER_NAME + '/' + "split.wav"), 
    SLOW              = new SoundFile(FYS.this, FOLDER_NAME + '/' + "slow.wav"), 
    INVERTED          = new SoundFile(FYS.this, FOLDER_NAME + '/' + "inverted.wav"),
    NO_AMMO           = new SoundFile(FYS.this, FOLDER_NAME + '/' + "noAmmo.wav"),
    PING_SHOOT        = new SoundFile(FYS.this, FOLDER_NAME + '/' + "pingShoot.wav"),
    IMMUNE            = new SoundFile(FYS.this, FOLDER_NAME + '/' + "immune.wav");

  void play(int type)
  {
    switch (type)
    {
    case Sounds.RECIEVE_DAMAGE:
      if (!RECIEVE_DAMAGE.isPlaying())
      {      
        RECIEVE_DAMAGE.play();
      }
      break;
    case Sounds.RESTORE_HEALTH:
      if (!RESTORE_HEALTH.isPlaying())
      {      
        RESTORE_HEALTH.play();
      }
      break;
    case Sounds.SHOOT:
      if (!SHOOT.isPlaying())
      {      
        SHOOT.play();
      }
      break;
    case Sounds.SPLIT:
      if (!SPLIT.isPlaying())
      {      
        SPLIT.play();
      }
      break;
    case Sounds.SLOW:
      if (!SLOW.isPlaying())
      {      
        SLOW.play();
      }
      break;
    case Sounds.INVERTED:
      if (!INVERTED.isPlaying())
      {      
        INVERTED.play();
      }
      break;
    case Sounds.IMMUNE:
      if (!IMMUNE.isPlaying())
      {      
        IMMUNE.play();
      }
      break;
       case Sounds.NO_AMMO:
      if (!NO_AMMO.isPlaying())
      {      
        NO_AMMO.play();
      }
      break;
       case Sounds.PING_SHOOT:
      if (!PING_SHOOT.isPlaying())
      {      
        PING_SHOOT.play();
      }
      break;
    }
  }
}
