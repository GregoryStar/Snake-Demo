import java.util.Queue;
import java.util.ArrayDeque;
class SnakeBody{
  public Queue<int[]> body = new ArrayDeque();
  int headX;
  int headY;
  
  public SnakeBody(int x, int y){
    int[] startCoord = new int[2];
    startCoord[0] = x;
    startCoord[1] = y;
    headX = x;
    headY = y;
    body.add(startCoord);
  }
  
  public void update(int x, int y){
    int[] newCoord = new int[2];
    newCoord[0] = x;
    newCoord[1] = y;
    body.remove();
    body.add(newCoord);
  }
  
  public void addNewMember(int x, int y){
    int[] newCoord = new int[2];
    newCoord[0] = x;
    newCoord[1] = y;
    body.add(newCoord);
  }
  
  public boolean isInSnake(int x, int y){
    for(int[] coord : body){
      if(x == coord[0] && y == coord[1]){
        return true;
      }
    }
    return false;
  }
  
  public int snakeLength(){
    return body.size();
  }
}