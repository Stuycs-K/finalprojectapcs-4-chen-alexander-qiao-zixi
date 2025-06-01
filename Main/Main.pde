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

int count;
boolean left, right, up, down; 
int gameOverCount = 0; 
boolean gameOver = false;
float playerWidth;
float playerHeight;

int clockTimerSeconds;
int clockTimerMinutes;

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
  textSize(20);
  noStroke();
  clockTimerMinutes = count / 3600;
  clockTimerSeconds = (int)((count % 3600.0) / 60);
  
  // resize character assets
  PImage character1 = loadImage("character1.png");
  character1.resize(50, 0);
  PImage character1Reversed = loadImage("character1Reversed.png");
  character1Reversed.resize(50, 0);
  characterAssets.add(character1);
  characterAssetsReversed.add(character1Reversed);
  
  PImage character2 = loadImage("character2.png");
  character2.resize(50, 0);
  PImage character2Reversed = loadImage("character2Reversed.png");
  character2Reversed.resize(50, 0);
  characterAssets.add(character2);
  characterAssetsReversed.add(character2Reversed);
  
  PImage character3 = loadImage("character3.png");
  character3.resize(50, 0);
  PImage character3Reversed = loadImage("character3Reversed.png");
  character3Reversed.resize(50, 0);
  characterAssets.add(character3);
  characterAssetsReversed.add(character3Reversed);
  
  int randomChoice = (int)random(characterAssets.size());  
  mainCharacter = new PlayerCharacter(50, width / 2, height / 2, characterAssets.get(randomChoice), characterAssetsReversed.get(randomChoice));

  playerWidth = character1.width;
  playerHeight = character1.height;

  PImage knife = loadImage("knife.png");
  knife.resize(30,0);
  PImage knifeReversed = loadImage("knifeReversed.png");
  knifeReversed.resize(30,0);
  
  weaponAssets.add(knife);
  weaponAssetsReversed.add(knifeReversed);
  weaponAssetName.add("knife");
  
  PImage fireball = loadImage("fireball.png");
  fireball.resize(30,0);
  PImage fireballReversed = loadImage("fireballReversed.png");
  fireballReversed.resize(30,0);
  weaponAssets.add(fireball);
  weaponAssetsReversed.add(fireballReversed);
  weaponAssetName.add("fireball");
  
  //Filling the ArrayList of enemyAssets
  PImage enemy1 = loadImage("enemy1.png");
  enemy1.resize(40,0);
  PImage enemy1Reversed = loadImage("enemy1Reversed.png");
  enemy1Reversed.resize(40,0);
  enemyAssets.add(enemy1);
  enemyAssetsReversed.add(enemy1Reversed);
  
  PImage enemy2 = loadImage("skeletonReversed.png");
  enemy2.resize(40, 0);
  PImage enemy2Reversed = loadImage("skeleton.png");
  enemy2Reversed.resize(40, 0);
  enemyAssets.add(enemy2);
  enemyAssetsReversed.add(enemy2Reversed);
  
  PImage enemy3 = loadImage("zombie.png");
  enemy3.resize(40, 0);
  PImage enemy3Reversed = loadImage("zombieReversed.png");
  enemy3Reversed.resize(40, 0);
  enemyAssets.add(enemy3);
  enemyAssetsReversed.add(enemy3Reversed);
  
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
    targetX = constrain(targetX, width - mapWidth, 0);
    targetY = constrain(targetY, height - mapHeight, 0);
    
    // Smooth camera movement
    cameraX = lerp(cameraX, targetX, 0.1);
    cameraY = lerp(cameraY, targetY, 0.1);
}

