/*
used the code from the response of user 'Chrisir' on the question about textboxes on the processing forum,
 link: https://forum.processing.org/two/discussion/20882/very-basic-question-how-to-create-an-input-text-box
 
 Eele Roet 500795948
 */

static final int NUM = 5;
final TextBox[] textboxes = new TextBox[NUM];
int textBoxesIndex;

class TextBox { // demands rectMode(CORNER)
  final color textC, baseC, borderC, selectC;
  final short x, y, w, h, xw, yh, lim;

  boolean isFocused;
  String text = "";
  String label;

  TextBox(int xx, int yy, int ww, int hh, int li, 
    color te, color ba, color bo, color se, 
    String label) {
    x = (short) xx;
    y = (short) yy;
    w = (short) ww;
    h = (short) hh;

    lim = (short) li;

    xw = (short) (xx + ww);
    yh = (short) (yy + hh);

    textC = te;
    baseC = ba;
    borderC = bo;
    selectC = se;

    this.label = label;
  }

  void display() {
    fill(255);
    text(label, x - (( Loginscreen.LEGENDA_TEXT_SIZE / 3 ) * label.length()), y + h );
    stroke(isFocused? selectC : borderC);
    fill(baseC);
    rect(x, y, w, h);

    fill(textC);
    text(text, x, y + Loginscreen.LEGENDA_TEXT_SIZE / 3, w, h);
  }



  boolean checkFocus() {
    return isFocused = mouseX > x & mouseX < xw & mouseY > y & mouseY < yh;
  }
}

void mouseClicked() {
  if ( statePaused )
  {
    int i = textBoxesIndex = -1;
    while (++i != NUM)  if (textboxes[i].checkFocus())  textBoxesIndex = i;
  }
}



void enterLetter(char keyTyped)
{
  final char keyToCheck = keyTyped;

  final TextBox tbox = textboxes[textBoxesIndex];
  final int len = tbox.text.length();
  if (keyToCheck == BACKSPACE)  
  {
    tbox.text = tbox.text.substring(0, max(0, len-1));
    if ( tbox.text.length() == 0)
    {
      if ( textBoxesIndex != 0 && textBoxesIndex != 2)
      {
        textboxes[textBoxesIndex].isFocused = false;
        textBoxesIndex--;
        textboxes[textBoxesIndex].isFocused = true;
      }
    }
  } else if (len >= tbox.lim)  return;
  else if (keyToCheck >= ' ')     tbox.text += str(keyToCheck);
  println(tbox.text);
}

void cycleTboxFocus()
{
  println(textBoxesIndex);
  if ( textBoxesIndex == 0 || textBoxesIndex == 2 || textBoxesIndex == 3)
  {
    textboxes[textBoxesIndex].isFocused = false;
    textBoxesIndex++;
    textboxes[textBoxesIndex].isFocused = true;
  } else if ( textBoxesIndex == 1 || textBoxesIndex == 4 )
  {
    checkLogin(textBoxesIndex);
  }
}

void checkLogin(int index)
{

  String query;
  if (index == 1 )
  {
    println("checking database shit");
    query = "SELECT * FROM player WHERE name = '" + textboxes[0].text + "' AND password = '" + textboxes[1].text + "'";
    sql.query(query);

    if (sql.next())
    {
        println("nice");
        loginscreen.loggedIn = true;
        int id = sql.getInt(1);
        loggedInPlayerID = id;
        achievement.databaseReady=false;
      
    }
    //find out if username exists in records, get password belonging to username,
    //check if passwords crosscheck. if it checks out, change loginscreen.loggedIn to true, 
    //change logged in playerID.
  }
  if ( index == 4 )
  {
    println("checking database things");
    //check if username already exists.

    query = "SELECT * FROM player WHERE name = '" + textboxes[2].text + "'";
    sql.query(query);

    if (sql.next())
    {
      
        println("user already exists");
        loginscreen.changeError("doubleUser");
        return;
    }
    //check if both passwords are the same.
    if ( textboxes[3].text.equals(textboxes[4].text))
    {
      //make new record.
      println("make new record");
      
      query = "INSERT INTO player ( name, password) VALUES ( '" 
              + textboxes[2].text + "', '" + textboxes[3].text + "')";
      sql.query(query);
      
      query = "SELECT idplayer FROM player WHERE name = '" + textboxes[2].text + "' AND password = '" + textboxes[3].text + "'";
      sql.query(query);
      sql.next();
      
      loginscreen.loggedIn = true;
      loggedInPlayerID = sql.getInt(1);
      achievement.databaseReady=false;
    
    }
  }
}
