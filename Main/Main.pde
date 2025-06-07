//Character Starting Variables
//TEST COMMENT 12
PlayerCharacter mainCharacter;
ArrayList<PImage> characterAssets = new ArrayList<PImage>();
ArrayList<PImage> characterAssetsReversed = new ArrayList<PImage>();

//Projectile Starting Variables
ArrayList<AttackProjectile> allProjectiles = new ArrayList<AttackProjectile>();
ArrayList<PImage> weaponAssets = new ArrayList<PImage>();
ArrayList<PImage> weaponAssetsReversed = new ArrayList<PImage>();

//Enemy Starting Variables
ArrayList<EnemyCharacter> allEnemies = new ArrayList<EnemyCharacter>();
ArrayList<PImage> enemyAssets = new ArrayList<PImage>();
ArrayList<PImage> enemyAssetsReversed = new ArrayList<PImage>();

//Pickup Starting Variables
ArrayList<ItemPickups> allPickups = new ArrayList<ItemPickups>();
ArrayList<PImage> pickupAssets = new ArrayList<PImage>();
ArrayList<PImage> pickupAssetsReversed = new ArrayList<PImage>();

//Moving map stuff
float cameraX = 0;
float cameraY = 0;
int mapWidth = 20 * 192;  // Total map width (tiles * tile width)
int mapHeight = 20 * 108;
PGraphics mapBuffer; // Buffer for the entire map

//Map ArrayLists for tiles. 
ArrayList<PImage> grassAssets = new ArrayList<PImage>();

//Movement and general gameplay
int count;
boolean left, right, up, down; 
boolean gameOver = false;
float playerWidth;
float playerHeight;

//AHA CHEATS.
boolean godMode = false; 

int clockTimerSeconds;
int clockTimerMinutes;

//possible end game states
int killCounter = 0; 
int chickenCounter = 0; 

//possible weapon level system
int knifeLevel = 0;
int fireballLevel = 0;
int bibleLevel = 0; 
boolean biblesSpawned = false; 

int knifeInitialLevel = 0; 
int fireballInitialLevel = 0; 
int bibleInitialLevel = 0; 

//booleans for characterSelect
boolean chosenCharacter = false;
boolean chosenStartingWeapon = false; 

void setup(){
  size(1920, 1080, P2D); // PLACEHOLDER
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
  
  count = 0;
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
  
  //int randomChoice = (int)random(characterAssets.size());  
  //mainCharacter = new PlayerCharacter(50, width / 2, height / 2, characterAssets.get(randomChoice), characterAssetsReversed.get(randomChoice));

  playerWidth = character1.width;
  playerHeight = character1.height;

  PImage knife = loadImage("knife.png");
  knife.resize(30,0);
  PImage knifeReversed = loadImage("knifeReversed.png");
  knifeReversed.resize(30,0);
  
  weaponAssets.add(knife);
  weaponAssetsReversed.add(knifeReversed);
  
  PImage fireball = loadImage("fireball.png");
  fireball.resize(30,0);
  PImage fireballReversed = loadImage("fireballReversed.png");
  fireballReversed.resize(30,0);
  weaponAssets.add(fireball);
  weaponAssetsReversed.add(fireballReversed);
  
  PImage kingBible = loadImage("bible.png");
  kingBible.resize(30,0);
  weaponAssets.add(kingBible);
  weaponAssetsReversed.add(kingBible);
  
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
  
  //Filling assets list
  PImage floorChicken = loadImage("floorChicken.png");
  floorChicken.resize(30, 0);
  pickupAssets.add(floorChicken);
  pickupAssetsReversed.add(floorChicken);
  
}

