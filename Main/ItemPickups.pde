public class ItemPickups extends Entity{
  int healingAmount;
  boolean isHealing;
  boolean isWeaponUpgrade;
 
  public ItemPickups(float initialX, float initialY, PImage frontAssetImg, PImage reverseAssetImg, int healing, boolean healingStatus, boolean weaponUpgrade){
    super(initialX, initialY, frontAssetImg, reverseAssetImg);
    healingAmount = healing; 
    isHealing = healingStatus;
    
    isWeaponUpgrade = weaponUpgrade;
  }
  
  boolean getHealingStatus(){
    return isHealing;
  }
  
  boolean weaponUpgradeStatus(){
    return isWeaponUpgrade;
  }
  
  int getHealing(){
    return healingAmount;
  }

}
