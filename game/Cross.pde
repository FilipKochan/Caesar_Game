class Cross {
  PVector pos;
  int speed;
  float res = .8;
  PImage crs = loadImage("cross.png");
  PVector[][] hitboxes;

  //---------------------------------------------------------------------------------------

  Cross(int score) {
    this.pos = new PVector(floor(random(width - 181 * res)), floor(random(-150, -100)));
    crs.resize(floor(181 * res), floor(200 * res));
    this.speed = 5 + floor(score / 50);
  }

  //-----------------------shows cross----------------------------------------------------------------

  void show() {
    image(crs, this.pos.x, this.pos.y);
  }

  //-----------------------cross falls----------------------------------------------------------------

  void fall() {
    this.pos.y += speed;
    //println(speed);
  }

  //-----------------------creates hitboxes for each cross----------------------------------------------------------------

  void hitbox() {
    this.hitboxes = new PVector[][]{
      {new PVector(this.pos.x + 50 * res, this.pos.y), new PVector(70 * res, 90 * res)}, 
      {new PVector(this.pos.x, this.pos.y + 50 * res), new PVector(50 * res, 75 * res)}, 
      {new PVector(this.pos.x + 45 * res, this.pos.y + 90 * res), new PVector(85 * res, 110 * res)}, 
      {new PVector(this.pos.x + 120 * res, this.pos.y + 25 * res), new PVector(60 * res, 65 * res)}
    };

    //push();
    //noFill();
    //stroke(255, 0, 0);
    //strokeWeight(2);
    //for (int i = 0; i < 4; i++)
    //  rect(this.hitboxes[i][0].x, this.hitboxes[i][0].y, this.hitboxes[i][1].x, this.hitboxes[i][1].y);
    //pop();
  }

  //-----------------------removes crosses from list when out of screen and increases score----------------------------------

  int addScore(int i) {
    if (this.pos.y > height) {
      crosses.remove(i);
      //println("removed");
      return 10;
    } else {
      return 0;
    }
  }

  //------------------------chcecks if cross hit caesar---------------------------------------------------------------

  void checkColision(Caesar caesar) {
    for (int i = 0; i < 4; i++) {
      if (caesar.pos.y < this.hitboxes[i][0].y + this.hitboxes[i][1].y &&
        caesar.pos.y + caesar.hitbox.y > this.hitboxes[i][0].y) {
        if (caesar.pos.x < this.hitboxes[i][0].x + this.hitboxes[i][1].x &&
          caesar.pos.x + caesar.hitbox.x > this.hitboxes[i][0].x) {
          if (caesar.health > 0)
            caesar.health -= 1.5;
        }
      }
    }
  }
}
