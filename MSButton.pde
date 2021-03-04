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
