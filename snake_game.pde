Snake snake = new Snake(0, 0);
Food food = new Food(100, 100);
int Window_w = 720;
int Window_h = 640;
int Square_size = 20;



void setup(){
  size(720, 640, P2D);
  //background(230, 50, 100);
  background(0, 0, 0);
  frameRate(5);
}

void draw(){
  background(0, 0, 0);
  board();
  
  snake.update(food);
  
  snake.show();
  food.show();
  
}

void keyPressed(){
  if (key == CODED) {
    if (keyCode == UP || keyCode == DOWN || keyCode == RIGHT || keyCode == LEFT) {
      //print(keyCode); 
      snake.setDirection(keyCode);
    }
    if(snake.direction != snake.previus_direction){
      //snake.update();
      snake.previus_direction = snake.direction;
    }
  }
}

void board() {
  stroke(255, 255, 255);
  for(int i=0; i < Window_w; i+= Square_size) {
    line(i,0, i, Window_h);
  }
  for(int i=0; i < Window_w; i+= Square_size) {
    line(0, i, Window_w, i);
  }
}

class SnakeBody{
  int x, y;
  
  SnakeBody(int x, int y){
    this.x = x;
    this.y = y;
  }
}

class Snake{
  //private SnakeBody head;
  private ArrayList<SnakeBody> body = new ArrayList<SnakeBody>();
  private int direction;
  //private int[] directions = {UP,RIGHT, DOWN, LEFT};
  private int previus_direction;
  private SnakeBody head;
  
  Snake(int x, int y){
    SnakeBody head = new SnakeBody(x, y);
    body.add(head);
    //direction = directions[int(random(4))];
    direction = 0;
    previus_direction = direction;
    this.head = head;
  }

  
  void show() {
    fill(25, 150, 30);
    for(SnakeBody el: body){
      square(el.x, el.y, Square_size);
    }
  }
  void setDirection(int direc) {
    if(direction == UP && direc == DOWN) return;
    if(direction == DOWN && direc == UP) return;
    if(direction == LEFT && direc == RIGHT) return;
    if(direction == RIGHT && direc == LEFT) return;
    
    direction = direc;
  }
  void update(Food food) {
    for(int i = body.size() -1; i >0;i--){
      body.get(i).x = body.get(i-1) .x;
      body.get(i).y = body.get(i-1).y;
    }
    if(direction == RIGHT) {
      head.x += Square_size;
    }
    if(direction == LEFT) {
      head.x -= Square_size;
    }
    if(direction == UP) {
      head.y -= Square_size;
    }
    if(direction == DOWN) {
      head.y += Square_size;
    }
    
    if(hasEaten(food)){
      growth();
      food.randomFood();
    }
    if(AmIDead()){
      noLoop();
    }
  }
  
  private boolean hasEaten(Food food){
    return (food.x == head.x && food.y == head.y);
  }
  
  private void growth() {
    int lastI = body.size()-1;
    
    SnakeBody last = body.get(lastI);
    int x = last.x, y = last.y;
    if(direction == UP) y += Square_size;
    if(direction == RIGHT) x -= Square_size;
    if(direction == DOWN) y -= Square_size;
    if(direction == LEFT) x += Square_size;
    body.add(new SnakeBody(x, y));
  }
  
  private boolean AmIDead() {
    return (head.x < 0 || head.x > Window_w) || (head.y <0 || head.y > Window_h);
  }
}

class Food extends SnakeBody{
 
  Food(int x, int y){
    super(x, y);
  }
  
  void show() {
    fill(200, 40, 50);
    square(this.x,this.y, Square_size);
  }
  
  void randomFood() {
    int max_x = Window_w/Square_size;
    x = int(random(max_x)) * Square_size;
    int max_y = Window_h/Square_size;
    y = int(random(max_y))*Square_size;
  }
}
