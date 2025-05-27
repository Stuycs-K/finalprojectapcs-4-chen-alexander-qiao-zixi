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
ArrayList<PImage> enemyAssets = new ArrayList<PImage>();
ArrayList<PImage> enemyAssetsReversed = new ArrayList<PImage>();
ArrayList<String> enemyAssetName = new ArrayList<String>();

PVector upControl = new PVector(0, -1);
PVector downControl = new PVector(0, 1);
PVector rightControl = new PVector(50, 0);
PVector leftControl = new PVector(-1, 0);
int count;
boolean left, right, up, down; 

void setup(){
  size(1920, 1080); // PLACEHOLDER
  background(255);
  count = 0;
  noStroke();
  
  //Map Initialization
  PImage map = loadImage("map1.jpeg");
  image(map, 0, 0);
  
  //Character Construction
  PImage character1 = loadImage("character1.png");
  PImage character1Reversed = loadImage("character1Reversed.png");
  characterAssets.add(character1);
  characterAssetsReversed.add(character1Reversed);
  mainCharacter = new PlayerCharacter(50, width / 2, height / 2, characterAssets.get(0), characterAssetsReversed.get(0));


  
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
  PImage enemy1 = loadImage("enemy1.png");
  PImage enemy1Reversed = loadImage("enemy1Reversed.png");
  enemyAssets.add(enemy1);
  enemyAssetsReversed.add(enemy1Reversed);
  
}


void draw(){
  background(255);
  //circle(mouseX, mouseY, 50); //Circles used as placeholder for entities while partner gets it sorted out
  
  //Weapon Spawning testing
  if(count % 60 == 0 && count >= 60){
      AttackProjectile thrownKnife = new AttackProjectile((int)mainCharacter.getX() + 10, (int)mainCharacter.getY(), weaponAssets.get(0), weaponAssetsReversed.get(0), 150, false, true, rightControl, mainCharacter);
      AttackProjectile fireball = new AttackProjectile((int)mainCharacter.getX() + 10, (int)mainCharacter.getY(), weaponAssets.get(1), weaponAssets.get(1), 150, false, true, rightControl, mainCharacter);

      allProjectiles.add(thrownKnife);
      allProjectiles.add(fireball);
  }
  
  if(count % 30 == 0 && count >= 30){
    EnemyCharacter bat = new EnemyCharacter(25, 25, random(width), random(height), enemyAssets.get(0), enemyAssetsReversed.get(0));
    allEnemies.add(bat);
  }
  
  mainCharacter.display();
  mainCharacter.playerMovement();
  drawHealthBar();
  
  
  for(int index = 0; index < allProjectiles.size(); index++){
    AttackProjectile currentProjectile = allProjectiles.get(index);
    currentProjectile.monodirectionalAttack();
    currentProjectile.display();
      
    if(currentProjectile.getRange() <= currentProjectile.getDistanceMoved()){
      allProjectiles.remove(currentProjectile);
    }
  }
  
  
  for(int i = 0; i < allEnemies.size(); i++){
    EnemyCharacter currentEnemy = allEnemies.get(i);
    currentEnemy.display();
    currentEnemy.convergeOnPlayer(mainCharacter);
    
  }
  
  count++; 
}

void keyPressed(){
  setMove(true);
}

void keyReleased() {
  setMove(false);
}

void drawHealthBar(){
  fill(0);
  rect(mainCharacter.getX() - 5, mainCharacter.getY() + 40, 40, 10);
  
  fill(255, 0, 0);
  float healthBarWidth = 40 * ((float)(mainCharacter.getHP())) / mainCharacter.getMaxHP();
  rect(mainCharacter.getX() - 5, mainCharacter.getY() + 40, healthBarWidth, 10);
  //mainCharacter.takeDamage(1);
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
