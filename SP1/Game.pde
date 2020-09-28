import java.util.Random;

class Game
{
  private Random rnd;
  private final int width;
  private final int height;
  private int[][] board;
  private Keys keys;
  private int playerLife;
  private int player2Life;
  private int playerFood;
  private int player2Food;
  private Dot player;
  private Dot player2;
  private Dot[] enemies;
  private Dot[] food;
  private boolean gameIsOver = false;
  private int foodLimit = 20;
  private String winnerName;


  Game(int width, int height, int numberOfEnemies, int numberOfFood)
  {
    if (width < 10 || height < 10)
    {
      throw new IllegalArgumentException("Width and height must be at least 10");
    }
    if (numberOfEnemies < 0)
    {
      throw new IllegalArgumentException("Number of enemies must be positive");
    } 
    this.rnd = new Random();
    this.board = new int[width][height];
    this.width = width;
    this.height = height;
    keys = new Keys();
    player = new Dot(0, 0, width-1, height-1);
    player2 = new Dot(0, 10, width-1, height-1);
    enemies = new Dot[numberOfEnemies];
    food = new Dot[numberOfFood];

    for (int i = 0; i < numberOfFood; ++i)
    {
      //random int and random food spawn
      int startX = int(random(width-1));
      int startY = int(random(height-1));
      food[i] = new Dot(startX, startY, width-1, height-1);
    }

    this.playerFood = 0;
    this.player2Food = 0;



    for (int i = 0; i < numberOfEnemies; ++i)
    {
      enemies[i] = new Dot(width-1, height-1, width-1, height-1);
    }
    this.playerLife = 100;
    this.player2Life= 100;
  }

  public int getWidth()
  {
    return width;
  }

  public int getHeight()
  {
    return height;
  }

  public int getPlayerLife()
  {
    return playerLife;
  }
  public int getPlayer2Life()
  {
    return player2Life;
  }


  public int getPlayerFood()

  {
    return playerFood;
  }
  public int getPlayer2Food()

  {
    return player2Food;
  }
  
  public String getWinnerName()
  {
     return winnerName; 
  }
  
  public boolean getGameIsOver(){
   return gameIsOver; 
  }

  public void onKeyPressed(char ch, int code)
  {
    keys.onKeyPressed(ch, code);
  }

  public void onKeyReleased(char ch, int code)
  {
    keys.onKeyReleased(ch, code);
  }

  public void update()
  {
    if (!gameIsOver) {
      updatePlayer();
      updatePlayer2();
      updateEnemies();
      updateFood();
      checkForCollisions();
      clearBoard();
      populateBoard();
    } else { // Game is over
      clearBoard();
    }
  }



  public int[][] getBoard()
  {
    //ToDo: Defensive copy?
    return board;
  }

  private void clearBoard()
  {
    for (int y = 0; y < height; ++y)
    {
      for (int x = 0; x < width; ++x)
      {
        board[x][y]=0;
      }
    }
  }

  private void updatePlayer()
  {
    //Update player
    if (keys.wDown() && !keys.sDown())
    {
      player.moveUp();
    }
    if (keys.aDown() && !keys.dDown())
    {
      player.moveLeft();
    }
    if (keys.sDown() && !keys.wDown())
    {
      player.moveDown();
    }
    if (keys.dDown() && !keys.aDown())
    {
      player.moveRight();
    }
  }

  private void updatePlayer2()
  {
    //Update player
    if (keys.upDown() && !keys.downDown())
    {
      player2.moveUp();
    }
    if (keys.leftDown() && !keys.rightDown())
    {
      player2.moveLeft();
    }
    if (keys.downDown() && !keys.upDown())
    {
      player2.moveDown();
    }
    if (keys.rightDown() && !keys.leftDown())
    {
      player2.moveRight();
    }
  }


