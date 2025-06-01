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
    newDirection.setMag(50);
    setDirection(newDirection);
    updateLocation();
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
