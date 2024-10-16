/*
(NL) Hallo. Dit is een moelijke versie van Breakout, gemaakt in processing.
 In dit speel raak je blockjes met een ball, en als je alle blockjes heb geraakt. ..krijg jij gewoon een victory screen!
 Maar om dit spel meer leuker te maken! Heb ik geprogrammerd dat je elke tijd de boarders raakt of je Ball dood gaat, Gaat je Ball sneller.
 ..Ja deze repo blijft Opensource. Geen updates na productie. Geen refunds. Have Fun!
 (Informatie van deze code wordt alleen maar in Nederlands geschreven.)
 
 (ENG) Hi. This is a more difficult version of Breakout. Made in processing.
 In this game you.. Why am I explaining what Breakout is, you all probably played it by now.
 There is a catch tho! if you hit the collision boxes and or your ball dies, your ball speed increases.
 ..Yes this repo will stay Opensource. No updates after production. No refunds. Viel Spaß!
 (Information from these scripts will only be in Dutch, just use google translate, DeepL, ChatGPT or whatever :P
 
 (DE) Hallo Leu- jk, Viel Spaß google translate zu benutzen.
 
 - TGSR
 */



//data types voor het spel

int widthD = 600;
int HeightD= 800;
int leven= 3;
int Punten= 0;
String Msg;
String BreakOut = "Breakout Hard Edition ver 0.1.4 - TGSR Inc";

float brickX=0;
int SBB= 5;
int NumOfBricks= 20;
int NumOfRows= 10;
int SpaceCeiling= 50;
float WidthOfBrick= (widthD-(NumOfBricks-2)*SBB)/NumOfBricks;
float HeightOfBrick= 10;
color ColorBricks[]= {color(random(255), random(255), random(255)), color(random(255), random(255), random(255)), color(random(255), random(255), random(255)), color(random(255), random(255), random(255)), color(random(255), random(255), random(255)), color(random(255), random(255), random(255)), color(random(255), random(255), random(255)), color(random(255), random(255), random(255)), color(0), color(random(255), random(255), random(255))};
color ColorBrick= color(255, 255, 0);
ArrayList<Block> BasketOfBricks= new ArrayList<Block>();

int ballWidth= 16;
float ballstartX= random(widthD);
float ballstartY= HeightD/2;
color ballColor= color(random(255), random(255), random(255));
boolean Lost= false;
boolean Won= false;
Ball Moe = new Ball(ballstartX, ballstartY, ballWidth, ballColor);


int movingboardX= widthD/2;
int movingboardY= HeightD-50;
int movingboardWidth= 20;
int movingboardHeight= 70;
color movingboardColor= color(random(255), random(255), random(255));
Block movingboard= new Block(movingboardX, movingboardY, movingboardHeight, movingboardWidth, movingboardColor);

//setup functies om de title, scherm size, achtergrond, game over screen en bricks op het scherm te zetten

void setup() {
  windowTitle(BreakOut);
  size(600, 800);
  setupBricks();
}

//draw functie voor de drawen van het background kleur, bricks, de Lost en Won screen, de ball, score en leven text

void draw() {
  background(255);
  drawbricks();
  if (!Lost&&!Won) drawBall();
  drawMB();
  updateScore(false);
  drawLevenText();
  if (leven== 0) drawLose();
}

//Functie die met de "BasketOfBricks" Arraylist rijen van blockjes maakt met verschillende kleuren bij elke rij.
void setupBricks() {
  for (int rowNum=0; rowNum<NumOfRows; rowNum++) {
    for (int brickNum=0; brickNum<NumOfBricks; brickNum++) {
      color ColorBricksy=ColorBricks[rowNum];
      float brickY= SpaceCeiling+(HeightOfBrick+SBB)*rowNum;
      brickX=(WidthOfBrick+SBB)*brickNum;
      BasketOfBricks.add(new Block(brickX, brickY, WidthOfBrick, HeightOfBrick, ColorBricksy));
    }
  }
}

//Deze functie draws de blockjes, en detecteerd de ball om daarna weg te gaan als het geraakt is.
void drawbricks() {
  for (int brickNum= BasketOfBricks.size()-1; brickNum>= 0; brickNum--) {
    Block brick= BasketOfBricks.get(brickNum);
    brick.draw();
    if (brick.collidesWith(Moe)) {
      BasketOfBricks.remove(brick);
      updateScore(true);
    }
  }
}

//Drawing voor de ball
void drawBall() {
  Moe.draw();
  Moe.update();
  if (Moe.checkWallCollision()) {
    leven--;
    Moe.move(width/2, height/2);
  }
}
//draw van het MB (Moving Board. Aka de balk die je beweegt met je muis.) Was gescript dat het ook de Ball raakt.
void drawMB() {
  movingboard.draw();
  movingboard.blockX=mouseX;
  movingboard.collidesWith(Moe);
}

//Text voor de win en lose screen.

void displayText(String message, int x, int y, boolean isCentered) {
  fill(0);
  textSize(32);
  String name= message;
  float textX= x;
  if (isCentered) {
    float widthText= textWidth(name);
    textX= (width-widthText)/2;
  }
  int textY= y;
  text(name, textX, textY);
}

