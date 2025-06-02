public class ItemPickups extends Entity{
  boolean isHealing;
  boolean isWeaponUpgrade;
  //UPDATE WHEN NEW POWERUP FOUND
  boolean placeholder; 
  
  public ItemPickups(float initialX, float initialY, PImage frontAssetImg, PImage reverseAssetImg, boolean healingStatus, boolean weaponUpgrade, boolean placeholderStatus){
    super(initialX, initialY, frontAssetImg, reverseAssetImg);
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

}
