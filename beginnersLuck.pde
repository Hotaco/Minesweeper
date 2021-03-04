private int row, col;

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
