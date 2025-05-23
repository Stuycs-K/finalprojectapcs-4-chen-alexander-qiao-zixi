public class AttackProjectile extends Entity{
  private int speed;
  private int range;
  private int distanceMoved;
  private boolean piercing;
  private boolean friendly;
  
  public AttackProjectile(int x, int y, PImage frontAssetImg, PImage reverseAssetImg, int inputSpeed, int inputRange, boolean isPiercing, boolean isFriendly, PVector attackDirection){
    super(x, y, frontAssetImg, reverseAssetImg);
    speed = inputSpeed;
    range = inputRange;
    piercing = isPiercing;
    friendly = isFriendly;
    setDirection(attackDirection);
  }
  
  public int getSpeed(){
    return speed;
  }
  
  public int getRange(){
    return range;
  }
  
  public int getDistanceMoved(){
    return distanceMoved; 
  }
  
  public boolean getPiercing(){
    return piercing;
  }
  
  public boolean getFriendlyStatus(){
    return friendly;
  }
  
  public void setSpeed(int newSpeed){
    speed = newSpeed;
  }
  
  public void monodirectionalAttack(){
    //CODE GOES HERE
  }
 
  
}
