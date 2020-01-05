class Loginscreen
{
  private boolean
    pickingOption = true, 
    loggingIn;

  private final PVector
    USER_TBOX_POS                  = new PVector(350, 150), 
    USER_TBOX_DIMENSION           = new PVector(500, 100), 
    PASSWORD_TBOX_POS                    = new PVector(350, 300), 
    PASSWORD_TBOX_DIMENSION        = new PVector(500, 100), 
    KEYBOARD                  = new PVector(400, 570), 
    LEGENDA                    = new PVector(900, 150);

  private final int
    TBOX_LIMIT             = 14, 
    TBOX_TEXT_COLOR        = 240, 
    TBOX_BORDER_COLOR      = 255, 
    LEGENDA_TEXT_OFFSET    = 70;

  static final int
    LEGENDA_TEXT_SIZE      = 50;

  private final color
    TBOX_SELECTED_COLOR    = color(#00ff00);

  private boolean 
    loggedIn               = false;

  Loginscreen() 
  {
    keyboard = new TextKeyboard( KEYBOARD.x, KEYBOARD.y ); 

    textboxes[0] = new TextBox(
      int (USER_TBOX_POS.x), int (USER_TBOX_POS.y), // x, y
      int (USER_TBOX_DIMENSION.x), int (USER_TBOX_DIMENSION.y), // w, h
      TBOX_LIMIT, // limit 
      color(TBOX_TEXT_COLOR), color(0, 0, 0, 0), // textC, baseC
      color(TBOX_BORDER_COLOR), color(TBOX_SELECTED_COLOR), // bordC, slctC
      "Username: "); // label text

    textboxes[1] = new TextBox(
      int (PASSWORD_TBOX_POS.x), int (PASSWORD_TBOX_POS.y), // x, y
      int (PASSWORD_TBOX_DIMENSION.x), int (PASSWORD_TBOX_DIMENSION.y), // w, h
      TBOX_LIMIT, // limit
      color(TBOX_TEXT_COLOR), color(0, 0, 0, 0), // textC, baseC
      color(TBOX_BORDER_COLOR), color(TBOX_SELECTED_COLOR), // bordC, slctC
      "Password: "); // label text
      
    textboxes[2] = new TextBox(
      int (USER_TBOX_POS.x), int (USER_TBOX_POS.y), // x, y
      int (USER_TBOX_DIMENSION.x), int (USER_TBOX_DIMENSION.y), // w, h
      TBOX_LIMIT, // limit 
      color(TBOX_TEXT_COLOR), color(0, 0, 0, 0), // textC, baseC
      color(TBOX_BORDER_COLOR), color(TBOX_SELECTED_COLOR), // bordC, slctC
      "Username: "); // label text
    
    textboxes[3] = new TextBox(
      int (PASSWORD_TBOX_POS.x), int (PASSWORD_TBOX_POS.y), // x, y
      int (PASSWORD_TBOX_DIMENSION.x), int (PASSWORD_TBOX_DIMENSION.y), // w, h
      TBOX_LIMIT, // limit
      color(TBOX_TEXT_COLOR), color(0, 0, 0, 0), // textC, baseC
      color(TBOX_BORDER_COLOR), color(TBOX_SELECTED_COLOR), // bordC, slctC
      "Password: "); // label text
    
    textboxes[4] = new TextBox(
      int (PASSWORD_TBOX_POS.x), int (450), // x, y
      int (PASSWORD_TBOX_DIMENSION.x), int (PASSWORD_TBOX_DIMENSION.y), // w, h
      TBOX_LIMIT, // limit
      color(TBOX_TEXT_COLOR), color(0, 0, 0, 0), // textC, baseC
      color(TBOX_BORDER_COLOR), color(TBOX_SELECTED_COLOR), // bordC, slctC
      "Confirm password: "); // label text

    buttons[0] = new Button(500, 300, 400, 150, "log in", true);
    buttons[1] = new Button(500, 500, 400, 150, "sign in", false);
    buttons[0].selected = true;
  }

  Text[] option = new Text[Arrays.OPTION_COUNT];

  public void display()
  {
    if ( pickingOption )
    {
      buttons[0].display();
      buttons[1].display();
    } else
    {
      if ( loggingIn )
      {
        displayLegenda();
        textboxes[0].display();
        textboxes[1].display();
        keyboard.display();
      }else
      {
        displayLegenda();
        textboxes[2].display();
        textboxes[3].display();
        textboxes[4].display();
        keyboard.display();
      }
    }
  }

  public void update()
  {
    changePausedState();
  }

  // pauses or unpauses the game.
  private void changePausedState()
  {
    if (loggedIn)
    {
      if (statePaused)
      {
        menuSounds.play(Sounds.UNPAUSE);
      } else
      {
        menuSounds.play(Sounds.PAUSE);
      }
      statePaused=!statePaused;
    }
  }


  //displays text
  private void displayLegenda()
  {
    textFont(font, LEGENDA_TEXT_SIZE * 0.7);
    fill(Colors.WHITE);
    textAlign(LEFT);
    text("Use the D-pad to navigate the keyboard", LEGENDA.x, LEGENDA.y);
    textFont(font, LEGENDA_TEXT_SIZE);
    text("Press 'a' for BACKSPACE", LEGENDA.x, LEGENDA.y + LEGENDA_TEXT_OFFSET);
    text("Press 'x' to type", LEGENDA.x, LEGENDA.y + LEGENDA_TEXT_OFFSET * 2);
    text("Press 'd' for SPACEBAR", LEGENDA.x, LEGENDA.y + LEGENDA_TEXT_OFFSET * 3);
    text("Press 'w' for ENTER", LEGENDA.x, LEGENDA.y + LEGENDA_TEXT_OFFSET * 4);
    textAlign(CENTER);
  }

  //handles the text for the pausescreen
  class Text
  {
    float   x, y;
    String  text;
    Text(float xT, float yT, String textT)
    {
      x    = xT;
      y    = yT;
      text = textT;
    }
  }
}
