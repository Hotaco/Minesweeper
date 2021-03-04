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
    System.out.print(row + ",");
    System.out.println(col);
  }
}
