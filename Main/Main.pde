//Character Starting Variables
//TEST COMMENT 12
//Character Starting Variables
//TEST COMMENT 12
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

//Moving map stuff
float cameraX = 0;
float cameraY = 0;
int mapWidth = 20 * 192;  // Total map width (tiles * tile width)
int mapHeight = 20 * 108;
PGraphics mapBuffer; // Buffer for the entire map

//Map ArrayLists for tiles. 
ArrayList<PImage> grassAssets = new ArrayList<PImage>();

PVector upControl = new PVector(0, -1);
PVector downControl = new PVector(0, 1);
PVector rightControl = new PVector(50, 0);
PVector leftControl = new PVector(-1, 0);
int count;
boolean left, right, up, down; 
int gameOverCount = 0; 
boolean gameOver = false;
float playerWidth;
float playerHeight;

void setup(){
  size(1920, 1080, P2D); // PLACEHOLDER
  
 //Putting map assets into the ArrayList. 
  PImage backgroundTile1 = loadImage("grassyField1.png");
  PImage backgroundTile2 = loadImage("grassyFieldWithYellowFlowers2.png");

  grassAssets.add(backgroundTile1);
  grassAssets.add(backgroundTile2);
  
  // Create a buffer for the entire map
  mapBuffer = createGraphics(mapWidth, mapHeight);
  mapBuffer.beginDraw();
  for(int i = 0; i < 20; i++){
    for(int i2 = 0; i2 < 20; i2++){
      mapBuffer.image(grassAssets.get((int)random(grassAssets.size())), (192 * i), (108 * i2));
    }
  }
  mapBuffer.endDraw();
  
  count = 0;
  noStroke();
  
  //Character Construction
  PImage character1 = loadImage("character1.png");
  character1.resize(50, 0); // Set width to 50px, height auto
  PImage character1Reversed = loadImage("character1Reversed.png");
  character1Reversed.resize(50, 0);
  
  characterAssets.add(character1);
  characterAssetsReversed.add(character1Reversed);
  mainCharacter = new PlayerCharacter(50, width / 2, height / 2, characterAssets.get(0), characterAssetsReversed.get(0));

  playerWidth = character1.width;
  playerHeight = character1.height;

  // Enemy assets - with resizing
  PImage enemy1 = loadImage("enemy1.png");
  enemy1.resize(40, 0); // Set width to 40px, height auto
  PImage enemy1Reversed = loadImage("enemy1Reversed.png");
  enemy1Reversed.resize(40, 0);
  
  enemyAssets.add(enemy1);
  enemyAssetsReversed.add(enemy1Reversed);
  
  // Weapon assets - with resizing
  PImage knife = loadImage("knife.png");
  knife.resize(30, 0);
  PImage knifeReversed = loadImage("knifeReversed.png");
  knifeReversed.resize(30, 0);
  
  weaponAssets.add(knife);
  weaponAssetsReversed.add(knifeReversed);
  
  PImage fireball = loadImage("fireball.png");
  fireball.resize(30, 0);
  weaponAssets.add(fireball);

}

void draw(){
  if(mainCharacter.getHP() > 0){
    playGame();
  }
  else{
    gameOver();
    gameOver = true;
  }
}

void updateCamera() {
    // Calculate desired camera position (center on character)
    float targetX = width/2 - mainCharacter.getX();
    float targetY = height/2 - mainCharacter.getY();
    
    // Constrain camera to map boundaries
    // These are the correct constraints for all directions:
    targetX = constrain(targetX, width - mapWidth, 0);
    targetY = constrain(targetY, height - mapHeight, 0);
    
    // Smooth camera movement
    cameraX = lerp(cameraX, targetX, 0.1);  // Increased from 0.05 for more responsive follow
    cameraY = lerp(cameraY, targetY, 0.1);
}

