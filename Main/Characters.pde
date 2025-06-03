public class Characters extends Entity{
  
  private int health;
  private int maxHealth;
  
  public Characters(int health, float xLoc, float yLoc, PImage frontAssetImg, PImage reverseAssetImg) {
    super(xLoc, yLoc, frontAssetImg, reverseAssetImg);
    this.health = health;
    maxHealth = health;
  }
  
  public int getHP() {
    return health;
  }
  
  public int getMaxHP(){
    return maxHealth;
  }
  
  public void setMaxHP(int newMaxHP){
    maxHealth = newMaxHP;
  }
  
  public void setHP(int amount) {
    if (amount > maxHealth) {
      health = maxHealth;
    } else if (amount < 0) {
      health = 0;
    } else {
      health = amount;
    }
  }
  
  public void takeDamage(int amount){
    if (health - amount < 0) {
      health = 0;
    } else {
      health = health - amount;
    }
  }
  
  public void gainHealth(int amount){
    if(health + amount > maxHealth){
      health = maxHealth;
    }
    else{
      health = health + amount;
    }
  }
}
