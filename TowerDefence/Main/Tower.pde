class Tower {
  // for futur amke the tower rotate https://forum.processing.org/one/topic/need-help-rotating-an-image-to-face-the-mouse.html
  // initialise variables
  ArrayList bullets; // list of bullets
  PVector location = new PVector();
  float r = 40; // size of square
  float aX = r;
  float aY = r;
  int radius = 100; 
  int Tfr = 0; // cool down timer?
  int inReach = 160; // detection sphere size
  PImage towers;
  PImage towersAnim;
  boolean upgrade; // is the tower upgraded
  float towerX, towerY; // towers pos
  float angle;
  int shootFreq = 6; // shooting frequency
  color bulletColour = color(255, 0, 0);
  int bulletSize = 5;
  

  Tower (float x, float y, boolean upgradable) {
    towerX = x;
    towerY = y;
    location.x = x;
    location.y = y;
    upgrade = upgradable;
    bullets = new ArrayList();
    if (!upgradable) { // if twer is already upgraded
      towers = loadImage("Assets\\fullupgrade.png");
      towersAnim = loadImage("Assets\\fullupgradeFire.png");
      bulletColour = color(0,255, 255); // change colour of bullets for upgraded towers
      bulletSize = 7;
    } 
    else { // unupgraded tower
      towers = loadImage("Assets\\tower.png");
      towersAnim = loadImage("Assets\\towerFire.png");
      
    }
  }
  
  // get X and Y of the current tower
  int getX() {
    return (int)towerX;
  }
  int getY() {
    return (int)towerY;
  }
 

  void showTower() { // draw tower
    for (int i=0; i < circleEnemies.size(); i++) { // loop through all enemies and if one is within range
      if (dist(((Enemies)circleEnemies.get(0)).xpos, ((Enemies)circleEnemies.get(0)).ypos, location.x, location.y) < inReach) { 
        angle = atan2((((Enemies)circleEnemies.get(0)).ypos)-location.y, (((Enemies)circleEnemies.get(0)).xpos)-location.x); // calc angled from twoer to circle
        aX = (r * cos(angle)) + location.x; // get ax and ay from angle to the tower
        aY = (r * sin(angle)) + location.y;
      }
    }
    rotateTower(false); //draw tower not shooting
  }
  
  boolean rotateTower(boolean shooting){
    if (circleEnemies.size() > 0){ //if there are not enemies
      if (dist(((Enemies)circleEnemies.get(0)).xpos, ((Enemies)circleEnemies.get(0)).ypos, location.x, location.y) < inReach) { // if enemies in reach
        pushMatrix();
        // get angle to traget
        float ang = atan2(location.x-(((Enemies)circleEnemies.get(0)).xpos), location.y-(((Enemies)circleEnemies.get(0)).ypos));
        translate(location.x, location.y); // traslate to the towers pos
        rotate(-ang-HALF_PI); // rotate the image by the correct angle
        if(shooting) image(towersAnim, 0, 0, 40, 40); // draw tower shooting animation
        else image(towers, 0, 0, 40, 40); // draw tower
        popMatrix();
      }else image(towers, location.x, location.y, 40, 40); // if none in range
    }else image(towers, location.x, location.y, 40, 40); // if none
    return true;
  }
  
  void shoot() {
    if (wave % 10 == 0) { // every 10 waves // this is why it wasnt shooting the boss bc it does this every 10 waves
      if (EnemiesList.size() > 0) {
        if (dist(((Enemies)EnemiesList.get(0)).xpos, ((Enemies)EnemiesList.get(0)).ypos, location.x, location.y) < inReach) { // if a target is within the detection sphere size
          if (upgrade) { // if the tower is upgradable
            Tfr++; // shooting cool down timer
          }
          Tfr++; // shooting cool down timer
          if (Tfr == shootFreq) {
            bullets.add(new Bullet(location.x, location.y)); // shoot
            Tfr = 0; // reset cool down
          }
        }

        for (int k=0; k<bullets.size(); k++) {
          rotateTower(true); // draw tower shooting
          ((Bullet)bullets.get(k)).run(aX, aY, bulletColour, bulletSize); // move bullet
          pushMatrix();
          translate(location.x, location.y);
          popMatrix();

          // if bullet is close enough to the target determen how much damge to do then call the right functions and delete bullet
          if (dist(((Enemies)EnemiesList.get(0)).xpos, ((Enemies)EnemiesList.get(0)).ypos, ((Bullet)bullets.get(k)).loc.x, ((Bullet)bullets.get(k)).loc.y) < 25) {  
            bullets.remove(k); // remove the bullet
            if ( !upgrade ) { // if tower is upgraded
              ((Enemies)EnemiesList.get(0)).upgradeDamage();
            } 
            else { // if tower is not upgraded
              ((Enemies)EnemiesList.get(0)).damage();
            }
          }
          // if bullet is no longer on the screen remove
          else if (((Bullet)bullets.get(k)).loc.x > width || ((Bullet)bullets.get(k)).loc.x < 0 || ((Bullet)bullets.get(k)).loc.y > height || ((Bullet)bullets.get(k)).loc.y < 0) {
            bullets.remove(k);
          }
        }
      }
    } 
    else { //  if wave is not a boss wave (if wave num is a multiple of 10 = boss wave)
      if (circleEnemies.size() > 0) { // if there are enimes
        if (dist(((Enemies)circleEnemies.get(0)).xpos, ((Enemies)circleEnemies.get(0)).ypos, location.x, location.y) < inReach) {
          if (upgrade) { // if the tower is not upgraded
            Tfr++; // shooting cool down timer
          }
          Tfr++; // shooting cool down timer
          if (Tfr == shootFreq) {
            bullets.add(new Bullet(location.x, location.y));  // shoot 1122wsxr
            Tfr = 0; // reset cool down
          }
        }

        for (int k=0; k<bullets.size(); k++) { // loop through all bullets
          rotateTower(true); // draw tower shooting
          ((Bullet)bullets.get(k)).run(aX, aY, bulletColour, bulletSize); // move bullet

          // if bullet is close enough to the target determen how much damge to do then call the right functions and delete bullet
          if (dist(((Enemies)circleEnemies.get(0)).xpos, ((Enemies)circleEnemies.get(0)).ypos, ((Bullet)bullets.get(k)).loc.x, ((Bullet)bullets.get(k)).loc.y) < 25) {
            bullets.remove(k); // remove bullet
            if ( !upgrade ) { // if tower is upgraded
              ((Enemies)circleEnemies.get(0)).upgradeDamage();
            } 
            else { // if tower is not upgraded
              ((Enemies)circleEnemies.get(0)).damage();
            }
          }
          // if bullet is off the screen remove it 
          else if (((Bullet)bullets.get(k)).loc.x > width || ((Bullet)bullets.get(k)).loc.x < 0 || ((Bullet)bullets.get(k)).loc.y > height || ((Bullet)bullets.get(k)).loc.y < 0) {
            bullets.remove(k);
          }
        }
      }
    }
  }
}
