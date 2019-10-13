//Niklas Leeuwin
//500784205
//

//this class handles the sounds the menu's make
class MenuSounds
{
  final String
    FOLDER_NAME       = "menuSounds";
  final SoundFile  
    START_GAME        = new SoundFile(FYS.this, FOLDER_NAME + '/' + "startGame.wav"), 
    GAME_MUSIC0       = new SoundFile(FYS.this, FOLDER_NAME + '/' + "gameMusic0.wav"), 
    GAME_MUSIC1       = new SoundFile(FYS.this, FOLDER_NAME + '/' + "gameMusic1.mp3"), 
    GAME_MUSIC2       = new SoundFile(FYS.this, FOLDER_NAME + '/' + "gameMusic2.mp3"), 
    END_MUSIC         = new SoundFile(FYS.this, FOLDER_NAME + '/' + "endMusic.mp3"), 
    PAUSE             = new SoundFile(FYS.this, FOLDER_NAME + '/' + "pause.wav"), 
    UNPAUSE           = new SoundFile(FYS.this, FOLDER_NAME + '/' + "unpause.wav");

//plays sounds
  void play(int type)
  {
    switch (type)
    {
    case Sounds.START_GAME:
      if (!START_GAME.isPlaying())
      {      
        START_GAME.play();
      }
      break;
    case Sounds.GAME_MUSIC0:
      if (!GAME_MUSIC0.isPlaying())
      {      
        GAME_MUSIC0.play();
      }
      break;
    case Sounds.GAME_MUSIC1:
      if (!GAME_MUSIC1.isPlaying())
      {      
        GAME_MUSIC1.play();
      }
      break;
    case Sounds.GAME_MUSIC2:
      if (!GAME_MUSIC2.isPlaying())
      {      
        GAME_MUSIC2.play();
      }
      break;
    case Sounds.END_MUSIC:
      if (!END_MUSIC.isPlaying())
      {      
        END_MUSIC.play();
      }
      break;
    case Sounds.PAUSE:
      if (!PAUSE.isPlaying())
      {      
        PAUSE.play();
      }
      break;
    case Sounds.UNPAUSE:
      if (!PAUSE.isPlaying())
      {      
        PAUSE.play();
      }
      break;
    }
  }
  
  //stops sounds
  void stop(int type)
  {
    switch (type)
    {
    case Sounds.START_GAME:
      if (START_GAME.isPlaying())
      {      
        START_GAME.stop();
      }
      break;
    case Sounds.GAME_MUSIC0:
      if (GAME_MUSIC0.isPlaying())
      {      
        GAME_MUSIC0.stop();
      }
      break;
    case Sounds.GAME_MUSIC1:
      if (GAME_MUSIC1.isPlaying())
      {      
        GAME_MUSIC1.stop();
      }
      break;
    case Sounds.GAME_MUSIC2:
      if (GAME_MUSIC2.isPlaying())
      {      
        GAME_MUSIC2.stop();
      }
      break;
    case Sounds.END_MUSIC:
      if (END_MUSIC.isPlaying())
      {      
        END_MUSIC.stop();
      }
      break;
    case Sounds.PAUSE:
      if (PAUSE.isPlaying())
      {      
        PAUSE.stop();
      }
      break;
    case Sounds.UNPAUSE:
      if (PAUSE.isPlaying())
      {      
        PAUSE.stop();
      }
      break;
    }
  }
}
