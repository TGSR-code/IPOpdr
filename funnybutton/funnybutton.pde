// le data types
boolean funnybutton = false;

//groote van het "canvas"
void setup() {
  size(690,420);
}

//Kleuren voor de knop lol
void draw() {
  background(0);
  //als het een funnybutton is, fill het else niet
  if (funnybutton == true) {
    fill(255);
  } else {
    noFill();
    }
  rect(105, 60, 75, 75);
}

//Als het funny button is, dan gaat het naar rollers.tgsr- NIET OP HET KNOP DRUKKEN
void mousePressed() {
  if (funnybutton) {
    link("https://rollers.tgsr.nl");
    }
    
  }
  //checked als de muis beweegt zelfde met mouseDragged
void mouseMoved() { 
  checkButtons(); 
}
  
void mouseDragged() {
  checkButtons(); 
}
//Deze checked als de muis bij die cubes is die ik gemaakt heb voor een knop
void checkButtons() {
  if (mouseX > 105 && mouseX < 180 && mouseY > 60 && mouseY <135) {
    funnybutton = true;   
  } else {
    funnybutton = false;
  }
}
