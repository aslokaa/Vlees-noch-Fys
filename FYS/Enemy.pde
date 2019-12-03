/*
this class is a base-class for all enemies, all methods and fields are contained in 
 all enemies derived from this class.
 the fields are X and Y positions and X and Y speeds, the methods are called executeBehavior and display.
 
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

  
  void executeBehavior()//gets called in the updateGame methode in the main.
  {
    println("define the behavior method before using it");
  }

  void handlePlayerCollision(Rectangles rectangles)
  {
    if ( checkPlayerCollision(rectangles.rectangle0) ) 
    {
      player.dealDamage(damageToDeal, false);
    }
    if ( checkPlayerCollision(rectangles.rectangle1) && rectangles.rectangle1.exists) 
    {
      player.dealDamage(damageToDeal, true);
    }
  }

  //does a circle-line collision check with the enemy hitbox and the horizontal line in the middle of players height.
  boolean checkPlayerCollision(Rectangle rectangle)
  {
    if ( x >= rectangle.x && x <= rectangle.x + rectangle.rectangleWidth &&
      y + hitboxRadius > rectangle.y + ( rectangle.rectangleHeight / 2) && y - hitboxRadius < rectangle.y + ( rectangle.rectangleHeight / 2))
    {
      return true;
    }
    return false;
  }


  void destroy()//gets called when enemy needs to be destroyed.
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
    this.speedX = 0;
    this.speedY = 0;
  }

  void spawnPowerup()
  {
    println("define the spawnPowerup method before using it");
  }

  void explode()//handles dying animation.
  {
    println("define the explode method before using it");
  }

  void display()//gets called in the drawGame method in the main.
  {
    println("define the display method before using it");
  }
}
