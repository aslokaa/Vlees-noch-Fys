class BossLester
{
  boolean active;
  float x;
  float y;
  final float HITBOX_OFFSET = 200;

  PVector hitboxLeftPos = new PVector(0,0);
  PVector hitboxBottomPos = new PVector(0,0);
  PVector hitboxRightPos = new PVector(0,0);

  BossLesterHitbox hitboxLeft; 
  BossLesterHitbox hitboxBottom; 
  BossLesterHitbox hitboxRight;



  BossLester(float x, float y)
  {
    active = true;
    this.x = x;
    this.y = y;
    hitboxLeftPos.x = x - HITBOX_OFFSET;
    hitboxLeftPos.y = y;
    hitboxBottomPos.x = x;
    hitboxBottomPos.y = y + HITBOX_OFFSET;
    hitboxRightPos.x = x + HITBOX_OFFSET;
    hitboxRightPos.y = y;
    hitboxLeft = new BossLesterHitbox(hitboxLeftPos.x, hitboxLeftPos.y);
    hitboxBottom = new BossLesterHitbox(hitboxBottomPos.x, hitboxBottomPos.y);
    hitboxRight = new BossLesterHitbox(hitboxRightPos.x, hitboxRightPos.y);
  }

  void update()
  {
    if ( active )
    {
      executeBehavior();
      hitboxLeft.update();
      hitboxBottom.update();
      hitboxRight.update();
      //setHitboxPositions();
      //check collisions
    }
  }

  void executeBehavior()
  {
    shootPlayer();
    spawnChad();
  }

  void shootPlayer()
  {
    //shoot from each active hitbox a bullet towards player
    //get angle from each hitbox to player then shoot with those speeds to move in that direction
    
  }

  void spawnChad()
  {
  }

  void setHitboxPositions()
  {
    
  }
  
  void display()
  {
    if ( active )
    {
      hitboxLeft.display();
      hitboxBottom.display();
      hitboxRight.display();
    }
  }
}
