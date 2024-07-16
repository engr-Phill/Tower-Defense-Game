// Tower Defence by Phillip Sparrow 11/10/22
// import classes
Tower Tower;
Bullet Bullet;
Enemies Enemies;
Square Square;

// declear images
PImage backgroundImage;  // background image
PImage backgroundImageBlur; // blurr menu image

// Array lists to store the towers and enemies
ArrayList towers = new ArrayList();
ArrayList circleEnemies = new ArrayList();
ArrayList EnemiesList = new ArrayList();

// setup variables
int spawnTime = 0; // number of total waves with bosses?
int SquareTimer = 0;
int money = 750;    // starting money value
int lives = 10;     // number of lives
int enemies = 4;    // starting num of enemies
int boss = 1;       // number if bosses to spawn in frist boss wave
int copyBoss = boss;       // make a copy of boss 
int copyMonster = enemies; // make a copy of enemies
int enemiesHealth = 320;   // normal enemies health
int bossHealth = 5000;     // bosses health
int wave = 1;              // starting wave value
boolean menuScreen = true; // if true, currently showing menu screen game, game should not run or take input
int speed = 2;             // movement speed
int chance = 2;            // chance of a blue enemie spawning
int score = 0;             // players score, to be displaed when game is lost

// set up number of coloumns and rows
int cols = 16;
int rows = 12;
int squarePlacement [][] = new int[cols][rows]; 
int findMouseXPos, findMouseYPos; // vars for storing the x and y mouse values
Square[] b = new Square[cols*rows];  // initialise list of background squares

boolean play = false;   // is game running
boolean end = false;    // has game ended
boolean sameTowerPlacement = false;   // is there a tower on this square
boolean allMonstersSpawned = false;   // have all the enemies from this wave spawned

void setup () {
  // setup images for background
  backgroundImageBlur = loadImage("Assets\\blurrBG.png");
  backgroundImage = loadImage("Assets\\testbg2.PNG");
  size(640, 480);    // size of window
  rectMode(CENTER);   
  imageMode(CENTER);
  textAlign(CENTER);
  smooth();
  frameRate(20);
  
  for (int h = 0; h < cols*rows; h++) { // make grid
    b[h] = new Square();
  }
  int counter = 0; 
  for (int v = 0; v < rows; v++) {   // for rows and coloumns assing each square a number
    for (int w = 0; w < cols; w++) {
      squarePlacement[w][v] = counter;
      counter++;
    }
  }
}// end of setup 

// return the xpos at of a square at an xy 
int xLocation (int x, int y) {
  int xposition = 0;
  int SquareChoice = squarePlacement[x][y];
  xposition = b[SquareChoice].rectX;
  return xposition;
}

// return the ypos at of a square at an xy 
int yLocation (int x, int y) {
  int yposition = 0;
  int SquareChoice = squarePlacement[x][y];
  yposition = b[SquareChoice].rectY;
  return yposition;
}


void draw () {
  if(menuScreen){ // run menu screen
    image(backgroundImageBlur, 319, 239, 640, 480); // draw menu background
    // select easy or hard mode (defult is easy)
    if (keyPressed == true){
      if (key == 49) { // key value ("1")
        menuScreen = false;
      }
      else if (key == 50) { // key value ("2")
        hardMode();
        menuScreen = false;
      }
    }
  }
  else{ // run game main
    findMouseXPos = int(map(mouseX, 0, 640, 0, 16)); // converts the x pos to which coloum (x coord)
    findMouseYPos = int(map(mouseY, 0, 480, 0, 12)); // converts the x pos to which row (y coord)
  
    SquareTimer++; // count for starting the game
    // draw background
    pushMatrix();
    image(backgroundImage, 319, 241, 645, 490);
    popMatrix();
    
    // draw button backgrounds
    fill(100);
    rect(100, 460, 120, 40); // how many lives
    rect(220, 460, 120, 40); // what wave
    rect(340, 460, 120, 40); // how much money
    rect(540, 460, 120, 40); // start Square
  
    // draw button text
    fill(255);
    text("START WAVE!", 540, 465);
    fill(255);
    text("Lives:" + " " + nf(lives, 2), 100, 465);
    fill(255);
    text("Wave:" + " " + nf(wave, 2), 220, 465);
    fill(255);
    text("Money:" + " " + nf(money, 2), 340, 465);
  
    int SquareNumber = 0;   // counter 
    for (int i = 0; i < 12; i++) {
      for (int j = 0; j < 16; j++) {
        b[SquareNumber].showSquare((20+(j*40)), (20+(i*40)));   // highlight square
        SquareNumber++;
      }
    }
    
    if (play) { // main loop if true run game
      
      if (wave % 10 == 0) { // if its a boss wave
        spawnTime++;
        if (spawnTime == 20) { // spawn rate
          if ( copyBoss == 0) {
              spawnTime = 21;
            }
            else{
              EnemiesList.add(new Enemies(bossHealth, "Boss")); // add/spawn boss
              copyBoss--;
              spawnTime = 0;
            }
        }
        for (int j = 0; j < EnemiesList.size(); j++) { // loop through EnemiesList
          if (EnemiesList.size() > 0) {
            ((Enemies)EnemiesList.get(j)).circleMovement(); // if there are still enemies alive move them
          }
        }
  
        if (EnemiesList.size() == 0) { //all monsters gone, new wave starts
          if (spawnTime >= 26) {
            spawnTime = 0;
            bossHealth += 500;
            boss += 1;
            wave += 1;
            play = false;
            copyBoss = boss;
          }
        }
      } 
      else {
        spawnTime++;
        if (spawnTime == 25) { // spawn rate
          if ( copyMonster == 0) {
            spawnTime = 26;
          } 
          else {
            if (random(10) <= chance){
              circleEnemies.add(new Enemies(enemiesHealth, "harder"));
            }else circleEnemies.add(new Enemies(enemiesHealth, "normal"));
            copyMonster--;
            spawnTime = 0;
          }
        }
  
        for (int j = 0; j < circleEnemies.size(); j++) { // loop through circleEnemies list
          if (circleEnemies.size() > 0)
            ((Enemies)circleEnemies.get(j)).circleMovement(); //  if there is still circleEnemies then move them 
        } 
        if (circleEnemies.size() == 0) { //all monsters gone, new wave starts
          if (spawnTime >= 26) {
            spawnTime = 0;
            enemiesHealth += 50;
            enemies += 2;
            wave += 1;
            play = false;
            copyMonster = enemies;
          }
        }
      }
    }
     // set text size
    fill(255);
    textSize(20);
    text("Score: " + score, 50, 20); // print score top right
    textSize(15);
    text("Press r to restart", 545, 15);
    textSize(15);
    if (lives <= 0) { // game over
      play = false;
      end = true;
    }
    for (int i=0; i<towers.size(); i++) { // for all towers show them 
      ((Tower)towers.get(i)).showTower();  // draw 
      ((Tower)towers.get(i)).shoot();      // shoot if applicable
    }
  
    if (end) { // if game has been lost 
      // clear screen of towers and enemies
      for (int z = 0; z < towers.size(); z++) towers.remove(z);
      for (int z = 0; z < circleEnemies.size(); z++) circleEnemies.remove(z);
      for (int z = 0; z < EnemiesList.size(); z++) EnemiesList.remove(z);
      lose(); // call the lose function
    }
  }
}


