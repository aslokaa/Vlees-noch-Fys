/*
used the code from the response of user 'Chrisir' on the question about textboxes on the processing forum,
link: https://forum.processing.org/two/discussion/20882/very-basic-question-how-to-create-an-input-text-box

Eele Roet 500795948
*/

static final int NUM = 2;
final TextBox[] textboxes = new TextBox[NUM];
int textBoxesIndex;

void mouseClicked() {
  if ( statePaused )
  {
    int i = textBoxesIndex = -1;
    while (++i != NUM)  if (textboxes[i].checkFocus())  textBoxesIndex = i;
  }
}



void enterLetter(char keyTyped)
{
  if ( statePaused )
  {
    final char keyToCheck = keyTyped;
    if (keyToCheck == CODED | textBoxesIndex < 0)  return;

    final TextBox tbox = textboxes[textBoxesIndex];
    final int len = tbox.txt.length();

    if (keyToCheck == BACKSPACE)  tbox.txt = tbox.txt.substring(0, max(0, len-1));
    else if (len >= tbox.lim)  return;
    else if (keyToCheck == ENTER | keyToCheck == RETURN)     tbox.txt += "\n";
    else if (keyToCheck == TAB & len < tbox.lim-3)  tbox.txt += "    ";
    else if (keyToCheck == DELETE)  tbox.txt = "";
    else if (keyToCheck >= ' ')     tbox.txt += str(keyToCheck);
  } 
}

void instantiateBoxes() {
  textboxes[0] = new TextBox(
    200, 200, // x, y
    800, 250, // w, h
    215, // limit
    0300 << 030, color(-1, 040), // textC, baseC
    color(-1, 0100), color(#FF00FF, 0200)); // bordC, slctC

  textboxes[1] = new TextBox(
    width>>3, height/2 + height/8, // x, y
    width - width/4, height - height/2 - height/4, // w, h
    640, // lim
    0300 << 030, color(-1, 040), // textC, baseC
    color(-1, 0100), color(#FFFF00, 0200)); // bordC, slctC
}

class TextBox { // demands rectMode(CORNER)
  final color textC, baseC, borderC, selectC;
  final short x, y, w, h, xw, yh, lim;

  boolean isFocused;
  String txt = "";

  TextBox(int xx, int yy, int ww, int hh, int li, 
    color te, color ba, color bo, color se) {
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
  }

  void display() {
    stroke(isFocused? selectC : borderC);
    fill(baseC);
    rect(x, y, w, h);

    fill(textC);
    text(txt + blinkChar(), x, y, w, h);
  }

  String blinkChar() {
    return isFocused && (frameCount>>2 & 1) == 0 ? "_" : "";
  }

  boolean checkFocus() {
    return isFocused = mouseX > x & mouseX < xw & mouseY > y & mouseY < yh;
  }
}
