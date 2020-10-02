PImage startscreen;
PImage img;
PImage img2;
//array of img
PImage[] slav = new PImage[3];
PImage [] police = new PImage[31];
PImage vodka;


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
  img = loadImage( "slav.gif");
  slav[0] = loadImage("slav1.gif");
  slav[1] = loadImage("slav2.gif");
  slav[2] = loadImage("slav3.gif");
  
  img2 = loadImage("police.gif");
  police[0] = loadImage("police1.gif");
  police[1] = loadImage("police2.gif");
  police[2] = loadImage("police3.gif");
  police[3] = loadImage("police4.gif");
  police[4] = loadImage("police5.gif");
  police[5] = loadImage("police6.gif");
  police[6] = loadImage("police7.gif");
  police[7] = loadImage("police8.gif");
  police[8] = loadImage("police9.gif");
  police[9] = loadImage("police10.gif");
  police[10] = loadImage("police11.gif");
  police[11] = loadImage("police12.gif");
  police[12] = loadImage("police13.gif");
  police[13] = loadImage("police14.gif");
  police[14] = loadImage("police15.gif");
  police[15] = loadImage("police16.gif");
  police[16] = loadImage("police17.gif");
  police[17] = loadImage("police18.gif");
  police[18] = loadImage("police19.gif");
  police[19] = loadImage("police20.gif");
  police[20] = loadImage("police21.gif");
  police[21] = loadImage("police22.gif");
  police[22] = loadImage("police23.gif");
  police[23] = loadImage("police24.gif");
  police[24] = loadImage("police25.gif");
  police[25] = loadImage("police26.gif");
  police[26] = loadImage("police27.gif");
  police[27] = loadImage("police28.gif");
  police[28] = loadImage("police29.gif");
  police[29] = loadImage("police30.gif");
  police[30] = loadImage("police31.gif");
  
  vodka = loadImage("vodka.gif");
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
          rect(x*40, y*40, 40, 40);
        } else if (board[x][y] == 1)
        {
          fill(0, 0, 255);
          rect(x*40, y*40, 40, 40);
          image(slav[frameCount%3],x*40,y*40, 40, 40);
        } else if (board[x][y] == 2)
        {
          fill(255, 0, 0);
          rect(x*40, y*40, 40, 40);
          image(police[frameCount%30],x*40,y*40, 40, 40);
        } else if (board[x][y] == 3)
        {
          fill(0, 255, 0);
           rect(x*40, y*40, 40, 40);
          image(vodka,x*40,y*40, 40, 40);
        } else if (board[x][y] == 4)
        {
          fill(255, 0, 255);
          rect(x*40, y*40, 40, 40);
          image(slav[frameCount%3],x*40,y*40, 40, 40);
        }
        stroke(100, 100, 100);
      }
    }
    fill(255);
    text("Player 1 Life: "+game.getPlayerLife(), 100, 25);
    text("Player 1 Points: "+game.getPlayerFood(), 100, 40);
    text("Player 2 Life: " +game.getPlayer2Life(), width-150, 25);
    text("Player 2 Points: "+game.getPlayer2Food(), width-150, 40);
  }




  if (game.getGameIsOver()) {
    image(slav[frameCount%3], width / 2, height / 2);
    text(game.getWinnerName() + " wins! BLYAT OVER!", width / 2, height / 2);
  }
}

void mousePressed() {
  song.loop();
}
