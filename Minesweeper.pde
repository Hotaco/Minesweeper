import de.bezier.guido.*;
private int numRows = 20;
private int numCols = 20;
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
    text("YOU LOSE",250,650);
    text(time,450,50);
}

public void displayWinningMessage()
{
    System.out.print("You Win");
    text("YOU WIN",250,650);
    text(time,450,50);
}