void draw(){
  if(!chosenCharacter){
    selectionScreenCharacter();
  }
  else if(!chosenStartingWeapon){
    selectionScreenWeapon();
  }
  else   if(mainCharacter.getHP() > 0){
    playGame();
    //mainCharacter.setHP(0);
  }
  else{
    drawHealthBar();
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
  
  if(knifeLevel > 10){
    knifeLevel = 10;
  }
  
  if(fireballLevel > 10){
    fireballLevel = 10;
  }
  
  if(bibleLevel > 10){
    bibleLevel = 10;
  }
  
  int knifeSpawnRate = 60; 
  int fireballSpawnRate;
  if(fireballLevel == 0){
    fireballSpawnRate = 60;
  }
  else{
    fireballSpawnRate = 60 / fireballLevel;
  }
  
  //knife spawning
  if(count % knifeSpawnRate == 0 && count >= knifeSpawnRate && knifeLevel != 0){
    
    float knifeAngles = 180 / (knifeLevel + 1) * (PI / 180);  
    if(knifeLevel % 2 == 0){
      AttackProjectile knife1;
      PVector knife1Direction;
      
      AttackProjectile knife2;
      PVector knife2Direction;
      
      if(mainCharacter.getDirection().mag() == 0){
        knife1Direction = new PVector(-100, 0);
        if(mainCharacter.getFacing()){
          knife1Direction.x = -knife1Direction.x;
        }
      }
      else{
        knife1Direction = new PVector(-mainCharacter.getDirection().x, -mainCharacter.getDirection().y);
      }
      knife1Direction.setMag(200);
      knife2Direction = knife1Direction.copy(); 
      
      knife1Direction.rotate(knifeAngles / 2);
      knife2Direction.rotate(- knifeAngles / 2);
      
      knife1 = new AttackProjectile("knife", (int)mainCharacter.getX() + 10, (int)mainCharacter.getY(), weaponAssets.get(0), weaponAssetsReversed.get(0), 150, false, true, knife1Direction, mainCharacter);
      knife2 = new AttackProjectile("knife", (int)mainCharacter.getX() + 10, (int)mainCharacter.getY(), weaponAssets.get(0), weaponAssetsReversed.get(0), 150, false, true, knife2Direction, mainCharacter);
      
      
      allProjectiles.add(knife1);
      allProjectiles.add(knife2);
      
      
      for(int i = 1; i < knifeLevel / 2; i++){
        PVector knife3Direction = knife1Direction.copy().rotate(knifeAngles * i);
        PVector knife4Direction = knife2Direction.copy().rotate(- knifeAngles * i);
        
        AttackProjectile knife3 = new AttackProjectile("knife", (int)mainCharacter.getX() + 10, (int)mainCharacter.getY(), weaponAssets.get(0), weaponAssetsReversed.get(0), 150, false, true, knife3Direction, mainCharacter);
        AttackProjectile knife4 = new AttackProjectile("knife", (int)mainCharacter.getX() + 10, (int)mainCharacter.getY(), weaponAssets.get(0), weaponAssetsReversed.get(0), 150, false, true, knife4Direction, mainCharacter);
        
        allProjectiles.add(knife3);
        allProjectiles.add(knife4);
      }
    }
    else{
      AttackProjectile knife1;
      PVector knife1Direction;
      
      if(mainCharacter.getDirection().mag() == 0){
        knife1Direction = new PVector(-100, 0);
        if(mainCharacter.getFacing()){
          knife1Direction.x = -knife1Direction.x;
        }
      }
      else{
        knife1Direction = new PVector(-mainCharacter.getDirection().x, -mainCharacter.getDirection().y);
      }
      knife1Direction.setMag(200);
      
      knife1 = new AttackProjectile("knife", (int)mainCharacter.getX() + 10, (int)mainCharacter.getY(), weaponAssets.get(0), weaponAssetsReversed.get(0), 150, false, true, knife1Direction, mainCharacter);
      allProjectiles.add(knife1);
      
      for(int i = 0; i < knifeLevel / 2; i++){
         //System.out.println("Run: " + i + " times");
         
         PVector knife2Direction;
         PVector knife3Direction;
         
         knife2Direction = knife1Direction.copy();
         knife2Direction.rotate((i + 1) * knifeAngles);
         //System.out.println("Altered by: " + ((i + 1) * knifeAngles));
         //System.out.println("Knife two direction: " + knife2Direction);
         
         knife3Direction = knife1Direction.copy();
         knife3Direction.rotate(- ((i + 1) * knifeAngles));
         //System.out.println("Altered by: " + (- ((i + 1) * knifeAngles)));
         //System.out.println("Knife 3 direction: " + knife3Direction);
         
         
         AttackProjectile knife2 = new AttackProjectile("knife", (int)mainCharacter.getX() + 10, (int)mainCharacter.getY(), weaponAssets.get(0), weaponAssetsReversed.get(0), 150, false, true, knife2Direction, mainCharacter);
         AttackProjectile knife3 = new AttackProjectile("knife", (int)mainCharacter.getX() + 10, (int)mainCharacter.getY(), weaponAssets.get(0), weaponAssetsReversed.get(0), 150, false, true, knife3Direction, mainCharacter);
         
         allProjectiles.add(knife2);
         allProjectiles.add(knife3);
      }
    }
    
  }
  
  // spawn fireballs
  if(count % fireballSpawnRate == 0 && count >= fireballSpawnRate && fireballLevel != 0){
      AttackProjectile fireball;
      PVector fireBallDirection;
      if (mainCharacter.getDirection().mag() == 0) {
        fireBallDirection = new PVector(100, 0);
        if (mainCharacter.getFacing()) {
          fireBallDirection.x = -fireBallDirection.x;
        }
      } else {
        fireBallDirection = new PVector(mainCharacter.getDirection().x, mainCharacter.getDirection().y);
      }
      fireBallDirection.setMag(750);
      
      fireball = new AttackProjectile("fireball", (int)mainCharacter.getX() + 10, (int)mainCharacter.getY(), weaponAssets.get(1), weaponAssetsReversed.get(1), 500, true, true, fireBallDirection, mainCharacter);
      allProjectiles.add(fireball);
      
        
  }
  
  //kingBibles
  if(!biblesSpawned){
    spawnBibles();
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
  
  //display pickups
  for(int i = 0; i < allPickups.size(); i++){
    allPickups.get(i).display(cameraX, cameraY);
    if(onTarget(allPickups.get(i), mainCharacter)){
      if(allPickups.get(i).getHealingStatus()){
        mainCharacter.gainHealth(allPickups.get(i).getHealing());
        chickenCounter++;
      }
      
      if(allPickups.get(i).weaponUpgradeStatus()){
        if(allPickups.get(i).getImg().equals(weaponAssets.get(0)) || allPickups.get(i).getImg().equals(weaponAssetsReversed.get(0))){
          //System.out.println("KNIFE GET");
          knifeLevel++;
        }
        else if(allPickups.get(i).getImg().equals(weaponAssets.get(1)) || allPickups.get(i).getImg().equals(weaponAssetsReversed.get(1))){
          //System.out.println("FIREBALL GET");
          fireballLevel++;
        }
        else if(allPickups.get(i).getImg().equals(weaponAssets.get(2)) || allPickups.get(i).getImg().equals(weaponAssetsReversed.get(2))){
          //System.out.println("Bible GET");
          bibleLevel++;
          removeBibles();
        }
      }
      allPickups.remove(i);
      i--;
    }
  }
  
  mainCharacter.display(cameraX, cameraY);
  mainCharacter.playerMovement();
  drawHealthBar();
  
  // move projectiles
  for(int index = 0; index < allProjectiles.size(); index++){
    AttackProjectile currentProjectile = allProjectiles.get(index);
    currentProjectile.monodirectionalAttack();
    
    if(currentProjectile.getName().equals("bible")){
      currentProjectile.getDirection().rotate((PI / 90) + ((PI/360) * bibleLevel));
      if(mainCharacter.getX() - currentProjectile.getSourceX() != 0 || mainCharacter.getY() - currentProjectile.getSourceY() != 0){
        currentProjectile.setX(currentProjectile.getX() + (mainCharacter.getX() - currentProjectile.getSourceX()));
        currentProjectile.setY(currentProjectile.getY() + (mainCharacter.getY() - currentProjectile.getSourceY()));
        currentProjectile.setSourceX(mainCharacter.getX());
        currentProjectile.setSourceY(mainCharacter.getY());
      }
      //System.out.println(currentProjectile.getDistanceMoved());
    }
    
    currentProjectile.display(cameraX, cameraY);
    
    if(currentProjectile.getRange() <= currentProjectile.getDistanceMoved() ||
      (!currentProjectile.getName().equals("bible") && (currentProjectile.getX() < 0 || currentProjectile.getX() > mapWidth || 
       currentProjectile.getY() < 0 || currentProjectile.getY() > mapHeight))) {
      allProjectiles.remove(currentProjectile);
      index--;
      continue;
   }
    
    //Checking collisions of enemies onto our weapons. 
    for (int enemyIndex = 0; enemyIndex < allEnemies.size(); enemyIndex++) {
      if(onTarget(currentProjectile, allEnemies.get(enemyIndex))) {
        int damage = 0;
        if (currentProjectile.getName().equals("knife")) {
          damage = 15;
        } 
        if (currentProjectile.getName().equals("fireball")) {
          damage = 50;
        } 
        if (currentProjectile.getName().equals("bible")) {
          damage = 10;
        } 
        collisionDamage(currentProjectile, allEnemies.get(enemyIndex), damage);
        if (allEnemies.get(enemyIndex).getHP() <= 0) {
          int randomDropChance = (int)random(100);
          if(randomDropChance > 80){
            ItemPickups weaponPickup = new ItemPickups(allEnemies.get(enemyIndex).getX(), allEnemies.get(enemyIndex).getY(), weaponAssets.get((int)random(weaponAssets.size())), weaponAssetsReversed.get((int)random(weaponAssets.size())), 0, false, true, false);
            allPickups.add(weaponPickup);
          }
          else if(randomDropChance > 75){
            ItemPickups floorChicken = new ItemPickups(allEnemies.get(enemyIndex).getX(), allEnemies.get(enemyIndex).getY(), pickupAssets.get(0), pickupAssetsReversed.get(0), 50, true, false, false);
            allPickups.add(floorChicken);
          }
          allEnemies.remove(enemyIndex);
          enemyIndex--;
          killCounter++;
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
      if(currentEnemy.getX() > mapWidth + 300 || currentEnemy.getY() > mapHeight + 300 || currentEnemy.getX() < -300 || currentEnemy.getY() < -300){
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
  
  //AHA MORE CHEATS
  if(godMode){
    mainCharacter.setHP(mainCharacter.getMaxHP());
    fill(255, 0, 0);
    textSize(50);
    text("GOD MODE ON", 50, 50);
    fill(0);
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
  if(gameOver){
    PImage gameOverScene = loadImage("gameOver.png");
    PImage overlay = get();
    tint(#FF0000, 200);
    image(overlay, 0, 0);
    
    gameOverScene.resize(width / 2, 0);
    tint(255);
    image(gameOverScene, width / 4, 100);
    gameOver = false;
    
    fill(255, 215, 0);
    textSize(50);
    text("Statistics: ", width / 4, 450);
    text("Enemies killed: " + killCounter, width / 4 + 30, 500);
    text("Floor chicken eaten: " + chickenCounter, width / 4 + 30, 550);
    text("Knife Level: " + knifeLevel, width / 4 + 30, 600);
    text("Fireball Level: " + fireballLevel, width / 4 + 30, 650);
    text("Bible Level: " + bibleLevel, width / 4 + 30, 700);
    
    
    noStroke(); 
    circle(width / 4 + 10, 485, 20);
    circle(width / 4 + 10, 535, 20);
    circle(width / 4 + 10, 585, 20);
    circle(width / 4 + 10, 635, 20);
    circle(width / 4 + 10, 685, 20);
    
    textSize(100);
    text("Press Space to try again", width / 4 - 10, 900);
  }
}

void resetup(){
  while(allProjectiles.size() > 0){
    allProjectiles.remove(0);
  }
  while(allEnemies.size() > 0){
    allEnemies.remove(0);
  }
  while(allPickups.size() > 0){
    allPickups.remove(0);
  }
  textSize(50);
  image(mapBuffer, 0, 0);
  mainCharacter.setX(width / 2);
  mainCharacter.setY(height / 2);
  mainCharacter.setHP(mainCharacter.getMaxHP());
  gameOver = false;
  count = 0;
  clockTimerSeconds = 0;
  clockTimerMinutes = 0;
  knifeLevel = knifeInitialLevel;
  fireballLevel = fireballInitialLevel;
  bibleLevel = bibleInitialLevel;
}

void selectionScreenCharacter(){
  background(75, 79, 116);
  drawGoldBorderCanvas();
  textAlign(CENTER);
  textSize(50);
  fill(255);
  text("CHOOSE YOUR CHARACTER", width / 2, 60);
  characterFrame(200, 200);
  imageMode(CENTER);
  PImage possibleCharacter1 = loadImage("character1.png");
  possibleCharacter1.resize(180, 0);
  image(possibleCharacter1, 200, 200);
  
  characterFrame(200, 500);
  PImage possibleCharacter2 = loadImage("character2.png");
  possibleCharacter2.resize(180, 0);
  image(possibleCharacter2, 200, 500);
  
  characterFrame(200, 800);
  PImage possibleCharacter3 = loadImage("character3.png");
  possibleCharacter3.resize(180, 0);
  image(possibleCharacter3, 200, 800);
}

void selectionScreenWeapon(){
  background(75, 79, 116);
  drawGoldBorderCanvas();
  textAlign(CENTER);
  textSize(50);
  fill(255);
  text("CHOOSE YOUR STARTING WEAPON", width / 2, 60);
  
  characterFrame(200, 200);
  imageMode(CENTER);
  PImage possibleWeapon1 = loadImage("knife.png");
  possibleWeapon1.resize(180, 0);
  image(possibleWeapon1, 200, 200);
  
  characterFrame(200, 500);
  PImage possibleWeapon2 = loadImage("fireball.png");
  possibleWeapon2.resize(180, 0);
  image(possibleWeapon2, 200, 500);
  
  characterFrame(200, 800);
  PImage possibleWeapon3 = loadImage("bible.png");
  possibleWeapon3.resize(180, 0);
  image(possibleWeapon3, 200, 800);
  
}

void drawGoldBorderCanvas(){
  fill(216, 179, 105);
  rect(0, 0, width, 9);
  rect(0, 0, 9, height);
  rect(width - 10, 0, 9, height);
  rect(0, height - 10, width, 9);
  
  fill(168, 113, 31);
  rect(0, 0, width, 6);
  rect(0, 0, 6, height);
  rect(width - 10, 0, 6, height);
  rect(0, height - 10, width, 6);
  
  fill(88, 63, 65);
  rect(0, 0, width, 3);
  rect(0, 0, 3, height);
  rect(width - 10, 0, 3, height);
  rect(0, height - 10, width, 3);
}

void characterFrame(int x, int y){
  rectMode(RADIUS);
  fill(88, 63, 65);
  rect(x, y, 100, 100);
  fill(168, 113, 31);
  rect(x, y, 98, 98);
  fill(216, 179, 105);
  rect(x, y, 96, 96);
  fill(139, 139, 139);
  rect(x, y, 94, 94);
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
    initialX = -200;
    initialY = random(mapHeight);
  }
  else if(location.equals("up")){
    initialX = random(mapWidth);
    initialY = -200;
  }
  else if(location.equals("right")){
    initialX = mapWidth + 200;
    initialY = random(mapHeight);
  }
  else{
    initialX = random(mapWidth);
    initialY = mapHeight + 200;
  }
  
  if(type.equals("bat")){
    imageIndex = 0;
  }
  else if(type.equals("skeleton")){
    imageIndex = 1;
  }
  
  
  EnemyCharacter enemy1 = new EnemyCharacter(500, 0, initialX, initialY, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
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
}

//BIBLE HELPER METHODS
void spawnBibles(){
  float bibleAngle = (360 / (bibleLevel + 3)) * (PI / 180);
  PVector bibleDirection = new PVector(200 + (50 * bibleLevel), 0);
    PVector bibleLocation = new PVector(5, -120 + (60 + (bibleLevel / 2)));
    
    for(int i = 0; i < bibleLevel + 3; i++){
      PVector newBibleDirection = bibleDirection.copy();
      PVector newBibleLocation = bibleLocation.copy();
      newBibleDirection.rotate(bibleAngle * i);
      newBibleLocation.rotate(bibleAngle * i);
      AttackProjectile bible1 = new AttackProjectile("bible", (int)(mainCharacter.getX() + newBibleLocation.x), (int)(mainCharacter.getY() + newBibleLocation.y), weaponAssets.get(2), weaponAssets.get(2), Integer.MAX_VALUE, true, true, newBibleDirection, mainCharacter);
      allProjectiles.add(bible1);
    }
    
    biblesSpawned = true; 
}

void removeBibles(){
  for(int i = 0; i < allProjectiles.size(); i++){
    if(allProjectiles.get(i).getName().equals("bible")){
      //System.out.println("Something is remove");
      allProjectiles.remove(i);
      i--;
    }
  }
  biblesSpawned = false;
}

void keyPressed(){
  if(gameOver == true && key == ' '){
    //System.out.println("Attempting to restart game");
    resetup();
  }
  else if(gameOver == false && key == '='){
    godMode = !godMode;
  }
  else if(key == 'k'){
    knifeLevel++;
  }
  else if(key == 'f'){
    fireballLevel++;
  }
  else if(key == 'b'){
    bibleLevel++;
    removeBibles();
  }
  else if(key == '-'){
    mainCharacter.setHP(0);
  }
  else{
    setMove(true);
  }
}

void keyReleased() {
  setMove(false);
}

void mouseClicked(){
  if(!chosenCharacter){
    if(mouseX > 100 && mouseX < 300 && mouseY > 100 && mouseY < 300){      
      mainCharacter = new PlayerCharacter(50, width / 2, height / 2, characterAssets.get(0), characterAssetsReversed.get(0));
      chosenCharacter = true;
      imageMode(CORNER);
      textAlign(LEFT);
      rectMode(CORNER);
    }
    else if(mouseX > 100 && mouseX < 300 && mouseY > 400 && mouseY < 600){
      mainCharacter = new PlayerCharacter(50, width / 2, height / 2, characterAssets.get(1), characterAssetsReversed.get(1));
      chosenCharacter = true;
      imageMode(CORNER);
      textAlign(LEFT);
      rectMode(CORNER);
    }
    
    else if(mouseX > 100 && mouseX < 300 && mouseY > 700 && mouseY < 900){
      mainCharacter = new PlayerCharacter(50, width / 2, height / 2, characterAssets.get(2), characterAssetsReversed.get(2));
      chosenCharacter = true;
      imageMode(CORNER);
      textAlign(LEFT);
      rectMode(CORNER);
    }
  }
  else if(!chosenStartingWeapon){
    if(mouseX > 100 && mouseX < 300 && mouseY > 100 && mouseY < 300){
      chosenStartingWeapon = true;
      imageMode(CORNER);
      textAlign(LEFT);
      rectMode(CORNER);
      knifeLevel++;
      knifeInitialLevel++;
    }
    
    else if(mouseX > 100 && mouseX < 300 && mouseY > 400 && mouseY < 600){
      chosenStartingWeapon = true;
      imageMode(CORNER);
      textAlign(LEFT);
      rectMode(CORNER);
      fireballLevel++;
      fireballInitialLevel++;
    }
    else if(mouseX > 100 && mouseX < 300 && mouseY > 700 && mouseY < 900){
      chosenStartingWeapon = true;
      imageMode(CORNER);
      textAlign(LEFT);
      rectMode(CORNER);
      bibleLevel++;
      bibleInitialLevel++;
    }
  }
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
