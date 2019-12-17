//wave format.
class WaveFormat
{
  int daveCounter; 
  int chadCounter;
  int roundStartCounter; 
  int minRoundLength;
  int roundLengthCounter;
  boolean spawnPing; 
  boolean spawnLester; 
  boolean ballActive;
  boolean safetyFloorActive; 
  boolean roundSkippable;
  
  WaveFormat(int dave, int chad, int roundStart, int minRound, int roundLength, boolean ping, boolean lester, boolean ball, boolean safetyFloor, boolean roundSkippable)
  {
    daveCounter = dave;
    chadCounter = chad;
    roundStartCounter = roundStart;
    minRoundLength = minRound;
    roundLengthCounter = roundLength;
    spawnPing = ping;
    spawnLester = lester;
    ballActive = ball;
    safetyFloorActive = safetyFloor;
    this.roundSkippable = roundSkippable;
  }
}
