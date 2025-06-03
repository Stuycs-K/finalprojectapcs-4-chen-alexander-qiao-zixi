public class EnemyCharacter extends Characters{
  
  private int speed;
  private boolean chargingEnemy;
  private String name;
  
  public EnemyCharacter(int speed, int health, float xLoc, float yLoc, PImage frontAssetImg, PImage reverseAssetImg) {
    super(health, xLoc, yLoc, frontAssetImg, reverseAssetImg);
    this.speed = speed;
    chargingEnemy = false;
    name = "";
  }
  
  public EnemyCharacter(int speed, int health, float xLoc, float yLoc, PImage frontAssetImg, PImage reverseAssetImg, boolean isCharging, PlayerCharacter pc) {
    super(health, xLoc, yLoc, frontAssetImg, reverseAssetImg);
    this.speed = speed;
    chargingEnemy = isCharging;
    PVector newDirection = new PVector(0, 0);
    newDirection.x = pc.getX() - getX();
    newDirection.y = pc.getY() - getY();
    newDirection.setMag(speed);
    super.setDirection(newDirection);
    name = "";
  }
  
    public EnemyCharacter(String name, int speed, int health, float xLoc, float yLoc, PImage frontAssetImg, PImage reverseAssetImg) {
    super(health, xLoc, yLoc, frontAssetImg, reverseAssetImg);
    this.speed = speed;
    chargingEnemy = false;
    this.name = name;
  }
  
  public String getName() {
    return name;
  }
  
  public int getSpeed() {
    return speed;
  }
  
  public boolean chargingStatus(){
    return chargingEnemy;
  }
  
  public void setSpeed(int newSpeed) {
    speed = newSpeed;
  }
  
  public void convergeOnPlayer(PlayerCharacter pc) {
    PVector newDirection = new PVector(0, 0);
    newDirection.x = pc.getX() - getX();
    newDirection.y = pc.getY() - getY();
    newDirection.normalize();
    newDirection.setMag(speed);
    super.setDirection(newDirection);
    super.changeImg();
    
    // Constrain enemy to map boundaries
    float newX = getX() + direction.x;
    float newY = getY() + direction.y;
  
    newX = constrain(newX, 0, mapWidth - frontAssetImg.width);
    newY = constrain(newY, 0, mapHeight - frontAssetImg.height);
  
    setX(newX);
    setY(newY);
  }
  
  public void convergeNearPlayer(PlayerCharacter pc) {
    PVector newDirection = new PVector(0, 0);
    if (Math.abs(pc.getX() - getX()) <= 50 || Math.abs(pc.getY() - getY()) <= 50) {
      return;
    } 
    newDirection.x = pc.getX() - getX();
    newDirection.y = pc.getY() - getY();
    newDirection.normalize();
    newDirection.setMag(speed);
    super.setDirection(newDirection);
    super.changeImg();
    
    // Constrain enemy to map boundaries
    float newX = getX() + direction.x;
    float newY = getY() + direction.y;
  
    newX = constrain(newX, 0, mapWidth - frontAssetImg.width);
    newY = constrain(newY, 0, mapHeight - frontAssetImg.height);
  
    setX(newX);
    setY(newY);
  }
}
