class ChargingBar {
  PVector pos;
  PVector size;
  float shivering = 0;
  float smoothCharging = 0;
  float chargingSpeed = 0.2;
  float charge = 0;

  //---------------------------------------------------------------------------------------

  ChargingBar(int x, int y, int xSize, int ySize) {
    this.pos = new PVector(x, y);
    this.size = new PVector(xSize, ySize);
  }

  //-------------draws the bar--------------------------------------------------------------------------

  // charging color background (220, 221, 225)
  // charging color (230, 126, 34)
  // charged color (0, 255, 0)

  void show() {
    chargeAttack();
    if (smoothCharging < 1)
      charging();
    else
      charged();
  }

  //---------------------------the bar is charging------------------------------------------------------------

  void charging() {
    push();
    noStroke();
    rectMode(CENTER);
    fill(220, 221, 225);
    rect(this.pos.x + this.size.x / 2, this.pos.y + this.size.y / 2, this.size.x, this.size.y, 5);
    fill(230, 126, 34);
    if (smoothCharging < 1)
      rect(this.pos.x + this.size.x / 2, this.pos.y + this.size.y / 2, this.size.x * smoothCharging, this.size.y, 5);
    else
      rect(this.pos.x + this.size.x / 2, this.pos.y + this.size.y / 2, this.size.x, this.size.y, 5);
    pop();

    if (smoothCharging < charge)
      smoothCharging += 0.01;
  }

  //-----------------------------the bar is charged----------------------------------------------------------

  void charged() {
    float rescale = map(sin(shivering), -1, 1, 0.9, 1.1);

    push();
    rectMode(CENTER);
    fill(0, 255, 0);
    noStroke();
    rect(this.pos.x + this.size.x / 2, this.pos.y + this.size.y / 2, this.size.x * rescale, this.size.y * rescale, 5);
    pop();

    if (shivering < TWO_PI)
      shivering += 0.1;
    else
      shivering = 0;
    
    push();
    textSize(18 * rescale);
    textAlign(CENTER);
    text("press SPACE", width - 15 - this.size.x / 2, 95);
    pop();
  }

  //-----------------------charges the bar and allows to make actions when charged---------------------------------------

  void chargeAttack() {
    //println("prevScore: " + prevScore + ", score: " + score + ", charge: " + charge + 
    //", smoothCharging: "+ smoothCharging + ", chargingSpeed: " + chargingSpeed + ", shivering: " + shivering);
    if (charge < 1) {
      if (score > prevScore)
        charge += chargingSpeed;
    } else if (smoothCharging >= 1) {
      if (keyPressed && key == ' ') {
        charge = 0;
        shivering = 0;
        smoothCharging = 0;
      }
    }
  }
}
