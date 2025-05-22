public class Entity{
  int xLocation;
  int yLocation;
  int[] directions;
  PImage assetImg;
  PImage frontAssetImg;
  PImage reverseAssetImg;
  boolean flag;
  
  public Entity(PImage frontAssetImg, PImage reverseAssetImg) {
    xLocation = width/2;
    yLocation = height/2;
    directions = new int[]{0, 1, 2, 3};
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
    return -1;
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
