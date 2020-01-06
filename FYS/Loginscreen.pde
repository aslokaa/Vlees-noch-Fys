class Loginscreen
{
  private String 
    errorMsg = "";
  
  private boolean
    pickingOption = true, 
    loggingIn,
    loggedIn               = false;

  private final PVector
    USER_TBOX_POS             = new PVector(350, 150), 
    USER_TBOX_DIMENSION       = new PVector(500, 100), 
    PASSWORD_TBOX_POS         = new PVector(350, 300), 
    PASSWORD_TBOX_DIMENSION   = new PVector(500, 100), 
    KEYBOARD                  = new PVector(400, 570), 
    LEGENDA                   = new PVector(900, 150),
    ERROR_POS                 = new PVector(600, 50);

  private final int
    TBOX_LIMIT             = 14, 
    TBOX_TEXT_COLOR        = 240, 
    TBOX_BORDER_COLOR      = 255, 
    LEGENDA_TEXT_OFFSET    = 70;

  static final int
    LEGENDA_TEXT_SIZE      = 50;

  private final color
    TBOX_SELECTED_COLOR    = color(#00ff00);

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
      displayError();
    }
  }

  public void update()
  {
    checkChangeState();
  }

  private void checkChangeState()
  {
    if (loggedIn)
    {
      stateLogin = false;
      statePlaying = true;
      //create new game in database
      sql.query("INSERT INTO `Game` (`player_idplayer`, `score`, `wave`, `time`, `enemieskilled`) VALUES("+loggedInPlayerID+", 0,0,0,0)");
      sql.query("SELECT MAX(idgame) as idgame FROM Game ");
      if ( sql.next()) {
        idCurrentGame = sql.getInt("idgame");
        println(idCurrentGame);
      }    
    }
  }

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
  
  private void displayError()
  {
    fill(Colors.RED);
    text(errorMsg, ERROR_POS.x, ERROR_POS.y); 
  }
  
  public void changeError(String error)
  {
   switch( error)
   {
    case "doubleUser":
      errorMsg = "this user already exists.";
   }
  }
}
