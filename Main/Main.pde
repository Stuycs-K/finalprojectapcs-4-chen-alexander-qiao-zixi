//Character Starting Variables
PlayerCharacter mainCharacter;
ArrayList<PImage> characterAssets = new ArrayList<PImage>();
ArrayList<PImage> characterAssetsReversed = new ArrayList<PImage>();
ArrayList<String> chearacterAssetName = new ArrayList<String>();

//Projectile Starting Variables
ArrayList<AttackProjectile> allProjectiles = new ArrayList<AttackProjectile>();
ArrayList<PImage> weaponAssets = new ArrayList<PImage>();
ArrayList<PImage> weaponAssetsReversed = new ArrayList<PImage>();
ArrayList<String> weaponAssetName = new ArrayList<String>();

//Enemy Starting Variables
ArrayList<EnemyCharacter> allEnemies = new ArrayList<EnemyCharacter>();
ArrayList<EnemyCharacter> enemyAssets = new ArrayList<EnemyCharacter>();
ArrayList<String> enemyAssetName = new ArrayList<String>();

PVector upControl = new PVector(0, -1);
PVector downControl = new PVector(0, 1);
PVector rightControl = new PVector(50, 0);
PVector leftControl = new PVector(-1, 0);
int count;
boolean left, right, up, down; 

void setup(){
  size(500, 500); // PLACEHOLDER
  background(0,255,0);
  count = 0;
  
  //Character Construction
  PImage character1 = loadImage("character1.png");
  PImage character1Reversed = loadImage("character1Reversed.png");
  characterAssets.add(character1);
  characterAssetsReversed.add(character1Reversed);
  mainCharacter = new PlayerCharacter(50, 200, 200, characterAssets.get(0), characterAssetsReversed.get(0));


  
  //Filling the ArrayList of weapon assets
  PImage knife = loadImage("knife.png");
  PImage knifeReversed = loadImage("knifeReversed.png");
  weaponAssets.add(knife);
  weaponAssetsReversed.add(knifeReversed);
  weaponAssetName.add("knife");
  
  PImage fireball = loadImage("fireball.png");
  weaponAssets.add(fireball);
  weaponAssetName.add("fireball");
  
  //Filling the ArrayList of enemyAssets
  //To be filled when Enemy class is done. 
  
}


void draw(){
  background(0, 255, 0);
  //circle(mouseX, mouseY, 50); //Circles used as placeholder for entities while partner gets it sorted out
  
  //Enemy Spawning testing
  if(count % 60 == 0 && count >= 60){
    AttackProjectile thrownKnife = new AttackProjectile(mouseX, mouseY, weaponAssets.get(0), weaponAssetsReversed.get(0), 150, false, true, rightControl);
    AttackProjectile fireball = new AttackProjectile(mouseX + 50, mouseY + 50, weaponAssets.get(1), weaponAssets.get(1), 150, false, true, rightControl);

    allProjectiles.add(thrownKnife);
    allProjectiles.add(fireball);

  }
  
  mainCharacter.display();
  mainCharacter.playerMovement();
  
  
  for(int index = 0; index < allProjectiles.size(); index++){
    AttackProjectile currentProjectile = allProjectiles.get(index);
    currentProjectile.display();
    currentProjectile.updateLocation();
  }
  
  //MOVEMENT HERE WHEN IMPLEMENTED
  
  //Commented out for now while EnemyCharacter isn't implemented
  //for(int i = 0; i < allEnemies.size(); i++){
  //  allEnemies.get(i).convergeOnPlayer();
  //}
  
  count++; 
}

void keyPressed(){
  //Commented out for now while PlayerCharacter is waiting to be implemented
  //mainCharacter.playerMovement(key);  
  setMove(true);
}

void keyReleased() {
  setMove(false);
}

boolean setMove(boolean b) {
  if (key == 'w') {
    return up = b;
  } else if (key == 'a') {
    return left = b;
  } else if (key == 's') {
    return down = b;
  } else if (key == 'd') {
    return right = b;
  } else {
    return b;
  }
}
