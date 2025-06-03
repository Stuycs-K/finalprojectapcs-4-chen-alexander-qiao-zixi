public class ItemPickups extends Entity{
  int healingAmount;
  boolean isHealing;
  
  boolean isWeaponUpgrade;
  
  //UPDATE WHEN NEW POWERUP FOUND
  boolean placeholder; 
  
  public ItemPickups(float initialX, float initialY, PImage frontAssetImg, PImage reverseAssetImg, int healing, boolean healingStatus, boolean weaponUpgrade, boolean placeholderStatus){
    super(initialX, initialY, frontAssetImg, reverseAssetImg);
    healingAmount = healing; 
    isHealing = healingStatus;
    
    isWeaponUpgrade = weaponUpgrade;
    
    //UPDATE WHEN NEW POWERUP FOUND
    placeholder = placeholderStatus;
  }
  
  boolean getHealingStatus(){
    return isHealing;
  }
  
  boolean weaponUpgradeStatus(){
    return isWeaponUpgrade;
  }
  
  //UPDATE WHEN NEW POWERUP FOUND
  boolean placeholderStatus(){
    return placeholder;
  }
  
  int getHealing(){
    return healingAmount;
  }

}
