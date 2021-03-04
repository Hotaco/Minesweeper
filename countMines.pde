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
