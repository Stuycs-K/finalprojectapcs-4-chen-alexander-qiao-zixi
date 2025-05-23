public class Entity{
  int xLocation;
  int yLocation;
  int direction;
  PImage assetImg;
  PImage frontAssetImg;
  PImage reverseAssetImg;
  boolean flag;
  
  public Entity(PImage frontAssetImg, PImage reverseAssetImg) {
    xLocation = width/2;
    yLocation = height/2;
    direction = 0;
    assetImg = frontAssetImg;
    this.frontAssetImg = frontAssetImg;
    this.reverseAssetImg = reverseAssetImg;
    flag = false;
  }
  
  public int getX() {
    return xLocation;
  }
  
  public int getY() {
    return yLocation;
  }
  
  public int getDirection() {
    return direction;
  }
  
  public void setDirection(char key) {
    if (key == 'n') {
      direction = 0;
    } else if (key == 'w') {
      direction = 1;
    } else if (key == 's') {
      direction = 2;
    } else if (key == 'e') {
      direction = 3;
    }
  }
  
  public PImage getImg() {
    return assetImg;
  }
  
  public void reverseImg() {
    if (flag) {
      assetImg = frontAssetImg;
    } else {
      assetImg = reverseAssetImg;
    }
  }
}