void drawLose() {
  String message= "tgsr.nl (You lost)";
  displayText(message, 0, height/2, true);
  Lost= true;
}

//Text voor de Score en die update wanneer die een blockje raakt.
void updateScore(boolean isNew) {
  if (isNew) Punten+=10;
  Msg="Score: "+Punten;
  displayText(Msg, 0, height-2, false);
  if (Punten==NumOfBricks*NumOfRows*10) {
    displayText("Jij heb gewonnen", 0, height/2, true);
    Won = true;
  }
}

//Checked als de ball de bodem raakt of niet.
void checkLeven() {
  if (Moe.ballY+Moe.ballWidth==height) {
    leven--;
  }
  drawLevenText();
}
//Text voor je leven
void drawLevenText() {
  String message;
  message="Lives: " + leven;
  displayText(message, ((int)(width-textWidth(message))), height-2, false);
}

//class voor de ball Moe.
class Ball {
  float ballX;
  float ballY;
  float ballWidth;
  color ballColor;
  float speedY= 4.5;
  float speedX= 4.5;

  Ball(float x, float y, int Width, color Color) {
    ballX= x;
    ballY= y;
    ballWidth= Width;
    ballColor= Color;
  }
  //data types voor de ball.
  void draw() {
    noStroke();
    fill(ballColor);
    ellipse(ballX, ballY, ballWidth, ballWidth);
  }
  //Hoe de ball uit gaat zien
  void update() {
    ballX+=speedX;
    ballY+=speedY;
  }
  //Om de speed de updaten
  void move(int X, int Y) {
    ballX= X;
    ballY= Y;
    speedY= 6;
    speedX= 6;
  }
  //Dit is voor de speed als je dood gaat. default speed is 4.5.
  boolean checkWallCollision() {
    if (ballX>width-ballWidth/2) {
      speedX=-abs(speedX+1);
    } else if (ballX<ballWidth/2) {
      speedX=abs(speedX);
    }
    if (ballY>height-ballWidth/2) {
      speedY=-abs(speedY+1);
      return true;
    } else if (ballY<ballWidth/2) {
      speedY= abs(speedY);
    }
    return false;
  }
}
//Deze is voor de wall collision detection. Waar +1 is waar de ball sneller wordt wanneer je de Wall raakt.

class Block {
  float blockX;
  float blockY;
  float blockWidth;
  float blockHeight;
  color blockColor;
  int maxHits=1;
  int hits=maxHits;

  Block(float x, float y, float Width, float Height, color Color) {
    blockX= x;
    blockY= y;
    blockWidth= Width;
    blockHeight= Height;
    blockColor= Color;
  }
  //Zelfde gedoe met de ball class, maar voor het Block die alleen maar Block heet.
  void draw() {
    noStroke();
    fill(blockColor);
    rect(blockX, blockY, blockWidth, blockHeight);
  }
  //hoe het getekent wordt
  void move(int X, int Y) {
    blockX=X-blockWidth/2;
    blockY=Y-blockHeight/2;

    if (blockX+blockWidth>width) {
      blockX=width-blockWidth;
    } else if (blockX<0) {
      blockX= 0;
    }
    if (blockY+blockHeight>height) {
      blockY=height-blockWidth;
    } else if (blockY<0) {
      blockY=0;
    }
  }
//Block Width en height


  void setMaxHits(int numberOfHits) {
    maxHits=numberOfHits;
    hits= maxHits;
  }
  int getHits() {
    return hits;
  }
//de keren hoeveel de blockjes kunnen geraakt worden.
  boolean collidesWith(Ball b) {
    if ((b.ballX+b.ballWidth/4>blockX && b.ballX-b.ballWidth/4<blockX+blockWidth)
      && (b.ballY-b.ballWidth/2<(blockY+blockHeight) && b.ballY-b.ballWidth/2>blockY)) {
      b.speedY= abs(b.speedY);
      hits--;
      return true;
    }

    if ((b.ballX+b.ballWidth/4>blockX && b.ballX-b.ballWidth/4<blockX+blockWidth)
      && (b.ballY+b.ballWidth/2<blockY+blockHeight && b.ballY+b.ballWidth/2>blockY)) {
      b.speedY=- abs(b.speedY);
      hits--;
      return true;
    } else if ((b.ballY+b.ballWidth/4>blockY && b.ballY-b.ballWidth/4<blockY+blockWidth)
      && (b.ballX+b.ballWidth/2>blockX && b.ballX+b.ballWidth/2<blockX+blockWidth)) {
      b.speedX=- abs(b.speedX);
      hits--;
      return true;
    }
    if ((b.ballY+b.ballWidth/4>blockY && b.ballY-b.ballWidth/4<blockY+blockHeight)
      && (b.ballX-b.ballWidth/2<blockX+blockWidth && b.ballX-b.ballWidth/2>blockX)) {
      b.speedX= abs(b.speedX);
      hits--;
      return true;
    }
    return false;
  }
}
//Dit is voor MB om de ball weer terug te bouncen.
