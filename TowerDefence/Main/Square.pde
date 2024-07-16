class Square {
  // initialise variables
  int rectX = 0;
  int rectY = 0;
  int xPos, yPos;
  int rectSize = 40; // size of the squares
  color rColor, highlighter; // colours to be used 
  boolean mouseOver = false; // is the mouse over the square
  boolean rectClicked = false;  // is the mouse clicked on the square

  Square() { 
    highlighter = color(175, 150); //  the highlight colour when moused over
    rColor = color(#237c96, 23);  // for semi transparent background to make squares visable
  }

  void showSquare (int x, int y) {
    rectX = x;
    rectY = y;
    update(mouseX, mouseY);
    xPos = findXPos();
    yPos = findYPos();
    // highlight the squares
    if (mouseOver) { // if mouse is over a square
      // check if square is not part of the track
      if (findMouseYPos < 11 && // bottom line
        !(findMouseYPos == 1 && findMouseXPos < 15) &&  // top horizontal track line
        !(findMouseXPos == 14 && (findMouseYPos >= 1 && findMouseYPos <= 3 || findMouseYPos >= 5 && findMouseYPos <= 7)) &&  // the down bits on the right connecting horizontal track lines 
        !(findMouseXPos == 1 && (findMouseYPos >= 3 && findMouseYPos <= 5 || findMouseYPos >= 7 && findMouseYPos <= 9)) && // the down bits on the left
        !(findMouseYPos == 3 && findMouseXPos < 15 && findMouseXPos >= 1) && // second horizontal track line
        !(findMouseYPos == 5 && findMouseXPos < 15 && findMouseXPos > 1) && // third horizontal track line
        !(findMouseYPos == 7 && findMouseXPos < 15 && findMouseXPos > 1) && // forth horizontal track line
        !(findMouseYPos == 9 && findMouseXPos <= 15 && findMouseXPos > 1)){  // fifth horizontal track line 
          fill(highlighter);
      }
    }
    else {
      fill (rColor); // set colour for semi transparent background squares
    }
    stroke(255, 10);
    rect(rectX, rectY, rectSize, rectSize); // draw semi transparent background square
  }

  void update (int x, int y) {
    if (overRect(rectX, rectY)) { // check if mouse is over square
      mouseOver = true;
    }else mouseOver = false;
    
    if (mousePressed && mouseOver) { // if mouse is over the square and is being clicked, rectClicked = true
      rectClicked = true;
    }else rectClicked = false;
  }

  int findXPos () { // find the x pos
    int b = 0;
    if (mousePressed && rectClicked) {
      b = rectX;
    }
    return b;
  }

  int findYPos() { // find the y pos
    int b = 0;
    if (mousePressed && rectClicked) {
      b = rectY;
    }
    return b;
  }

  boolean overRect (int x, int y){  // return true if mouse is over a square
    if (mouseX > x-20 && mouseX <= x+20 && mouseY > y-20 && mouseY <= y+20) { 
      return true;
    }else return false;
  }
}
