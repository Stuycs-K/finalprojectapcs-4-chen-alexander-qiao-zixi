//Commented out for now due to no Character Class
////Character Starting Variables
//PlayerCharacter mainCharacter = new PlayerCharacter(); //TO BE UPDATED WHEN CONSTRUCTOR ADDED
//ArrayList<PImage> characterAssets = new ArrayList<PImage>();
//ArrayList<String> chearacterAssetName = new ArrayList<String>();

//Projectile Starting Variables
ArrayList<AttackProjectile> allProjectiles = new ArrayList<AttackProjectile>();
ArrayList<PImage> weaponAssets = new ArrayList<PImage>();
ArrayList<PImage> weaponAssetsReversed = new ArrayList<PImage>();
ArrayList<String> weaponAssetName = new ArrayList<String>();

//Commented out for now due to no Enemy Class
////Enemy Starting Variables
//ArrayList<EnemyCharacter> allEnemies = new ArrayList<EnemyCharacter>();
//ArrayList<EnemyCharacter> enemyAssets = new ArrayList<EnemyCharacter>();
//ArrayList<String> enemyAssetName = new ArrayList<String>();

PVector up = new PVector(0, -1);
PVector down = new PVector(0, 1);
PVector right = new PVector(5, 0);
PVector left = new PVector(-1, 0);
int count;

void setup(){
  size(500, 500); // PLACEHOLDER
  background(0,255,0);
  count = 0;
  
  //Filling the ArrayList of weapon assets
  PImage knife = loadImage("knife.png");
  PImage knifeReversed = loadImage("knifeReversed.png");
  weaponAssets.add(knife);
  weaponAssetsReversed.add(knifeReversed);
  weaponAssetName.add("knife");
  
  //Filling the ArrayList of enemyAssets
  //To be filled when Enemy class is done. 
  
}

void draw(){
  background(0, 255, 0);
  //circle(mouseX, mouseY, 50); //Circles used as placeholder for entities while partner gets it sorted out
  
  //Enemy Spawning testing
  if(count % 60 == 0 && count >= 60){
    AttackProjectile thrownKnife = new AttackProjectile(mouseX, mouseY, weaponAssets.get(0), weaponAssetsReversed.get(0), 150, false, true, right);
    allProjectiles.add(thrownKnife);
  }
  
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
}
