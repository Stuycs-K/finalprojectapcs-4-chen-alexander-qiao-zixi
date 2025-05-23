public class Entity{
  int xLocation;
  int yLocation;
  PVector direction;
  PImage assetImg;
  PImage frontAssetImg;
  PImage reverseAssetImg;
  boolean flag;
  
  public Entity(int x, int y, PImage frontAssetImg, PImage reverseAssetImg) {
    xLocation = x;
    yLocation = y;
    direction = new PVector(0,0);
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
  
  protected void updateLocation() {
    xLocation += direction.x * 1/60; // frame rate 60 times per sec
    yLocation += direction.y * 1/60;
  }
  
  public void display() {
    noStroke();
    image(assetImg, xLocation, yLocation);
  }
  
  public PVector getDirection() {
    return direction;
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
    flag = !flag;
  }
}
