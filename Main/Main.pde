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
ArrayList<EnemyCharacter> chargingEnemies = new ArrayList<EnemyCharacter>();

//Moving map stuff
float cameraX = 0;
float cameraY = 0;
int mapWidth = 30 * 128;  // Total map width (tiles * tile width)
int mapHeight = 30 * 72;
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
  size(1280, 720, P2D); // PLACEHOLDER
  PFont usedFont = createFont("DMSerifText-Regular.ttf", 50);
  textFont(usedFont);
  
 //Putting map assets into the ArrayList. 
  PImage blankTile = loadImage("grassyField1.png");
  PImage backgroundTile1 = loadImage("grassyFieldWithYellowFlowers.png");
  PImage backgroundTile2 = loadImage("grassyFieldWithYellowFlowers2.png");
  PImage backgroundTile3 = loadImage("grassyFieldWithYellowFlowers3.png");
  PImage backgroundTile4 = loadImage("grassyFieldWithYellowFlowers4.png");
  
  grassAssets.add(backgroundTile1);
  grassAssets.add(backgroundTile2);
  grassAssets.add(backgroundTile3);
  grassAssets.add(backgroundTile4);

  
  // Create a buffer for the entire map
  mapBuffer = createGraphics(mapWidth, mapHeight);
  mapBuffer.beginDraw();
  for(int i = 0; i < 20; i++){
    for(int i2 = 0; i2 < 20; i2++){
      int randomChoice = (int)random(4);
      if(randomChoice == 0){
        mapBuffer.image(grassAssets.get((int)random(grassAssets.size())), (192 * i), (108 * i2));
      }
      else{
        mapBuffer.image(blankTile, (192 * i), (108 * i2));
      }
    }
  }
  mapBuffer.endDraw();
  
  count = 7200;
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
  
  PImage bossAttack1 = loadImage("bossAttack1.png");
  bossAttack1.resize(30,0);
  PImage bossAttack1Reversed = loadImage("bossAttack1Reversed.png");
  bossAttack1Reversed.resize(30,0);
  weaponAssets.add(bossAttack1);
  weaponAssetsReversed.add(bossAttack1Reversed);
  weaponAssetName.add("bossAttack1");
  
  //Filling the ArrayList of enemyAssets
  PImage enemy1 = loadImage("enemy1.png");
  enemy1.resize(35,0);
  PImage enemy1Reversed = loadImage("enemy1Reversed.png");
  enemy1Reversed.resize(35,0);
  enemyAssets.add(enemy1);
  enemyAssetsReversed.add(enemy1Reversed);
  
  PImage enemy2 = loadImage("skeletonReversed.png");
  enemy2.resize(40, 0);
  PImage enemy2Reversed = loadImage("skeleton.png");
  enemy2Reversed.resize(40, 0);
  enemyAssets.add(enemy2);
  enemyAssetsReversed.add(enemy2Reversed);
  
  PImage enemy3 = loadImage("zombieReversed.png");
  enemy3.resize(45, 0);
  PImage enemy3Reversed = loadImage("zombie.png");
  enemy3Reversed.resize(45, 0);
  enemyAssets.add(enemy3);
  enemyAssetsReversed.add(enemy3Reversed);
  
  PImage enemy4 = loadImage("nesufrittoReversed.png");
  enemy4.resize(60, 0);
  PImage enemy4Reversed = loadImage("nesufritto.png");
  enemy4Reversed.resize(60, 0);
  enemyAssets.add(enemy4);
  enemyAssetsReversed.add(enemy4Reversed);
  
  PImage enemyBoss = loadImage("reaper.png");
  enemyBoss.resize(300,0);
  PImage enemyBossReversed = loadImage("reaperReversed.png");
  enemyBossReversed.resize(300,0);
  enemyAssets.add(enemyBoss);
  enemyAssetsReversed.add(enemyBossReversed);
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
  
  image(mapBuffer, cameraX, cameraY);
  
  updateCamera();
  
  if(clockTimerSeconds < 10){
      text(clockTimerMinutes + ":0" + clockTimerSeconds, width / 2, 75);
  }
  else{
      text(clockTimerMinutes + ":" + clockTimerSeconds, width / 2, 75);
  }
  text((int)frameRate + " frames", width - 250, 50);
  
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
        knife1Direction.setMag(200);
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
  if (count == 7200) {
    allEnemies = new ArrayList<EnemyCharacter>();
    EnemyCharacter reaper = new EnemyCharacter("reaper", 3, 1000, 100, 100, enemyAssets.get(4), enemyAssetsReversed.get(4));
    allEnemies.add(reaper);
  } else if (count < 7200) {
      if (count >= 6300) {
        if (count % (spawnRate*2) == 0 && count > spawnRate*2) {
          float[] randomSpawnLocation = setEnemyPositions();
          EnemyCharacter nesufritto = new EnemyCharacter("nesufritto", 2, 200, randomSpawnLocation[0], randomSpawnLocation[1], enemyAssets.get(3), enemyAssetsReversed.get(3));
          allEnemies.add(nesufritto);
        }
      }
      if (count >= 5400) {
        if (count % (spawnRate/2) == 0 && count > spawnRate/2) {
          float[] randomSpawnLocation = setEnemyPositions();
          EnemyCharacter zombie = new EnemyCharacter(2, 200, randomSpawnLocation[0], randomSpawnLocation[1], enemyAssets.get(2), enemyAssetsReversed.get(2));
          allEnemies.add(zombie);
        }
      }
      if(count >= 4500){
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
        if(count >= 3600){
          chanceForDoubleSpawns = 30;
          chanceForTripleSpawns = 3;
          spawnRate = 30;
        }
        else if(count >= 2700){
          chanceForDoubleSpawns = 20;
          chanceForTripleSpawns = 2;
          spawnRate = 45;
        }
        else if(count >= 1800){
          chanceForDoubleSpawns = 10;
          chanceForTripleSpawns = 1;
          spawnRate = 45;
        }
      }
      if(count % spawnRate == 0 && count > spawnRate){
        int spawnChances = (int)random(100);
        if(spawnChances < chanceForTripleSpawns){
          float[] randomSpawnLocation = setEnemyPositions();
          float[] randomSpawnLocation2 = setEnemyPositions();
          float[] randomSpawnLocation3 = setEnemyPositions();
  
          EnemyCharacter bat = new EnemyCharacter(3, 25, randomSpawnLocation[0], randomSpawnLocation[1], enemyAssets.get(0), enemyAssetsReversed.get(0));
          allEnemies.add(bat);
          EnemyCharacter bat2 = new EnemyCharacter(3, 25, randomSpawnLocation2[0], randomSpawnLocation2[1], enemyAssets.get(0), enemyAssetsReversed.get(0));
          allEnemies.add(bat2);
          EnemyCharacter bat3 = new EnemyCharacter(3, 25, randomSpawnLocation3[0], randomSpawnLocation3[1], enemyAssets.get(0), enemyAssetsReversed.get(0));
          allEnemies.add(bat3);
        }
        else if(spawnChances < chanceForDoubleSpawns){
          float[] randomSpawnLocation = setEnemyPositions();
          float[] randomSpawnLocation2 = setEnemyPositions();
  
          EnemyCharacter bat = new EnemyCharacter(3, 25, randomSpawnLocation[0], randomSpawnLocation[1], enemyAssets.get(0), enemyAssetsReversed.get(0));
          allEnemies.add(bat);
          EnemyCharacter bat2 = new EnemyCharacter(3, 25, randomSpawnLocation2[0], randomSpawnLocation2[1], enemyAssets.get(0), enemyAssetsReversed.get(0));
          allEnemies.add(bat2);
        }
        else{
          float[] randomSpawnLocation = setEnemyPositions();
          EnemyCharacter bat = new EnemyCharacter(3, 25, randomSpawnLocation[0], randomSpawnLocation[1], enemyAssets.get(0), enemyAssetsReversed.get(0));
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
    
    if (currentProjectile.getName().equals("bossAttack1")) {
      if (onTarget(currentProjectile, mainCharacter, 30)) {
        collisionDamage(mainCharacter, 25);
        if (currentProjectile.getPiercing() == false) {
          allProjectiles.remove(currentProjectile);
          index--;
          break;
        }
      }
    }
    
    for (int enemyIndex = 0; enemyIndex < allEnemies.size(); enemyIndex++) {
      if(currentProjectile.getFriendlyStatus() && onTarget(currentProjectile, allEnemies.get(enemyIndex), 30)) {
        int damage = 25;
        if (currentProjectile.getName().equals("knife")) {
          damage = 15;
        }
        collisionDamage(allEnemies.get(enemyIndex), damage);
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
      int chargingDamage;
      if (currentEnemy.getName().equals("reaper")) {
        currentEnemy.updateLocation();
        chargingDamage = 10;
        
        if (chargingEnemies.contains(currentEnemy)) {
          int hitbox = 70;
          if (onTarget(currentEnemy, mainCharacter, hitbox)) {
            collisionDamage(mainCharacter, chargingDamage);
            chargingEnemies.remove(currentEnemy);
           
            currentEnemy.setSpeed(3);
            currentEnemy.setChargingStatus(false);
          }
        }
        
        // Stop charge if it goes too far
        if (currentEnemy.getX() <= 0 || currentEnemy.getX() >= mapWidth - currentEnemy.getWidth() ||
        currentEnemy.getY() <= 0 || currentEnemy.getY() >= mapHeight - currentEnemy.getHeight() ||
        dist(currentEnemy.getX(), currentEnemy.getY(), 
            currentEnemy.getChargeStartX(), currentEnemy.getChargeStartY()) > 700) {
        currentEnemy.setSpeed(3);
        currentEnemy.setChargingStatus(false);
        chargingEnemies.remove(currentEnemy);
        }

      }
    }
    else{
      if (currentEnemy.getName().equals("nesufritto")) {
        currentEnemy.convergeNearPlayer(mainCharacter, 50);
        if (count % 300 == 0) {
          EnemyCharacter bat = new EnemyCharacter(2, 15, currentEnemy.getX(), currentEnemy.getY() + 15, enemyAssets.get(0), enemyAssetsReversed.get(0));
          EnemyCharacter bat1 = new EnemyCharacter(2, 15, currentEnemy.getX() - 15, currentEnemy.getY() - 15, enemyAssets.get(0), enemyAssetsReversed.get(0));
          EnemyCharacter bat2 = new EnemyCharacter(2, 15, currentEnemy.getX() + 15, currentEnemy.getY() - 15, enemyAssets.get(0), enemyAssetsReversed.get(0));
          allEnemies.add(bat);
          allEnemies.add(bat1);
          allEnemies.add(bat2);
        }
      } else if(currentEnemy.getName().equals("reaper")) {
        if (count % 150 == 0) {
          currentEnemy.setChargeStartPosition();
          
          PVector chargeDirection = new PVector(mainCharacter.getX() - currentEnemy.getX(), 
                                             mainCharacter.getY() - currentEnemy.getY());
          chargeDirection.normalize();
          chargeDirection.mult(1000);
          currentEnemy.setDirection(chargeDirection);
          currentEnemy.setChargingStatus(true);
          chargingEnemies.add(currentEnemy);
        } else {
          currentEnemy.convergeNearPlayer(mainCharacter, 100);
          PVector direction = new PVector(mainCharacter.getX()-currentEnemy.getX(), mainCharacter.getY()-currentEnemy.getY());
          int offset = 250;
          if (currentEnemy.getFacing()) {
            offset = 50;
          }
          if (count % 60 == 0) {
            AttackProjectile attack1Lead = new AttackProjectile("bossAttack1", (int) currentEnemy.getX() + offset, (int) currentEnemy.getY()+50, weaponAssets.get(2), weaponAssetsReversed.get(2), 1000, false, false, direction, mainCharacter);
            allProjectiles.add(attack1Lead);
          }
          if (count % 60 == 20) {
            AttackProjectile attack1Mid = new AttackProjectile("bossAttack1", (int) currentEnemy.getX() + offset, (int) currentEnemy.getY()+50, weaponAssets.get(2), weaponAssetsReversed.get(2), 1000, false, false, direction, mainCharacter);
            allProjectiles.add(attack1Mid);
          }
          if (count % 60 == 40) {
            AttackProjectile attack1Back = new AttackProjectile("bossAttack1", (int) currentEnemy.getX() + offset, (int) currentEnemy.getY()+50, weaponAssets.get(2), weaponAssetsReversed.get(2), 1000, false, false, direction, mainCharacter); 
            allProjectiles.add(attack1Back);
          }
         }
      } else {
        currentEnemy.convergeOnPlayer(mainCharacter);
      }
    }
    
    if (onTarget(currentEnemy, mainCharacter, 30)) {
      if (count % 30 == 0) {
        collisionDamage(mainCharacter, 5);
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
  textSize(50);
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
  float randomSpawnLocationX = random(mapWidth);
  float randomSpawnLocationY = random(mapHeight);
  while(randomSpawnLocationX <= mainCharacter.getX() + 200 && randomSpawnLocationX >= mainCharacter.getX() - 200){
    randomSpawnLocationX = random(mapWidth);
  }
  while(randomSpawnLocationY <= mainCharacter.getY() + 200 && randomSpawnLocationY >= mainCharacter.getY() - 200){
    randomSpawnLocationY = random(mapHeight);
  }
  float[] returnedAry = {randomSpawnLocationX, randomSpawnLocationY};
  return returnedAry;
}

void spawnSwarm(String type, String location){
  float initialX, initialY;
  int imageIndex = 0;
  if(location.equals("left")){
    initialX = mainCharacter.getX() - width/2;
    initialY = random(mapHeight);
  }
  else if(location.equals("up")){
    initialX = random(mapWidth);
    initialY = mainCharacter.getY() - height/2;
  }
  else if(location.equals("right")){
    initialX = mainCharacter.getY() + width/2;
    initialY = random(mapHeight);
  }
  else{
    initialX = random(mapWidth);
    initialY = mainCharacter.getY() + height/2;
  }
  
  if(type.equals("bat")){
    imageIndex = 0;
  }
  else if(type.equals("skeleton")){
    imageIndex = 1;
  }
  
  
  EnemyCharacter enemy1 = new EnemyCharacter(500, 10, initialX, initialY, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy2 = new EnemyCharacter(500, 10, initialX, initialY + 35, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy3 = new EnemyCharacter(500, 10, initialX, initialY - 35, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy4 = new EnemyCharacter(500, 10, initialX + 35, initialY, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy5 = new EnemyCharacter(500, 10, initialX - 35, initialY, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy6 = new EnemyCharacter(500, 10, initialX, initialY + 70, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy7 = new EnemyCharacter(500, 10, initialX, initialY - 70, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy8 = new EnemyCharacter(500, 10, initialX + 35, initialY + 35, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy9 = new EnemyCharacter(500, 10, initialX - 35, initialY + 35, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy10 = new EnemyCharacter(500, 10, initialX + 35, initialY - 35, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy11 = new EnemyCharacter(500, 10, initialX - 35, initialY - 35, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy12 = new EnemyCharacter(500, 10, initialX + 70, initialY, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy13 = new EnemyCharacter(500, 10, initialX - 70, initialY, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
         
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
  
  chargingEnemies.add(enemy1);
  chargingEnemies.add(enemy2);
  chargingEnemies.add(enemy3);
  chargingEnemies.add(enemy4);
  chargingEnemies.add(enemy5);
  chargingEnemies.add(enemy6);
  chargingEnemies.add(enemy7);
  chargingEnemies.add(enemy8);
  chargingEnemies.add(enemy9);
  chargingEnemies.add(enemy10);
  chargingEnemies.add(enemy11);
  chargingEnemies.add(enemy12);
  chargingEnemies.add(enemy13);
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

boolean onTarget(Entity entity1, Characters character, int hitbox) {
    // Calculate center coordinates
    float center1X = entity1.getX() + entity1.getWidth()/2;
    float center1Y = entity1.getY() + entity1.getHeight()/2;
    float center2X = character.getX() + character.getWidth()/2;
    float center2Y = character.getY() + character.getHeight()/2;
    
    // Check distance between centers
    float distance = dist(center1X, center1Y, center2X, center2Y);
    return distance < hitbox;
}

// precondition onTarget()
void collisionDamage(Characters character, int dmg) {
  character.takeDamage(dmg);
}
