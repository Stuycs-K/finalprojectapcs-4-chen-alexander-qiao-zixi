public class Entity{
  float xLocation;
  float yLocation;
  PVector direction;
  PImage assetImg;
  PImage frontAssetImg;
  PImage reverseAssetImg;
  boolean flag;
  
  public Entity(float x, float y, PImage frontAssetImg, PImage reverseAssetImg) {
    xLocation = x;
    yLocation = y;
    direction = new PVector(0,0);
    assetImg = frontAssetImg;
    this.frontAssetImg = frontAssetImg;
    this.reverseAssetImg = reverseAssetImg;
    flag = false;
  }
  
  public float getX() {
    return xLocation;
  }
  
  public float getY() {
    return yLocation;
  }
  
  protected void updateLocation() {
    xLocation += direction.x * 1/60; // frame rate 60 times per sec
    yLocation += direction.y * 1/60;
  }
  
  public void display() {
    noStroke();
    assetImg.resize(30,0);
    image(assetImg, xLocation, yLocation);
  }
  
  public PVector getDirection() {
    return direction;
  }
  
  public void setDirection(PVector newDirection){
    direction = newDirection;
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
