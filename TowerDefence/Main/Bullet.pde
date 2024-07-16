class Bullet {
  PVector loc = new PVector(); // vector to stor location
  PVector center;
  PVector tower; // the pos of the tower from which the bullet was shot
  float xDir, yDir;

  Bullet (float x, float y) {
    loc.x = x; // position
    loc.y = y;
    tower = new PVector(loc.x, loc.y); // the starting pos of the bullet
  }

  void run(float x, float y, color colour, int size) {
    xDir = x;
    yDir = y;
    center = new PVector(xDir, yDir);
    PVector velocity = PVector.sub(center, tower); // subtracts tower from center
    loc.add(new PVector(velocity.x/2, velocity.y/2));  // add vectors

    // draw the bullet
    fill(colour);
    circle(loc.x, loc.y, size);
  }
}
