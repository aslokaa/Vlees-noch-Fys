public abstract class Paddle { 
  protected float 
    x, 
    y, 
    paddleWidth, 
    paddleHeight, 
    accelerationX, 
    accelerationY, 
    velocityX, 
    velocityY, 
    decelerateX, 
    decelerateY;

  public abstract void update(); //the update cycle
  public abstract void display();//the display cycle
  protected float decelerate(float velocity, float decelerate){ 
     return velocity * decelerate;
  }
  protected abstract void countdown(); 
  abstract void move();
    public void setPosition(float x, float y) {
    this.x=x;
    this.y=y;
  }
  
}
