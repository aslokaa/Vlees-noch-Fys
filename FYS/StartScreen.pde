class Startscreen
{
  void updateStartscreen()
  {
    updateGameStates();
  }
  void display()
  {
   displayBackground();
   displayText();
  }
  
  void displayBackground()
  {
    for ( int i = 0; i < space.length; i++ )
    {
      space[i].display();
    }
  }
  void displayText()
  {
  }
  void updateGameStates()
  {
    if (checkInput())
    {
      state0=false;
      state1=true;
    }
  }

  boolean checkInput()
  {
    return (keyCodesPressed[LEFT]||keyCodesPressed[RIGHT]||keyCodesPressed[DOWN]||keyCodesPressed[UP]
      ||keysPressed['z']||keysPressed['x']||keysPressed['a']||keysPressed['s']);
  }
}
