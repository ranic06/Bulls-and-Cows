import processing.net.*;

Client c;
String input = "";
String message = "";

void setup() {
  size(400, 200);
  textSize(20);
  fill(255);
  c = new Client(this, " 127.0.0.0", 12345);
}

void draw() {
  background(0);
  text("Your guess: " + input, 20, height / 2);
  text("Server says: " + message, 20, height / 2 + 40);
}

void keyPressed() {
  if (key == '\n') {
    c.write(input + "\n");
    input = "";
  } else if (key == BACKSPACE) {
    if (input.length() > 0) {
      input = input.substring(0, input.length() - 1);
    }
  } else {
    input += key;
  }
}

void clientEvent(Client c) {
  message = c.readStringUntil('\n');
  if (message != null) {
    message = message.trim();
  }
}
