MySQL sql;
PImage 
  bulletImg, 
  spikeBallImg, 
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
  aButtonImg, 
  bButtonImg, 
  shieldPlaceholder, 
  ballBomImg1, 
  ballBomImg2, 
  ballBomImg3, 
  black, 
  arrowImg, 
  star, 

  p0, 
  p1, 
  p2, 
  p3, 
  p4, 
  p5, 
  p6, 
  p7;

PImage[] explosionAnimation = new PImage[5];
PImage[] ballAnimation = new PImage[3];
PImage[] enemyBulletAnimation = new PImage[3];
PImage[] ballBombAnimation = new PImage[3];
PImage[] planets = new PImage[8];

String  fileName;
String connServer = "oege.ie.hva.nl";
String connDB = "zroete";
String connUser = "roete";
String connPass = "KWVvztAFWytWOG";

public void loadAssets() {
  sql = new MySQL(this, connServer, connDB, connUser, connPass);
  sql.connect();

  bulletImg = loadImage("./sprites/BulletFysGame.png");
  spikeBallImg = loadImage("./sprites/SpikeSpriteFysGame.png");
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
  aButtonImg = loadImage("./sprites/aButtonImg.png");
  bButtonImg = loadImage("./sprites/bButtonImg.png");
  smokeImg1 = loadImage("./sprites/smokeParticle1.png");
  smokeImg2 = loadImage("./sprites/smokeParticle2.png");
  star = loadImage("./sprites/star.png");
  black = loadImage("./sprites/black.png");
  powerHpUpImg = loadImage("./sprites/HpUpFysGame.png");
  arrowImg = loadImage("./sprites/arrowImg.png");

  //https://clipartpng.com/?planets-png,97
  p0 = loadImage("./sprites/p0.png");
  p1 = loadImage("./sprites/p1.png");
  p2 = loadImage("./sprites/p2.png");
  p3 = loadImage("./sprites/p3.png");
  p4 = loadImage("./sprites/p4.png");
  p5 = loadImage("./sprites/p5.png");
  p6 = loadImage("./sprites/p6.png");
  p7 = loadImage("./sprites/p7.png");
  planets[0] = p0;
  planets[1] = p1;
  planets[2] = p2;
  planets[3] = p3;
  planets[4] = p4;
  planets[5] = p5;
  planets[6] = p6;
  planets[7] = p7;

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

  for ( int i = 0; i < 3; i++ )
  {
    fileName = "./sprites/BallBomb" + i + ".png";
    ballBombAnimation[i] = loadImage(fileName);
  }   
}
