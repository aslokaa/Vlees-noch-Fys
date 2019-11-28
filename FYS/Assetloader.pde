

PImage bulletImg ,shieldPowerImg, invertedPowerImg, bombPowerImg, snailPowerImg, bulletPowerImg, playerSidesImg, 
playerForcefieldImg, lesterBodyImg, lesterHitbox4HPImg, lesterHitbox3HPImg, lesterHitbox2HPImg, lesterHitbox1HPImg, lesterHitbox0HPImg, 
enemyDaveImg, explosionImg, smokeImg1, smokeImg2, powerHpUpImg, BallFys1Img, BallFys2Img, BallFys3Img, splitPowerImg;


public void loadAssets() {
  bulletImg = loadImage("./sprites/BulletFysGame.png");
  bulletPowerImg = loadImage("./sprites/BulletFysGamePower.png");
  playerSidesImg = loadImage("./sprites/RocketPlayerFysGame.png");
  playerForcefieldImg = loadImage("./sprites/PlayerBounceFysGame.png");
  lesterBodyImg = loadImage("./sprites/lesterBodySprite.png");
  lesterHitbox4HPImg = loadImage("./sprites/lesterHitboxSprite4HP.png");
  lesterHitbox3HPImg = loadImage("./sprites/lesterHitboxSprite3HP.png");
  lesterHitbox2HPImg = loadImage("./sprites/lesterHitboxSprite2HP.png");
  lesterHitbox1HPImg = loadImage("./sprites/lesterHitboxSprite1HP.png");
  lesterHitbox0HPImg = loadImage("./sprites/lesterHitboxSprite0HP.png");
  enemyDaveImg = loadImage("./sprites/daveSprite.png");
  explosionImg = loadImage("./sprites/explosion_particle.png");
  snailPowerImg = loadImage("./sprites/snail3.0.png");
  bombPowerImg = loadImage("./sprites/bomb.png");
  invertedPowerImg = loadImage("./sprites/inverted.png");
  shieldPowerImg = loadImage("./sprites/shield.png");
  splitPowerImg = loadImage("./sprites/split2.0.png");

  smokeImg1 = loadImage("./sprites/smokeParticle1.png");
  smokeImg2 = loadImage("./sprites/smokeParticle2.png");

  powerHpUpImg = loadImage("./sprites/HpUpFysGame.png");

  
  
}
