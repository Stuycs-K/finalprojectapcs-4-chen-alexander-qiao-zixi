public class AttackProjectile extends Entity{
  private int range;
  private int startingX;
  private int startingY;
  private float xDiff = 0;
  private float yDiff = 0;
  private boolean piercing;
  private boolean friendly;
  private String name;
  
  //Bible only
  private float sourceX; 
  private float sourceY; 
  private float distance; 
  
  public AttackProjectile(String name, int x, int y, PImage frontAssetImg, PImage reverseAssetImg, int inputRange, boolean isPiercing, boolean isFriendly, PVector attackDirection, PlayerCharacter attackSource){
    super(x, y, frontAssetImg, reverseAssetImg);
    startingX = x;
    startingY = y;
    sourceX = attackSource.getX();
    sourceY = attackSource.getY();
    range = inputRange;
    piercing = isPiercing;
    friendly = isFriendly;
    this.name = name;
    //System.out.println(attackSource.getDirection().x);
    if(attackSource.getFacing()){
      PVector newDirection = new PVector(attackDirection.x, attackDirection.y);
      super.setDirection(newDirection);
    }
    else{
      setDirection(attackDirection);
    }
  }
  
  
  public String getName() {
    return name;
  }

  public int getRange(){
    return range;
  }
  
  public float getDistanceMoved(){
    if(name.equals("bible")){
      return distance;
    }
    else{
      return sqrt((xDiff * xDiff) + (yDiff * yDiff)); 
    }
  }
  
  public boolean getPiercing(){
    return piercing;
  }
  
  public boolean getFriendlyStatus(){
    return friendly;
  }
  
  public float getSourceX(){
    return sourceX;
  }
  
  public float getSourceY(){
    return sourceY;
  }
  
  public void setSourceX(float newX){
    sourceX = newX;
  }
  
  public void setSourceY(float newY){
    sourceY = newY;
  }
  
  public void display(int cameraX, int cameraY){
    imageMode(CORNER);
    if(name.equals("bible")){
      imageMode(CENTER);
    }
    super.display(cameraX, cameraY);
    imageMode(CORNER);
  }
  public void monodirectionalAttack(){
    super.updateLocation();
    xDiff = abs(super.getX() - startingX);
    yDiff = abs(super.getY() - startingY);
    distance += getDirection().mag() * (1 / 60.0); 
    if(!name.equals("bible")){
      if (getX() < 0 || getX() > mapWidth || getY() < 0 || getY() > mapHeight) {
        allProjectiles.remove(this);
      }
    }
  }
 
}
