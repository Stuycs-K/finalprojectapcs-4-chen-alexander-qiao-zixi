public class AttackProjectile extends Entity{
  private int range;
  private int startingX;
  private int startingY;
  private float xDiff = 0;
  private float yDiff = 0;
  private boolean piercing;
  private boolean friendly;
  
  public AttackProjectile(int x, int y, PImage frontAssetImg, PImage reverseAssetImg, int inputRange, boolean isPiercing, boolean isFriendly, PVector attackDirection, PlayerCharacter attackSource){
    super(x, y, frontAssetImg, reverseAssetImg);
    startingX = x;
    startingY = y;
    range = inputRange;
    piercing = isPiercing;
    friendly = isFriendly;
    //System.out.println(attackSource.getDirection().x);
    if(attackSource.getFacing()){
      PVector newDirection = new PVector(attackDirection.x, attackDirection.y);
      newDirection.mult(-1);
      super.setDirection(newDirection);
    }
    else{
      setDirection(attackDirection);
    }
  }
  
  public int getRange(){
    return range;
  }
  
  public float getDistanceMoved(){
    return sqrt((xDiff * xDiff) + (yDiff * yDiff)); 
  }
  
  public boolean getPiercing(){
    return piercing;
  }
  
  public boolean getFriendlyStatus(){
    return friendly;
  }
  
  public void monodirectionalAttack(){
    super.updateLocation();
    xDiff = abs(super.getX() - startingX);
    yDiff = abs(super.getY() - startingY);    
  }
 
  
}