void mousePressed() {
  if (!play && !menuScreen) { // start the game if the start button is clicked 
    if ((mouseX >= 480 && mouseX <= 600) && (mouseY >= 440 && mouseY <= 480)) {
      if (SquareTimer > 1) play = true;
    }
  }
  if (!end && !menuScreen) { // if game is not over
  // check if square is not part of the track
    if (findMouseYPos < 11 && // bottom line
      !(findMouseYPos == 1 && findMouseXPos < 15) &&  // top horizontal track line
      !(findMouseXPos == 14 && (findMouseYPos >= 1 && findMouseYPos <= 3 || findMouseYPos >= 5 && findMouseYPos <= 7)) &&  // the down bits on the right connecting horizontal track lines 
      !(findMouseXPos == 1 && (findMouseYPos >= 3 && findMouseYPos <= 5 || findMouseYPos >= 7 && findMouseYPos <= 9)) && // the down bits on the left
      !(findMouseYPos == 3 && findMouseXPos < 15 && findMouseXPos >= 1) && // second horizontal track line
      !(findMouseYPos == 5 && findMouseXPos < 15 && findMouseXPos > 1) && // third horizontal track line
      !(findMouseYPos == 7 && findMouseXPos < 15 && findMouseXPos > 1) && // forth horizontal track line
      !(findMouseYPos == 9 && findMouseXPos <= 15 && findMouseXPos > 1)){  // fifth horizontal track line 
        
      sameTowerPlacement = false; // reset boolean before going through for loop of towers
      for (int x = 0; x < towers.size(); x++) {
        // if there is a tower on this square already then upgrade
         if ( xLocation(findMouseXPos, findMouseYPos) == ((Tower)towers.get(x)).getX() && yLocation(findMouseXPos, findMouseYPos) == ((Tower)towers.get(x)).getY()) {
           sameTowerPlacement = true; // there was a tower on the square but not enough money to upgrade
           if (((Tower)towers.get(x)).upgrade && money >= 500 && sameTowerPlacement) { // check for money to upgraded tower
              towers.add(new Tower(((Tower)towers.get(x)).getX(), ((Tower)towers.get(x)).getY(), false)); // add upgraded tower
              towers.remove((Tower)towers.get(x)); // add upgraded tower
              money -= 500; // deduct money
           }
         }
      }
      if (money >= 250 && !sameTowerPlacement) {  // if there is no tower there and you have enough money then add new tower
       towers.add(new Tower(xLocation(findMouseXPos, findMouseYPos), yLocation(findMouseXPos, findMouseYPos), true)); // add new tower
       money -= 250; // deduct money
      }
    }
  }
}


void hardMode(){ // set variables to increase diffculty of the game
  speed = 5;
  enemiesHealth = 400;
  money = 1000;
  lives = 5; 
  chance = 2;
}

void keyPressed(){
  if (key == 114) { // key value ("r")
        EnemiesList.clear();
        towers.clear();
        circleEnemies.clear();
        reset();
        setup();
      }
}

void lose() {  // method to draw the loss screen 
  background(0); // reset background
  fill(255);
  textSize(20);
  text("GAME OVER\n Your score is: " + score + "\nYou survied " + wave + " waves\nPress R to restart", 320, 200); // print game over message   
}

void reset(){  // reset variables for next game
  wave = 1;
  speed = 2;
  enemiesHealth = 320;
  money = 750;
  lives = 10; 
  chance = 1;
  menuScreen = true;
  score = 0;
  play = false;   // is game running
  end = false;    // has game ended
  enemies = 4;
  spawnTime= 0;
  SquareTimer = 0;
  copyMonster = enemies;
}
