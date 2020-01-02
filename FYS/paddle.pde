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

  public abstract void update();
  protected float decelerate(float velocity, float decelerate){ 
     return velocity * decelerate;
  }
  protected abstract void countdown(); 
  protected void move()
  {
    x += velocityX;
    y += velocityY;
  }
    public void setPosition(float x, float y) {
    this.x=x;
    this.y=y;
  }
  
}
