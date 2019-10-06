/*
deze class is een base-class voor alle enemies, alle methodes en
atributen zitten in alle enemies die gemaakt worden met deze class.
het bevat een x en y positie, x en y snelheden, en een update en draw methode
die executeBehavior en display heten.

Eele Roet 500795948
*/
class Enemy
{
  float x;
  float y;
  float speedX;
  float speedY;

  Enemy(float x, float y)
  {
    this.x = x;
    this.y = y;
  }

  void executeBehavior()
  {
    println("define the method before using it");
  }
  
  void display()
  {
  }
}
