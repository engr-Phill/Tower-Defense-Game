class Enemies {
  // setup variables
  int xpos = -1;  // spawn pos
  int ypos = 60;
  int enemiesHp;   // health
  String type;
  PImage enemieImage;
  boolean xRightLine = true;  // boolean to for movement through the track  
  boolean xLeftLine = true;  // boolean to for movement through the track  
  
  
  
  Enemies (int hp, String variety) {
    type = variety;
    if (wave % 10 == 0) {
      enemieImage = loadImage("Assets\\boss.png"); // boss
      enemiesHp = hp; // normal boss hp
    }else if (type == "harder"){
      enemieImage = loadImage("Assets\\harderEnemie.png"); // harder enemie
      enemiesHp = hp*int(random(1.1, 3)); // random HP but harder than normal
    }else {
      enemieImage = loadImage("Assets\\enemie.png"); // normal enemie
      enemiesHp = hp; // normal hp
    }
  }

  void damage() { // method to damage the enemie from a normal tower
    enemiesHp -= 10;
  }

  void upgradeDamage() { // method to damage the enemie from a upgraded tower
    enemiesHp -= 30;
  }
  
  
  void circleMovement() { // method to move enemies through the map
    
    if (xpos < 580 && xRightLine) { // go right  
      xpos += speed;
    }
    else if (ypos < 140) { // go down 
      ypos += speed;
      xRightLine = false; // end of irst right and down segment
    }
    else if (xpos > 60 && xLeftLine) { // first left lane
      xpos -= speed;
    }
    else if (ypos < 220 && ypos >= 140) { // go down 
      ypos += speed; //  if you turn up the speed it will fail bc it misses this if so never goes right agian maybe use a >218 instead to solve this
      if (ypos >= 218 && ypos <= 218+speed) { 
        xRightLine = true;
        xLeftLine = false;
      }
    }
    // final left
    else if (ypos < 300 && ypos >= 220) { // go down // end of second line so dont do line 1 again
      ypos += speed;
      if (ypos >= 298 && ypos <= 298+speed) { //  if you turn up the spped it will fail bc it misses this if so never goes right agian
        xRightLine = false;
        xLeftLine = true;
      }
    }
    else if (xpos > 60 && xLeftLine) { // second left left lane
      xpos -= speed;
    }
   else if (ypos < 380 && ypos >= 300) { // go down // end of second line so dont do line 1 again
      xLeftLine = false;
      ypos += speed;
      if (ypos >= 374 && ypos == 374+speed) { //  if you turn up the spped it will fail bc it misses this if so never goes right agian
        xRightLine = false;
        xLeftLine = true;
      }
    }
   else
      xpos += speed;
    
    // draw enemie
    pushMatrix();
    translate(xpos, ypos);
    image(enemieImage, 0, 0, 40, 25);
    popMatrix();

    if (enemiesHp < 0) { // if enemie has been killed remove and add money
      if (wave % 10 == 0) {
        EnemiesList.remove(this);
        money += 200;
        score = score + 20;
      } 
      else {
        circleEnemies.remove(this);
        if(type == "harder"){
          money += 70;
          score = score + 15;
        }else{
          money += 50; 
          score = score + 10;
        }
      }
    }
    
    
    if (xpos > 663) { // if enemie has made it to the end remove it and remove players lives
      if (wave % 10 == 0) {
        EnemiesList.remove(this);
        lives -= 2;
      }else {
        lives -= 1;
        circleEnemies.remove(this);
      }
    }
  }
}
