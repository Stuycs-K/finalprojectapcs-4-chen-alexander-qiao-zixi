public class EnemyCharacter extends Characters{
  
  private int speed;
  private boolean chargingEnemy;
  private String name;
  private float chargeStartX, chargeStartY;
  
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
    chargeStartX = xLoc;
    chargeStartY = yLoc;
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
  
  public void setChargingStatus(boolean status) {
    chargingEnemy = status;
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
  
  public void convergeNearPlayer(PlayerCharacter pc, int distance) {
    float dx = pc.getX() - getX();
    float dy = pc.getY() - getY();
    float actualDistance = sqrt(dx*dx + dy*dy);
    
    if (actualDistance <= distance) {
        return;
    }
    
    PVector newDirection = new PVector(dx, dy);
    newDirection.normalize();
    newDirection.setMag(speed);
    super.setDirection(newDirection);
    super.changeImg();
    
    // Constrain enemy to map boundaries
    float newX = getX() + direction.x;
    float newY = getY() + direction.y;
  
    newX = constrain(newX, getWidth()/2, mapWidth - frontAssetImg.width);
    newY = constrain(newY, getHeight()/2, mapHeight - frontAssetImg.height);
  
    setX(newX);
    setY(newY);
}
  
  public void setChargeStartPosition() {
    chargeStartX = getX();
    chargeStartY = getY();
  }
  
  public float getChargeStartX() {
    return chargeStartX;
  }
  
  public float getChargeStartY() {
    return chargeStartY;
  }
}
