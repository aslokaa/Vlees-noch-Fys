MySQL conn;
PImage 
      bulletImg, 
      shieldPowerImg, 
      invertedPowerImg, 
      bombPowerImg, 
      snailPowerImg, 
      bulletPowerImg, 
      playerSidesImg, 
      playerForcefieldImg,
      playerSlowImg, 
      playerShieldImg, 
      playerReverseImg, 
      playerDmgImg, 
      lesterBodyImg, 
      lesterHitbox4HPImg, 
      lesterHitbox3HPImg, 
      lesterHitbox2HPImg, 
      lesterHitbox1HPImg, 
      lesterHitbox0HPImg, 
      enemyDaveImg, 
      enemyChadImg, 
      enemyChadThrusterImg, 
      explosionImg, 
      smokeImg1, 
      smokeImg2, 
      powerHpUpImg, 
      BallFys1Img, 
      BallFys2Img, 
      BallFys3Img, 
      splitPowerImg,
      bulletPlaceholder,
      shieldPlaceholder;

PImage[] explosionAnimation = new PImage[5];
PImage[] ballAnimation = new PImage[3];
PImage[] enemyBulletAnimation = new PImage[3];
String  fileName;
String connServer = "oege.ie.hva.nl";
String connDB = "zroete";
String connUser = "roete";
String connPass = "KWVvztAFWytWOG";

public void loadAssets() {
  conn = new MySQL(this, connServer, connDB, connUser, connPass);
  bulletImg = loadImage("./sprites/BulletFysGame.png");
  bulletPowerImg = loadImage("./sprites/BulletFysGamePower.png");
  playerSidesImg = loadImage("./sprites/RocketPlayerFysGame.png");
  playerForcefieldImg = loadImage("./sprites/PlayerBounceFysGame.png");
  playerSlowImg = loadImage("./sprites/PlayerSlowedBounceFysGame.png");
  playerShieldImg = loadImage("./sprites/PlayerShieldBounceFysGame.png");
  playerReverseImg = loadImage("./sprites/PlayerReversedBounceFysGame.png");
  playerDmgImg = loadImage("./sprites/PlayerDmgBounceFysGame.png");
  lesterBodyImg = loadImage("./sprites/lesterBodySprite.png");
  lesterHitbox4HPImg = loadImage("./sprites/lesterHitboxSprite4HP.png");
  lesterHitbox3HPImg = loadImage("./sprites/lesterHitboxSprite3HP.png");
  lesterHitbox2HPImg = loadImage("./sprites/lesterHitboxSprite2HP.png");
  lesterHitbox1HPImg = loadImage("./sprites/lesterHitboxSprite1HP.png");
  lesterHitbox0HPImg = loadImage("./sprites/lesterHitboxSprite0HP.png");
  enemyDaveImg = loadImage("./sprites/daveSprite.png");
  enemyChadImg = loadImage("./sprites/chadSprite.png");
  enemyChadThrusterImg = loadImage("./sprites/chadThrusterSprite.png");
  explosionImg = loadImage("./sprites/explosion_particle.png");
  snailPowerImg = loadImage("./sprites/snail3.0.png");
  bombPowerImg = loadImage("./sprites/bomb.png");
  invertedPowerImg = loadImage("./sprites/inverted.png");
  shieldPowerImg = loadImage("./sprites/shield.png");
  splitPowerImg = loadImage("./sprites/split2.0.png");
  bulletPlaceholder = loadImage("./sprites/BulletPlaceholder.png");
  shieldPlaceholder = loadImage("./sprites/shieldPlaceholder.png");

  smokeImg1 = loadImage("./sprites/smokeParticle1.png");
  smokeImg2 = loadImage("./sprites/smokeParticle2.png");

  powerHpUpImg = loadImage("./sprites/HpUpFysGame.png");

   for ( int i = 0; i < 5; i++ )
    {
      fileName = "./sprites/smokeParticle" + i + ".png";
      explosionAnimation[i] = loadImage(fileName);
    }
    
    for ( int i = 0; i < 3; i++ )
    {
      fileName = "./sprites/BallFys" + i + ".png";
      ballAnimation[i] = loadImage(fileName);
    }
    
    for ( int i = 0; i < 3; i++ )
    {
      fileName = "./sprites/lesterBullet" + i + ".png";
      enemyBulletAnimation[i] = loadImage(fileName);
    }
  
}
