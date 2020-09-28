PImage startscreen;



/**
 * Array 2D. 
 * 
 * Demonstrates the syntax for creating a two-dimensional (2D) array.
 * Values in a 2D array are accessed through two index values.  
 * 2D arrays are useful for storing images. In this example, each dot 
 * is colored in relation to its distance from the center of the image. 
 */



import java.util.Random;




Game game = new Game(30, 20, 5, 5);
PFont font;
private boolean gameHasStarted = false;




public void settings() {
  size(1201, 801);
}

void setup()
{
  frameRate(10);
  fill(255,0,255);
  font = loadFont("font.vlw");
  textFont(font, 20);
  minim = new Minim(this);
  song = minim.loadFile("sample.mp3");
  startscreen = loadImage("start.png");
}

void keyReleased()
{
  game.onKeyReleased(key, keyCode);
}

void keyPressed()
{
  fill(255);
  textFont(font,10);
  gameHasStarted = true;
  game.onKeyPressed(key, keyCode);
}

void draw()
{
 
  if (!gameHasStarted)
  {
    image(startscreen, 0, 0);
    startscreen.resize(width,0);
    textAlign(CENTER);
    text("WE SLAV", width / 2, (height / 3));
    text("Press any key to start game", width / 2, height / 2);
    
  } else
  {
     background(0); //Black
    if (!game.getGameIsOver())
    {
      game.update();
    }

    // This embedded loop skips over values in the arrays based on
    // the spacer variable, so there are more values in the array
    // than are drawn here. Change the value of the spacer variable
    // to change the density of the points
    int[][] board = game.getBoard();
    for (int y = 0; y < game.getHeight(); y++)
    {
      for (int x = 0; x < game.getWidth(); x++)
      {
        if (board[x][y] == 0)
        {
          fill(0, 0, 0);
        } else if (board[x][y] == 1)
        {
          fill(0, 0, 255);
        } else if (board[x][y] == 2)
        {
          fill(255, 0, 0);
        } else if (board[x][y] == 3)
        {
          fill(0, 255, 0);
        } else if (board[x][y] == 4)
        {
          fill(255, 0, 255);
        }
        stroke(100, 100, 100);
        rect(x*40, y*40, 40, 40);
      }
    }
    fill(255);
    text("Player 1 Life: "+game.getPlayerLife(), 100, 25);
    text("Player 1 Points: "+game.getPlayerFood(), 100, 40);
    text("Player 2 Life: " +game.getPlayer2Life(), width-150, 25);
    text("Player 2 Points: "+game.getPlayerFood(), width-150, 40);
  }




  if (game.getGameIsOver()) {
    text(game.getWinnerName() + "wins!", width / 2, height / 2);
  }
}

void mousePressed() {
  song.loop();
}
