/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package element;

import element.GridSpace.Layer;

/**
 *
 * @author Phil
 */
public class ScreenGrid {
    int cols;
    int rows;
    GridSpace[][] theGrid;

    public ScreenGrid(int rows, int cols) {
        if(rows > 0 && cols > 0)
        {
            this.cols = cols;
            this.rows = rows;

            theGrid = new GridSpace[rows][cols];
        }
        else
        {
            throw new ArrayIndexOutOfBoundsException("Rows and Cols must be greater than 0");
        }
    }
    
    public void setSprite(int row, int col, Layer layer, Sprite newSprite)
    {
        if(row >= 0 && row < rows && col >= 0 && col < cols)
        {
            theGrid[row][col].setSprite(layer, newSprite);
        }
        else
        {
            throw new ArrayIndexOutOfBoundsException();
        }
    }
    
}
