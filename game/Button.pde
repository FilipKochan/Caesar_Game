class Button {
  PVector pos;
  String name;
  int xSize = 150;
  int ySize = 60;

  //---------------------------------------------------------------------------------------

  Button(String name, int x, int y) {
    this.pos = new PVector(x, y);
    this.name = name;
  }

  //---------------------------------------------------------------------------------------

  void show() {
    int textSize = 35;
    push();
    noStroke();
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    translate(this.pos.x, this.pos.y);
    if (this.hovered()) 
      fill(99, 110, 114);
    else
      fill(127, 140, 141, 180);

    rect(0, 0, xSize, ySize, 20);
    if (this.hovered())
      fill(211, 84, 0);
    else
      fill(230, 126, 34);
    textSize(textSize);
    strokeWeight(0);
    text(this.name, 0, - floor(textSize / 20));
    pop();
  }

  //---------------------------------------------------------------------------------------

  boolean hovered() {
    if (mouseY >= this.pos.y - ySize / 2 && mouseY <= this.pos.y + ySize / 2) 
      if (mouseX >= this.pos.x - xSize / 2 && mouseX <= this.pos.x + xSize / 2) 
        return true;

    return false;
  }

  //---------------------------------------------------------------------------------------

  boolean clicked() {
    if (this.hovered())
      if (mousePressed)
        return true;
    return false;
  }
}