  private void updateEnemies()
  {
    for (int i = 0; i < enemies.length; ++i)
    {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..
      if (rnd.nextInt(3) < 2)
      {
        //distance to player 1
        int dx = player.getX() - enemies[i].getX();
        int dy = player.getY() - enemies[i].getY();
        //distance to player 2
        int px = player2.getX()- enemies[i].getX();
        int py = player2.getY() - enemies[i].getY();
        //if player 1 is closer
        if ((dx+dy)<(px+py))
        {
          if (abs(dx) > abs(dy))
          {
            if (dx > 0)
            {
              //Player is to the right
              enemies[i].moveRight();
            } else
            {
              //Player is to the left
              enemies[i].moveLeft();
            }
          } else if (dy > 0)
          {
            //Player is down;
            enemies[i].moveDown();
          } else
          {//Player is up;
            enemies[i].moveUp();
          }
        } else //else if player 2 is closest
        {  
          if (abs(px) > abs(py))
          {
            if (px > 0)
            {
              //Player2 is to the right
              enemies[i].moveRight();
            } else
            {
              //Player2 is to the left
              enemies[i].moveLeft();
            }
          } else if (py > 0)
          {
            //Player2 is down;
            enemies[i].moveDown();
          } else
          {//Player2 is up;
            enemies[i].moveUp();
          }
        }
      } else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
          enemies[i].moveRight();
        } else if (move == 1)
        {
          //Move left
          enemies[i].moveLeft();
        } else if (move == 2)
        {
          //Move up
          enemies[i].moveUp();
        } else if (move == 3)
        {
          //Move down
          enemies[i].moveDown();
        }
      }
    }
  }

  private void populateBoard()
  {
    //Insert player
    board[player.getX()][player.getY()] = 1;
    //Insert player 2
    board[player2.getX()][player2.getY()] = 4;
    //Insert enemies
    for (int i = 0; i < enemies.length; ++i)
    {
      board[enemies[i].getX()][enemies[i].getY()] = 2;
    }
    for (int i = 0; i < food.length; ++i)
    {
      board[food[i].getX()][food[i].getY()] = 3;
    }
  }

  private void checkForCollisions()
  {
    //Check enemy collisions
    for (int i = 0; i < enemies.length; ++i)
    {
      if (enemies[i].getX() == player.getX() && enemies[i].getY() == player.getY())
      {
        //We have a collision
        // Reduce playerLife by 1, and check if it is equals to 0
        if (--playerLife == 0) {
          gameIsOver = true;
          winnerName = "Player 2";
        }
      }
      if (enemies[i].getX() == player2.getX() && enemies[i].getY() == player2.getY())
      {
        //We have a Collision player 2

        // Reduce playerLife by 1, and check if it is equals to 0
        if (--player2Life == 0) {
          gameIsOver = true;
          winnerName = "Player 1";
        }
      }
    }

    //check food collisions
    for (int i = 0; i < food.length; ++i)
    {
      if (food[i].getX() == player.getX() && food[i].getY() == player.getY())
      {
        //We have a collision

        //Increase playerFood by 1 and see if we hit the score limit
        if (++playerFood == foodLimit) {
          gameIsOver = true;
          winnerName = "Player 1";
        }

        food[i].setRandomPosition();
      }
      if (food[i].getX() == player2.getX() && food[i].getY() == player2.getY())
      {
        //We have a collision player2

        //Increase player2Food by 1 and see if we hit the score limit
        if (++player2Food == foodLimit) {
          gameIsOver = true;
          winnerName = "Player 2";
        }
        food[i].setRandomPosition();
      }
    }
  }



  private void updateFood()
  {
    for (int i = 0; i < food.length; ++i)
    {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..
      if (rnd.nextInt(3) < 2)
      {
        //We follow
        int dx = food[i].getX() - player.getX();
        int dy = food[i].getY() - player.getY();
        if (abs(dx) > abs(dy))
        {
          if (dx > 0)
          {
            //Player is to the right
            food[i].moveRight();
          } else
          {
            //Player is to the left
            food[i].moveLeft();
          }
        } else if (dy > 0)
        {
          //Player is down;
          food[i].moveDown();
        } else
        {//Player is up;
          food[i].moveUp();
        }
      } else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
          enemies[i].moveRight();
        } else if (move == 1)
        {
          //Move left
          enemies[i].moveLeft();
        } else if (move == 2)
        {
          //Move up
          food[i].moveUp();
        } else if (move == 3)
        {
          //Move down
          food[i].moveDown();
        }
      }
    }
  }
}
