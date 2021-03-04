import de.bezier.guido.*;
private int numRows = 20;
private int numCols = 20;
private int row, col;
private int numMines = 40;
private int time = 0;
private int minesFlagged = 0;
private int realMinesFlagged = 0;
private boolean first = true;
private boolean lose, win = false;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mines

void setup ()
{
    size(500, 700);
    textSize(20);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[numRows][numCols];
    
    for(int r = 0; r < numRows; r++)
    {
      for(int c = 0; c < numCols; c++)
      {
        buttons[r][c] = new MSButton(r,c);
      }
    }
    placeMines(numMines);
}

public void draw ()
{
    background( 255 );
    fill(0);
    if(isWon() == true)
    {
        win = true;
        displayWinningMessage();
    }
    if(isLost() == true)
    {
      displayLosingMessage();
    }
    if(lose == false)
    {
      text(millis()/1000,450,50);
    }
    text(numMines-minesFlagged,50,50);
    if(mines.size() < numMines)
    {
      placeMines(numMines - mines.size());
    }
}

public boolean isWon()
{
    if(realMinesFlagged == numMines)
    {
      time = millis()/1000;
      return true;
    }
    return false;
}

public boolean isLost()
{
  if(lose == true)
  {
    return true;
  }
  return false;
}

public void displayLosingMessage()
{
    text(time,450,50);
}

public void displayWinningMessage()
{
    text("YOU WIN",250,650);
    text(time,450,50);
}

public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged, revealed;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 500/numCols;
        height = (500/numRows);
        myRow = row;
        myCol = col;
        x = myCol*width;
        y = myRow*height+100;
        myLabel = "";
        flagged = false;
        clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {   
      if(lose == false && win == false)
      {
        if(first == true)
        {
          beginnersLuck(myRow, myCol);
        }
        if(flagged == true)
        {
          revealed = false;
        }
        clicked = true;
        if(mouseButton == RIGHT && revealed != true)
        {
          flagged = !flagged;
          if(flagged == false)
          {
            clicked = false;
            minesFlagged--;
            if(mines.contains(this))
            {
              realMinesFlagged--;
            }
          }
          if(flagged)
          {
            if(mines.contains(this))
            {
              realMinesFlagged++;
              minesFlagged++;
            }
            else if (!mines.contains(this))
            {
              minesFlagged++;
            }
          }
        }
        else if(mouseButton == LEFT && mines.contains(this) && buttons[myRow][myCol].flagged == false) //if clicked mine
        {
          lose = true;
          time = millis()/1000;
        }
        else if (countMines(myRow,myCol) > 0 && buttons[myRow][myCol].flagged == false) //if there are mines around
        {
          revealed = true;
          setLabel(countMines(myRow,myCol));
        }
        else if (buttons[myRow][myCol].flagged == false)//recursively click
        {
          revealed = true;
          for(int r = myRow-1; r < myRow+2; r++)
          {
            for(int c = myCol-1; c < myCol+2; c++)
            {
              if(isValid(r,c) && !buttons[r][c].clicked == true)
              {
                buttons[r][c].mousePressed();
              }
            }
          }
        }
      }
    }
    
    
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
             fill(255,0,0);
        else if(clicked && buttons[myRow][myCol].flagged == false)
            fill( 180 );
        else if(lose == true && mines.contains(this))
            fill(255,0,0);
        else 
            fill( 220 );

        rect(x, y, width, height);
        if(countMines(myRow,myCol) == 1)
        {
          fill(0,0,100);
        }
        if(countMines(myRow,myCol) == 2)
        {
          fill(0,180,0);
        }
        if(countMines(myRow,myCol) == 3)
        {
          fill(200,0,0);
        }
        if(countMines(myRow,myCol) > 3)
        {
        fill(0);
        }
        text(myLabel,x+width/2,y+height/2);
    }
    
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}

public void beginnersLuck(int MyRow, int MyCol)
{
  row = MyRow;
  col = MyCol;
  removeMines();
}

public void removeMines()
{
  for(int r = row-1; r < row+2; r++)
    {
      for(int c = col-1; c < col+2; c++)
      {
        if(isValid(r,c) == true)
        {
          if(mines.contains(buttons[r][c]) == true)
          {
            mines.remove(buttons[r][c]); 
          }
        }
      }
    }
    first = false;
    countMines(row,col);
}

public int countMines(int row, int col)
{
    int numMines = 0;
    for(int r = row-1; r < row+2; r++)
    {
      for(int c = col-1; c < col+2; c++)
      {
        if(isValid(r,c) == true)
        {
          if(mines.contains(buttons[r][c]) == true)
          {
            numMines++; 
          }
        }
      }
    }
    if(mines.contains(buttons[row][col]) == true)
    {
      numMines--;
    }
    return numMines;
}

public boolean isValid(int r, int c)
{
    if(r < numRows && r >= 0 && c < numCols && c >= 0)
    {
      return true;
    }
    else
    {
    return false;
    }
    
}

public void placeMines(int num)
{
  for(int i = 0; i < num; i++)
  {
    int row = (int)(Math.random()*numRows);
    int col = (int)(Math.random()*numCols);
    
    if(!mines.contains(buttons[row][col]) && buttons[row][col].revealed == false)
    {
      mines.add(buttons[row][col]);
    }
    else
    {
      i--;
    }
  }
}



