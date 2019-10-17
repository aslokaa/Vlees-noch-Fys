/*
deze class is een base-class voor alle enemies, alle methodes en
 atributen zitten in alle enemies die gemaakt worden met deze class.
 het bevat een x en y positie, x en y snelheden, en een update en draw methode
 die executeBehavior en display heten.
 
 Eele Roet 500795948
 */
class Enemy
{
  boolean active;
  float hitboxRadius;
  float hitboxDiameter;
  float damageToDeal;
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

  void executeBehavior()
  {
    println("define the behavior method before using it");
  }

  void handlePlayerCollision(Rectangles rectangles)
  {
    println("define the playerCollision method before using it");
  }

  boolean checkPlayerCollision()
  {
    if ( x >= player.x && x <= player.x + player.playerWidth &&
      y + hitboxRadius > player.y + ( player.playerHeigth / 2) && y - hitboxRadius < player.y + ( player.playerHeigth / 2))
    {
      return true;
    }
    return false;
  }

  void destroy()
  {
    println("define the destroy method before using it");
    explode();
  }

  void explode()
  {
    println("define the explode method before using it");
  }

  void display()
  {
    println("define the display method before using it");
  }
}
