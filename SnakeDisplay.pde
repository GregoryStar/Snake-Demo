int screenHeight = 800;
int screenWidth = 800;
SnakeBody snake = new SnakeBody(5, 5);
String keyPress = "";
String lastDirection = "";
int foodX;
int foodY;
int xScale = screenWidth/20;
int yScale = screenHeight/20;
int maxXCoord = 20;
int maxYCoord = 20;
int score = 0;
boolean gameOver = false;

float refreshTime = 100;
float lastRefresh = 0;

void settings(){
  size(screenWidth, screenHeight);
}

void setup(){
  frameRate(60);
  gameOver = true;
  lastRefresh = millis();
}

void draw(){
  score = (snake.snakeLength() - 1) * 20;
  background(255);
  if(gameOver){
    clear();
    background(100);
    fill(255, 255, 255);
    textSize(32);
    String scoreText = "Score: " + score;
    text(scoreText, 260, 350);
    text("Press Space to Play", 260, 400);
  } else if(!gameOver && (millis() - lastRefresh) > refreshTime){
    lastRefresh = millis();
    if(keyPress == "U"){
      snake.headY--;
    } else if (keyPress == "D") {
      snake.headY++;
    } else if (keyPress == "R") {
      snake.headX++;
    } else if (keyPress == "L") {
      snake.headX--;
    }
    lastDirection = keyPress;
    
    if((snake.isInSnake(snake.headX, snake.headY) || isOutOfBounds(snake.headX, snake.headY)) && keyPress != ""){
      gameOver = true;
    }
      
    if(snake.headX == foodX && snake.headY == foodY){
      snake.addNewMember(foodX, foodY);
      moveFood();
    }
    snake.update(snake.headX, snake.headY); 
  }
  
  if(!gameOver){
    //Draw the food and the updated snake
    fill(0, 255, 0);
    rect(foodX * xScale, foodY * yScale, xScale, yScale);  
    fillSnake();
    for(int i = 0; i < maxXCoord; i++){
      line(i*(screenWidth/20), 0, i*(screenWidth/20), screenHeight);
      line(0, i*(screenWidth/20), screenWidth, i*(screenWidth/20));
    }
  }
}

public void moveFood(){
  while(snake.isInSnake(foodX, foodY)){
    foodX = (int) random(0, maxXCoord);
    foodY = (int) random(0, maxYCoord);  
  }
}

public void fillSnake(){
  for(int[] coord : snake.body){
    int x = coord[0];
    int y = coord[1];
    fill(255, 0, 0);
    rect(x * xScale, y * yScale, xScale, yScale);
  }
}

public boolean isOutOfBounds(int x, int y){
  return x < 0 || x >= maxXCoord || y < 0 || y >= maxYCoord;
}

public void reset(){
  snake = new SnakeBody(5, 5);
  moveFood();
  score = 0;
  keyPress = "";
  gameOver = false;
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP && (lastDirection != "D" || snake.snakeLength() == 1)) {
      keyPress = "U";
    } else if (keyCode == DOWN && (lastDirection != "U" || snake.snakeLength() == 1)) {
      keyPress = "D";
    } else if (keyCode == RIGHT && (lastDirection != "L" || snake.snakeLength() == 1)) {
      keyPress = "R";
    } else if (keyCode == LEFT && (lastDirection != "R" || snake.snakeLength() == 1)) {
      keyPress = "L";
    }
  } else if(key == ' ' && gameOver){
    reset();
  }
}