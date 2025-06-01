public class EnemyCharacter extends Characters{
  
  private int speed;
  
  public EnemyCharacter(int speed, int health, float xLoc, float yLoc, PImage frontAssetImg, PImage reverseAssetImg) {
    super(health, xLoc, yLoc, frontAssetImg, reverseAssetImg);
    this.speed = speed;
  }
  
  public int getSpeed() {
    return speed;
  }
  
  public void setSpeed(int newSpeed) {
    speed = newSpeed;
  }
  
  public void convergeOnPlayer(PlayerCharacter pc) {
    PVector newDirection = new PVector(0, 0);
    newDirection.x = pc.getX() - getX();
    newDirection.y = pc.getY() - getY();
    newDirection.setMag(speed);
    super.setDirection(newDirection);
    super.updateLocation();
    
    // Constrain enemy to map boundaries
    float newX = getX() + direction.x;
    float newY = getY() + direction.y;
  
    newX = constrain(newX, 0, mapWidth - frontAssetImg.width);
    newY = constrain(newY, 0, mapHeight - frontAssetImg.height);
  
    setX(newX);
    setY(newY);
  }
  
  void display(float cameraX, float cameraY) {
    float screenX = getX() + cameraX;
    float screenY = getY() + cameraY;
    
    image(getImg(), screenX, screenY);
  }
}