void playGame(){
  background(0); // Clear screen to prevent trails
  
  image(mapBuffer, cameraX, cameraY);
  
  // Update camera position based on character movement
  updateCamera();
  
  //Weapon Spawning testing
  if(count % 60 == 0 && count >= 60){
      AttackProjectile thrownKnife = new AttackProjectile((int)mainCharacter.getX() + 10, (int)mainCharacter.getY(), weaponAssets.get(0), weaponAssetsReversed.get(0), 150, false, true, rightControl, mainCharacter);
      AttackProjectile fireball = new AttackProjectile((int)mainCharacter.getX() + 10, (int)mainCharacter.getY(), weaponAssets.get(1), weaponAssets.get(1), 150, false, true, rightControl, mainCharacter);

      allProjectiles.add(thrownKnife);
      allProjectiles.add(fireball);
  }
  
  if(count % 30 == 0 && count >= 30){
    // Spawn enemies within map boundaries
    float spawnX = constrain(random(width), 50, mapWidth - 50);
    float spawnY = constrain(random(height), 50, mapHeight - 50);
    EnemyCharacter bat = new EnemyCharacter(3, 25, spawnX, spawnY, enemyAssets.get(0), enemyAssetsReversed.get(0));
    allEnemies.add(bat);
  }
  
  mainCharacter.display(cameraX, cameraY);
  mainCharacter.playerMovement();
  drawHealthBar();
  
  // Projectiles
  for(int index = 0; index < allProjectiles.size(); index++){
    AttackProjectile currentProjectile = allProjectiles.get(index);
    currentProjectile.monodirectionalAttack();
    currentProjectile.display(cameraX, cameraY); // Pass camera offsets
    
    if(currentProjectile.getRange() <= currentProjectile.getDistanceMoved() ||
       currentProjectile.getX() < 0 || currentProjectile.getX() > mapWidth || 
       currentProjectile.getY() < 0 || currentProjectile.getY() > mapHeight) {
      allProjectiles.remove(currentProjectile);
      index--;
      continue;
    }
    
    for (int enemyIndex = 0; enemyIndex < allEnemies.size(); enemyIndex++) {
      if(onTarget(currentProjectile, allEnemies.get(enemyIndex))) {
        collisionDamage(currentProjectile, allEnemies.get(enemyIndex), 100);
        if (allEnemies.get(enemyIndex).getHP() <= 0) {
          allEnemies.remove(enemyIndex);
          enemyIndex--;
        }
      }
    }
  }
  
  // Enemies
  for(int i = 0; i < allEnemies.size(); i++){
    EnemyCharacter currentEnemy = allEnemies.get(i);
    currentEnemy.display(cameraX, cameraY); // Pass camera offsets
    currentEnemy.convergeOnPlayer(mainCharacter);
    if (onTarget(currentEnemy, mainCharacter)) {
      if (count % 30 == 0) {
        collisionDamage(currentEnemy, mainCharacter, 5);
      }
    }
  }
  
  count++; 
}

void gameOver(){
  if(gameOverCount == 0){
    PImage gameOver = loadImage("gameOver.png");
    PImage overlay = get();
    tint(#FF0000, 200);
    image(overlay, 0, 0);
    
    gameOver.resize(width / 2, 0);
    tint(255);
    image(gameOver, width / 4, height / 7);
    gameOverCount++;
    
    textSize(100);
    fill(255, 215, 0);
    text("Press Space to try again", width / 4 - 10, 800);
  }
}

void resetup(){
  while(allProjectiles.size() > 0){
    allProjectiles.remove(0);
  }
  while(allEnemies.size() > 0){
    allEnemies.remove(0);
  }
  image(mapBuffer, 0, 0);
  mainCharacter.setX(width / 2);
  mainCharacter.setY(height / 2);
  mainCharacter.setHP(mainCharacter.getMaxHP());
  gameOverCount = 0;
  gameOver = false;
  count = 0; 
}

void keyPressed(){
  if(gameOver == true && key == ' '){
    //System.out.println("Attempting to restart game");
    resetup();
  }
  else{
    setMove(true);
  }
}

void keyReleased() {
  setMove(false);
}

void drawHealthBar() {
    // Get player's world position (with camera offset)
    float playerScreenX = mainCharacter.getX() + cameraX;
    float playerScreenY = mainCharacter.getY() + cameraY;
    
    // Position health bar below player
    float barX = playerScreenX; // Center horizontally
    float barY = playerScreenY + 50; // Position below player
    
    // Health bar background
    fill(0);
    rect(barX, barY, 40, 5);
    
    // Health bar foreground
    fill(255, 0, 0);
    float healthWidth = 40 * ((float)mainCharacter.getHP()/mainCharacter.getMaxHP());
    rect(barX, barY, healthWidth, 5);
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

boolean onTarget(Entity entity1, Characters character) {
  if (Math.abs(entity1.getX()-character.getX()) < 15 && Math.abs(entity1.getY()-character.getY()) < 15) {
    return true;
  }
  return false;
}

void collisionDamage(Entity entity1, Characters character, int dmg) {
  if (onTarget(entity1, character)) {
    character.takeDamage(dmg);
  }
}
