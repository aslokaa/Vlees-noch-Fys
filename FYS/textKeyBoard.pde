/*
on display keyboard data and navigation
 Eele Roet
 */

class TextKeyboard 
{
  int currentRow = 1;
  int currentCol = 1;
  char[][] rows = new char[3][];

  float x;
  float y;
  final int KEY_WIDTH       = 70;
  final int KEY_MARGIN      = 10;
  final int ROW_X_OFFSET    = KEY_WIDTH / 2;
  final int ROW_Y_OFFSET    = KEY_WIDTH + KEY_MARGIN;
  final int KEY_STROKE      = 3;
  final int KEY_BORDERRAD   = 4;
  final int TEXT_SIZE       = 55;

  TextKeyboard(float x, float y)
  {
    this.x = x;
    this.y = y;

    char[] row0 = {'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'};
    char[] row1 = {'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'};
    char[] row2 = {'z', 'x', 'c', 'v', 'b', 'n', 'm'};
    rows[0] = row0;
    rows[1] = row1;
    rows[2] = row2;
  }

  void handleTextInput()
  {
    //x is typen, a is backspace, d is spatie, w is enter.
    if ( keyCodesPressed[LEFT] )
    {
      currentCol--;
      currentCol = currentCol < 0 ? rows[currentRow].length - 1 : currentCol;
    } else if ( keyCodesPressed[RIGHT] )
    {
      currentCol++;
      currentCol = currentCol > rows[currentRow].length - 1 ? 0 : currentCol;
    } else if ( keyCodesPressed[UP] )
    {
      currentRow--;
      currentRow = currentRow < 0 ? rows.length - 1 : currentRow;
    } else if ( keyCodesPressed[DOWN] )
    {
      currentRow++;
      currentRow = currentRow > rows.length - 1 ? 0 : currentRow;
      currentCol = currentCol > rows[currentRow].length - 1 ? rows[currentRow].length - 1 : currentCol;
    } else if ( keyCodesPressed['x'] )
    {
      enterLetter(rows[currentRow][currentCol]);
    } else if ( keyCodesPressed['d'] )
    {
      enterLetter(' ');
    } else if ( keyCodesPressed['w'] )
    {
      println("enter pressed");
    } else if ( keyCodesPressed['a'] )
    {
      enterLetter(BACKSPACE);
    }

    println(currentRow, currentCol);
  }

  void display()
  {
    for ( int j = 0; j < rows.length; j++)
    {
      for ( int i = 0; i < rows[j].length; i++ )
      {
        noFill();
        strokeWeight(KEY_STROKE);
        if ( j == currentRow && i == currentCol )
        {
         stroke( Colors.RED ); 
        }
        else
        {
         stroke(255); 
        }
        rect( x + (j * ROW_X_OFFSET) + ( i * (KEY_MARGIN + KEY_WIDTH)), y + (j * ROW_Y_OFFSET), KEY_WIDTH, KEY_WIDTH, KEY_BORDERRAD);
        fill(255);
        textSize(TEXT_SIZE);
        text(rows[j][i], x + (j * ROW_X_OFFSET) + ( i * (KEY_MARGIN + KEY_WIDTH)) + KEY_WIDTH / 2, y + (j * ROW_Y_OFFSET) + KEY_WIDTH * 0.7);
      }
    }
  }
}
