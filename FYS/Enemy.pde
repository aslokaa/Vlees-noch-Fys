/*
deze class is een base-class voor alle enemies, alle methodes en
 atributen zitten in alle enemies die gemaakt worden met deze class.
 het bevat een x en y positie, x en y snelheden, en een update en draw methode
 die executeBehavior en display heten.
 
 Eele Roet 500795948
 */
class Enemy
{
  boolean active;//checks if enemy should be updated and drawn.
  float hitboxRadius;
  float hitboxDiameter;
  float damageToDeal;//amount of damage enemy does to the player.
  float x;
  float y;
  float speedX;
  float speedY;

  Enemy(boolean active, float x, float y, float hitboxRadius)
  {
    this.active = active;
    this.x = x;
    this.y = y;
    this.hitboxRadius = hitboxRadius;
    this.hitboxDiameter = hitboxRadius * 2;
  }

    //gets called in the updateGame methode in the main.
  void executeBehavior()
  {
    println("define the behavior method before using it");
  }

  void handlePlayerCollision(Rectangles rectangles)
  {
     if ( checkPlayerCollision(rectangles.rectangle0) ) 
    {
      player.dealDamage(damageToDeal, false);
    }
    if ( checkPlayerCollision(rectangles.rectangle1) ) 
    {
      player.dealDamage(damageToDeal, true);
    }
  }
  
    //does a circle-line collisioncheck with the enemy hitbox and the horizontal line in the middle of player.
  boolean checkPlayerCollision(Rectangle rectangle)
  {
    if ( x >= rectangle.x && x <= rectangle.x + rectangle.rectangleWidth &&
      y + hitboxRadius > rectangle.y + ( rectangle.rectangleHeight / 2) && y - hitboxRadius < rectangle.y + ( rectangle.rectangleHeight / 2))
    {
      return true;
    }
    return false;
  }

    //gets called when enemy needs to be destroyed.
  void destroy()
  {
    println("define the destroy method before using it");
    spawnPowerup();
    explode();
  }

  void activate(float posX, float posY)
  {
     this.x = posX;
     this.y = posY;
     this.active = true;
     //currentrow moet ook gereset worden -niklas
  }

  void spawnPowerup()
  {
    println("define the spawnPowerup method before using it");
  }
    //handles dying animation.
  void explode()
  {
    println("define the explode method before using it");
  }

    //gets called in the drawGame method in the main.
  void display()
  {
    println("define the display method before using it");
  }
}
