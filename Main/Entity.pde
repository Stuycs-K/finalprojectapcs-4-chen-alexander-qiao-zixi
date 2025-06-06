public class Entity{
  float xLocation;
  float yLocation;
  PVector direction;
  PImage assetImg;
  PImage frontAssetImg;
  PImage reverseAssetImg;
  boolean flag;
  boolean facingLeft = false;
  
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
  
  public void setX(float newX){
    xLocation = newX;
  }
  
  public void setY(float newY){
    yLocation = newY;
  }
  
  protected void updateLocation() {
    xLocation += direction.x * 1/60; // frame rate 60 times per sec
    yLocation += direction.y * 1/60;
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
  
  public void changeImg() {
    checkLeft();
    if (facingLeft) {
      assetImg = frontAssetImg;
    } else {
      assetImg = reverseAssetImg;
    }
  }
  
  public float getWidth() {
    return assetImg.width;
  }
    
  public float getHeight() {
    return assetImg.height;
  }
  
  void checkLeft(){
    if(direction.x < 0){
      facingLeft = false;
    }
    else if(direction.x > 0){
      facingLeft = true;
    }
  }
  
  void display(float cameraX, float cameraY) {
    checkLeft();
    if (facingLeft) {
      assetImg = frontAssetImg;
    } else {
      assetImg = reverseAssetImg;
    }
    
    image(getImg(), getX()+cameraX, getY()+cameraY);
  }
  
  public boolean getFacing(){
    return facingLeft; 
  }
}
