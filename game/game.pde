PImage bg;
PFont font1, font2, font3, font4;
String[] lines;
Caesar caesar;
Button quit;
Button restart;
ChargingBar chargingBar;
ArrayList<Cross> crosses;
int score = 0;
int prevScore = 0;
int maxScore;
boolean gameOver = false;
PImage cursorArrow, cursorHand;

//---------------------------------------------------------------------------------------

void setup() {
  size(800, 600);
  //fullScreen();
  //----------------------------trying various fonts---------------------------------------
  font1 = loadFont("Herculanum-30.vlw");
  font2 = loadFont("Luminari-Regular-30.vlw");
  font3 = loadFont("MarkerFelt-Thin-30.vlw");
  font4 = loadFont("Papyrus-30.vlw");
  //---------------------------------------------------------------------------------------
  textFont(font1);
  surface.setTitle("Caesar Game");
  bg = loadImage("background.jpg");
  bg.resize(width, height);
  caesar = new Caesar(300, height - 130); 
  quit = new Button("QUIT", width / 2 - 100, height / 2);
  restart = new Button("RESTART", width / 2 + 100, height / 2);
  chargingBar = new ChargingBar(width - 115, 55, 100, 20);
  crosses = new ArrayList<Cross>();
  lines = loadStrings("maxScores.txt");
  if (lines.length == 0)
    lines = new String[] { "0" };
  cursorArrow = loadImage("cursor_arrow.png");
  cursorHand = loadImage("cursor_hand.png");
  cursor(cursorArrow);
  maxScore = int(lines[0]);
}

//---------------------------------------------------------------------------------------

void draw() {
  background(bg);
  prevScore = score;
  if (!gameOver) {
    // ---------------PLAYING
    addCrosses();
    for (int i = crosses.size() - 1; i >= 0; i--) {
      Cross cross = crosses.get(i);
      cross.hitbox();
      cross.checkColision(caesar);
      cross.show();  
      cross.fall();
      score += cross.addScore(i);
    }
    chargingBar.show();

    caesar.update();

    if (caesar.health <= 0)
      gameOver = true;
  } else {
    // ---------------DEAD
    quit.show();
    restart.show();

    if (quit.hovered() || restart.hovered())
      cursor(cursorHand);
    else
      cursor(cursorArrow);

    getMaxScore();

    if (quit.clicked())
      exit();
    else if (restart.clicked()) {
      cursor(cursorArrow);
      score = 0;
      maxScore = int(lines[0]);
      caesar = new Caesar(300, 470);
      chargingBar = new ChargingBar(width - 115, 55, 100, 20);
      crosses = new ArrayList<Cross>();
      gameOver = false;
    }
  }
  writeScore();
}

//---------------------------------------------------------------------------------------

void addCrosses() {
  int frequency = 120 - floor(score / 10);
  if (frequency < 20)
    frequency = 20;

  if (frameCount % frequency == 0)
    crosses.add(new Cross(score));
}

//---------------------------------------------------------------------------------------

void writeScore() {
  if (!gameOver) {
    push();
    textAlign(LEFT);
    textSize(30);
    text("SCORE: " + score, 20, 40);
    textSize(20);
    text("MAXSCORE: " + maxScore, 20, 70);
    pop();
  } else {
    push();
    textAlign(CENTER);
    textSize(40);
    text("SCORE: " + score, width / 2, height / 2 + 80);
    pop();
  }
}

//-------------------------determines whether a new maxscore was achieved and shows a message-----------------------------------------

void getMaxScore() {
  if (score > maxScore) {
    lines[0] = str(score);
    saveStrings("maxScores.txt", lines);
    push();
    textAlign(CENTER);
    textSize(25);
    text("(NEW MAXSCORE)", width / 2, height / 2 + 110);
    pop();
  }
}
