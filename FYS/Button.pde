class Button
{
  private float x;
  private float y;
  private float width;
  private float height;
  private String text;
  public boolean selected;
  private boolean login;

  Button(float x, float y, float width, float height, String text, boolean login)
  {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.text = text;
    this.selected = false;
    this.login = login;
  }

  void display()
  {
    noFill();
    stroke(selected ? #00ff00 : 255);
    strokeWeight(3);
    rect(x, y, width, height);
    fill(255);
    text(text, x + width / 2, y + height / 2);
  }

  void click()
  {
    loginscreen.pickingOption = false;
    if ( this == buttons[0] )
    {
      loginscreen.loggingIn = true;
      textboxes[0].isFocused = true;
      textBoxesIndex = 0;
    } else 
    {
      loginscreen.loggingIn = false;
      textboxes[2].isFocused = true;
      textBoxesIndex = 2;
    }
  }
}
void handleButtonNav()
{
  //x is typen, a is backspace, d is spatie, w is enter.
  if ( keyCodesPressed[UP] || keyCodesPressed[DOWN])
  {
    if ( buttons[0].selected )
    {
      buttons[0].selected = false;
      buttons[1].selected = true;
    } else 
    {
      buttons[0].selected = true;
      buttons[1].selected = false;
    }
  } else if ( keyCodesPressed[88] )
  {
    if ( buttons[0].selected )
    {
      buttons[0].click();
    } else
    {
      buttons[1].click();
    }
  }
}
