public class Entity{
  int xLocation;
  int yLocation;
  int[] directions;
  PImage assetImg;
  PImage reverseAssetImg;
  
  public Entity() {
    xLocation = width/2;
    yLocation = height/2;
    directions = new int[]{0, 1, 2, 3};
  }
}
