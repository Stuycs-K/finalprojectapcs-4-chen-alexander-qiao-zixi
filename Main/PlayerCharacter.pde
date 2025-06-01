public class PlayerCharacter extends Characters{
  
  boolean facingLeft = false; 
  
  public PlayerCharacter(int health, float xLoc, float yLoc, PImage frontAssetImg, PImage reverseAssetImg) {
    super(health, xLoc, yLoc, frontAssetImg, reverseAssetImg);
  }
  
  public void playerMovement() {
    PVector newDirection = new PVector(0,0);
    if (left) {
      newDirection.add(new PVector(-1, 0));
      facingLeft = true; 
    } 
    if (right) {
      newDirection.add(new PVector(1, 0));
      facingLeft = false; 
    }
    if (up) {
      newDirection.add(new PVector(0, -1)); 
    }
    if (down) {
      newDirection.add(new PVector(0, 1));
    }
    newDirection.normalize();
    
    //Speed Variable until further notice. 
    newDirection.setMag(5);
    setDirection(newDirection);
    updateLocation();
    
    float newX = getX() + newDirection.x;
    float newY = getY() + newDirection.y;
    
    // Constrain player to map boundaries
    // These account for player size and camera view
    float minX = playerWidth/2;
    float maxX = mapWidth - playerWidth/2;
    float minY = playerHeight/2;
    float maxY = mapHeight - playerHeight/2;
    
    setX(constrain(newX, minX, maxX));
    setY(constrain(newY, minY, maxY));
  }
  
  
  void display(float cameraX, float cameraY) {
    float screenX = getX() + cameraX;
    float screenY = getY() + cameraY;
    
    if (facingLeft) {
      image(reverseAssetImg, screenX, screenY);
    } else {
      image(frontAssetImg, screenX, screenY);
    }
  }
  
  public boolean getFacing(){
    return facingLeft; 
  }
}
