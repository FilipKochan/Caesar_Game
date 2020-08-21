class Caesar {
  PVector pos;
  float res = 0.15;
  PImage caesarImage = loadImage("caesar.png");
  int speed = 5;
  PVector hitbox = new PVector(floor(340 * res), floor(710 * res));
  float health = 100;

  //---------------------------------------------------------------------------------------

  Caesar(int x, int y) {
    this.pos = new PVector(x, y);
    caesarImage.resize(floor(500 * res), floor(710 * res));
  }

  //-------------------updates the caesar--------------------------------------------------------------------

  void update() {
    //this.hitbox();
    this.show();
    this.healthBar();
    this.move();
    this.heal();
  }

  //---------------------------------------------------------------------------------------

  void show() {
    image(caesarImage, this.pos.x - 60 * res, this.pos.y);
  }

  //---------------------------------------------------------------------------------------

  void move() {
    if (keyPressed) {
      if (this.pos.x> 0 && (key == 'a' || keyCode == LEFT)) {
        this.pos.x -= speed;
        //print("pressed a or arrow");
      } else if (this.pos.x + this.hitbox.x + speed < width && (key == 'd' || keyCode == RIGHT)) {
        this.pos.x += speed;
      }
    }
  }

  //--------------------------draws the hitbox-------------------------------------------------------------

  void hitbox() {
    push();
    noFill();
    stroke(255, 0, 0);
    strokeWeight(2);
    rect(this.pos.x, this.pos.y, hitbox.x, hitbox.y);
    pop();
  }

  //---------------------------manages caesar's health------------------------------------------------------------

  void healthBar() {
    push();
    noStroke();
    fill(255, 0, 0);
    rect(width - 115, 15, 100, 20, 5);

    fill(0, 255, 0);
    if (health > 0)
      rect(width - 115, 15, floor(health), 20, 5);
    pop();
  }

  //---------------------------healing------------------------------------------------------------

  void heal() {
    float increment = 0.08;
    if (this.health < 10)
      this.health += increment / 4;
    else if (this.health < 25)
      this.health += increment;
    else if (this.health < 50)
      this.health += increment / 2;
    else if (this.health < 75)
      this.health += increment / 4;
    else if (this.health < 100)
      this.health += increment / 8;
  }

  //---------------------------------------------------------------------------------------
}