void playGame(){
  background(255);
  fill(0);
  if(clockTimerSeconds < 10){
      text(clockTimerMinutes + ":0" + clockTimerSeconds, width / 2, 50);
  }
  else{
      text(clockTimerMinutes + ":" + clockTimerSeconds, width / 2, 50);
  }
  text((int)frameRate + " frames", width - 100, 20);
  //circle(mouseX, mouseY, 50); //Circles used as placeholder for entities while partner gets it sorted out
  
  image(mapBuffer, cameraX, cameraY);
  
  updateCamera();
  
  // spawn weapons
  if(count % 60 == 0 && count >= 60){
      AttackProjectile knife1;
      AttackProjectile knife2;
      AttackProjectile knife3;
      AttackProjectile fireball;
      PVector fireBallDirection;
      PVector knife1Direction;
      PVector knife2Direction;
      PVector knife3Direction;
      if (mainCharacter.getDirection().mag() == 0) {
        fireBallDirection = new PVector(100, 0);
        if (mainCharacter.getFacing()) {
          fireBallDirection.x = -fireBallDirection.x;
        }
      } else {
        fireBallDirection = new PVector(mainCharacter.getDirection().x, mainCharacter.getDirection().y);
        fireBallDirection.setMag(100);
      }
        knife1Direction = new PVector(-fireBallDirection.x, -fireBallDirection.y);
        knife2Direction = knife1Direction.copy();
        knife2Direction.rotate(0.5);
        knife3Direction = knife1Direction.copy();
        knife3Direction.rotate(-0.5);
        fireBallDirection.setMag(750);
      
        knife1 = new AttackProjectile("knife", (int)mainCharacter.getX() + 10, (int)mainCharacter.getY(), weaponAssets.get(0), weaponAssetsReversed.get(0), 150, false, true, knife1Direction, mainCharacter);
        knife2 = new AttackProjectile("knife", (int)mainCharacter.getX() + 10, (int)mainCharacter.getY(), weaponAssets.get(0), weaponAssetsReversed.get(0), 150, false, true, knife2Direction, mainCharacter);
        knife3 = new AttackProjectile("knife", (int)mainCharacter.getX() + 10, (int)mainCharacter.getY(), weaponAssets.get(0), weaponAssetsReversed.get(0), 150, false, true, knife3Direction, mainCharacter);
        fireball = new AttackProjectile("fireball", (int)mainCharacter.getX() + 10, (int)mainCharacter.getY(), weaponAssets.get(1), weaponAssetsReversed.get(1), 500, true, true, fireBallDirection, mainCharacter);
      
      allProjectiles.add(knife1);
      allProjectiles.add(knife2);
      allProjectiles.add(knife3);
      allProjectiles.add(fireball);
  }
  int chanceForTripleSpawns = 0;
  int chanceForDoubleSpawns = 0;
  int spawnRate = 60;
  if(count >= 7200){
    if(count % spawnRate == 0 && count > spawnRate){
      float[] randomSpawnLocation = setEnemyPositions();
      EnemyCharacter skeleton = new EnemyCharacter(3, 100, randomSpawnLocation[0], randomSpawnLocation[1], enemyAssets.get(1), enemyAssetsReversed.get(1));
      allEnemies.add(skeleton);
      
      if((count) % (spawnRate * 15) == 0 && count > spawnRate){
        //System.out.println("BAT SWARM");
        int locationChoice = (int)random(4);
        if(locationChoice == 0){
          spawnSwarm("bat", "left");
        }
        else if(locationChoice == 1){
          spawnSwarm("bat", "up");          
        }
        else if(locationChoice == 2){
          spawnSwarm("bat", "right"); 
        }
        else{
          spawnSwarm("bat", "down");
        }
        
      }
    }
  }
  else{
    if(count >= 5400){
      chanceForDoubleSpawns = 30;
      chanceForTripleSpawns = 3;
      spawnRate = 30;
    }
    else if(count >= 3600){
      chanceForDoubleSpawns = 20;
      chanceForTripleSpawns = 2;
      spawnRate = 45;
    }
    else if(count >= 1800){
      chanceForDoubleSpawns = 10;
      chanceForTripleSpawns = 1;
      spawnRate = 45;
    }
    if(count % spawnRate == 0 && count > spawnRate){
      int spawnChances = (int)random(100);
      if(spawnChances < chanceForTripleSpawns){
        float[] randomSpawnLocation = setEnemyPositions();
        float[] randomSpawnLocation2 = setEnemyPositions();
        float[] randomSpawnLocation3 = setEnemyPositions();

  
        EnemyCharacter bat = new EnemyCharacter(7, 25, randomSpawnLocation[0], randomSpawnLocation[1], enemyAssets.get(0), enemyAssetsReversed.get(0));
        allEnemies.add(bat);
        EnemyCharacter bat2 = new EnemyCharacter(7, 25, randomSpawnLocation2[0], randomSpawnLocation2[1], enemyAssets.get(0), enemyAssetsReversed.get(0));
        allEnemies.add(bat2);
        EnemyCharacter bat3 = new EnemyCharacter(7, 25, randomSpawnLocation3[0], randomSpawnLocation3[1], enemyAssets.get(0), enemyAssetsReversed.get(0));
        allEnemies.add(bat3);
      }
      else if(spawnChances < chanceForDoubleSpawns){
        float[] randomSpawnLocation = setEnemyPositions();
        float[] randomSpawnLocation2 = setEnemyPositions();
  
        EnemyCharacter bat = new EnemyCharacter(7, 25, randomSpawnLocation[0], randomSpawnLocation[1], enemyAssets.get(0), enemyAssetsReversed.get(0));
        allEnemies.add(bat);
        EnemyCharacter bat2 = new EnemyCharacter(7, 25, randomSpawnLocation2[0], randomSpawnLocation2[1], enemyAssets.get(0), enemyAssetsReversed.get(0));
        allEnemies.add(bat2);
      }
      else{
        float[] randomSpawnLocation = setEnemyPositions();
        EnemyCharacter bat = new EnemyCharacter(7, 25, randomSpawnLocation[0], randomSpawnLocation[1], enemyAssets.get(0), enemyAssetsReversed.get(0));
        allEnemies.add(bat);
      }
    }
  }
  
  mainCharacter.display(cameraX, cameraY);
  mainCharacter.playerMovement();
  drawHealthBar();
  
  // move projectiles
  for(int index = 0; index < allProjectiles.size(); index++){
    AttackProjectile currentProjectile = allProjectiles.get(index);
    currentProjectile.monodirectionalAttack();
    currentProjectile.display(cameraX, cameraY);
    
    if(currentProjectile.getRange() <= currentProjectile.getDistanceMoved() ||
       currentProjectile.getX() < 0 || currentProjectile.getX() > mapWidth || 
       currentProjectile.getY() < 0 || currentProjectile.getY() > mapHeight) {
      allProjectiles.remove(currentProjectile);
      index--;
      continue;
    }
    
    for (int enemyIndex = 0; enemyIndex < allEnemies.size(); enemyIndex++) {
      if(onTarget(currentProjectile, allEnemies.get(enemyIndex))) {
        int damage = 50;
        if (currentProjectile.getName().equals("knife")) {
          damage = 15;
        } 
        collisionDamage(currentProjectile, allEnemies.get(enemyIndex), damage);
        if (allEnemies.get(enemyIndex).getHP() <= 0) {
          allEnemies.remove(enemyIndex);
          enemyIndex--;
        }
        if (currentProjectile.getPiercing() == false) {
          allProjectiles.remove(currentProjectile);
          index--;
          break;
        }
      }
    }
  }
  
  // move enemies
  for(int i = 0; i < allEnemies.size(); i++){
    EnemyCharacter currentEnemy = allEnemies.get(i);
    currentEnemy.display(cameraX, cameraY);
    if(currentEnemy.chargingStatus()){
      currentEnemy.updateLocation();
      if(currentEnemy.getX() > width + 300 || currentEnemy.getY() > height + 300 || currentEnemy.getX() < -300 || currentEnemy.getY() < -300){
        allEnemies.remove(i);
        i--;
      }
    }
    else{
      currentEnemy.convergeOnPlayer(mainCharacter);
    }
    
    if (onTarget(currentEnemy, mainCharacter)) {
      if (count % 30 == 0) {
        collisionDamage(currentEnemy, mainCharacter, 5);
      }
    }
  }
  
  count++;
  if(count % 60 == 0 && count >= 60){
    clockTimerSeconds++;
    //System.out.println(allEnemies.size());
  }
  if(clockTimerSeconds == 60){
    clockTimerMinutes++;
    clockTimerSeconds = 0;
  }
  
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
  clockTimerSeconds = 0;
  clockTimerMinutes = 0;
}

