public class PlayerCharacter extends Characters{
  
  public PlayerCharacter(int health, float xLoc, float yLoc, PImage frontAssetImg, PImage reverseAssetImg) {
    super(health, xLoc, yLoc, frontAssetImg, reverseAssetImg);
  }
  
  public void playerMovement() {
    PVector newDirection = new PVector(0,0);
    if (left) {
      newDirection.add(new PVector(-1, 0));
    } 
    if (right) {
      newDirection.add(new PVector(1, 0));
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
}
