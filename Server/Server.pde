import processing.net.*;

Server s;
Client c;
int secretNumber;
int attempts = 0;
boolean numberSet = false;
String input = "";

void setup() {
  size(400, 200);
  s = new Server(this, 12345);
}

void draw() {
  background(0);
  
  if (!numberSet) {
    text("Set secret number between 1-20, then press ENTER", 10, height / 2);
    text("Current input: " + input, 10, height / 2 + 20);
  } else {
    c = s.available();
    if (c != null) {
      String input = c.readStringUntil('\n');
      if (input != null) {
        input = input.trim();
        int guess = int(input);
        println("Guess: " + guess);
        attempts++;
        if (guess < secretNumber) {
          s.write("up\n");
        } else if (guess > secretNumber) {
          s.write("down\n");
        } else {
          s.write("Correct,You win \n");
        }
        if (attempts >= 5) {
          s.write("You lose\n");
        }
      }
    }
  }
}

void keyPressed() {
  if (!numberSet && key == ENTER) {
    secretNumber = int(input);
    if (secretNumber >= 1 && secretNumber <= 20) {
      numberSet = true;
      println("Secret number: " + secretNumber);
    } else {
      input = "Invalid number. Please enter a number between 1 and 20.";
    }
  } else if (!numberSet) {
    if (key == BACKSPACE) {
      if (input.length() > 0) {
        input = input.substring(0, input.length() - 1);
      }
    } else {
      input += key;
    }
  }
}