float[] setEnemyPositions(){
  float randomSpawnLocationX = random(width);
  float randomSpawnLocationY = random(height);
  while(randomSpawnLocationX <= mainCharacter.getX() + 50 && randomSpawnLocationX >= mainCharacter.getX() - 50){
    randomSpawnLocationX = random(width);
  }
  while(randomSpawnLocationY <= mainCharacter.getY() + 50 && randomSpawnLocationY >= mainCharacter.getY() - 50){
    randomSpawnLocationY = random(height);
  }
  float[] returnedAry = {randomSpawnLocationX, randomSpawnLocationY};
  return returnedAry;
}

void spawnSwarm(String type, String location){
  float initialX, initialY;
  int imageIndex = 0;
  if(location.equals("left")){
    initialX = -200;
    initialY = random(height);
  }
  else if(location.equals("up")){
    initialX = random(width);
    initialY = -200;
  }
  else if(location.equals("right")){
    initialX = width + 200;
    initialY = random(height);
  }
  else{
    initialX = random(width);
    initialY = height + 200;
  }
  
  if(type.equals("bat")){
    imageIndex = 0;
  }
  else if(type.equals("skeleton")){
    imageIndex = 1;
  }
  
  
  EnemyCharacter enemy1 = new EnemyCharacter(150, 10, initialX, initialY, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy2 = new EnemyCharacter(150, 10, initialX, initialY + 35, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy3 = new EnemyCharacter(150, 10, initialX, initialY - 35, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy4 = new EnemyCharacter(150, 10, initialX + 35, initialY, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy5 = new EnemyCharacter(150, 10, initialX - 35, initialY, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy6 = new EnemyCharacter(150, 10, initialX, initialY + 70, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy7 = new EnemyCharacter(150, 10, initialX, initialY - 70, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy8 = new EnemyCharacter(150, 10, initialX + 35, initialY + 35, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy9 = new EnemyCharacter(150, 10, initialX - 35, initialY + 35, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy10 = new EnemyCharacter(150, 10, initialX + 35, initialY - 35, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy11 = new EnemyCharacter(150, 10, initialX - 35, initialY - 35, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy12 = new EnemyCharacter(150, 10, initialX + 70, initialY, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy13 = new EnemyCharacter(150, 10, initialX - 70, initialY, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
         
  allEnemies.add(enemy1);
  allEnemies.add(enemy2);
  allEnemies.add(enemy3);
  allEnemies.add(enemy4);
  allEnemies.add(enemy5);
  allEnemies.add(enemy6);
  allEnemies.add(enemy7);
  allEnemies.add(enemy8);
  allEnemies.add(enemy9);
  allEnemies.add(enemy10);
  allEnemies.add(enemy11);
  allEnemies.add(enemy12);
  allEnemies.add(enemy13);
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
    float barX = mainCharacter.getX() + cameraX;
    float barY = mainCharacter.getY() + cameraY + 50;
    
    fill(0);
    rect(barX, barY, 40, 5);
    fill(255, 0, 0);
    rect(barX, barY, 40 * mainCharacter.getHP()/mainCharacter.getMaxHP(), 5);
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
