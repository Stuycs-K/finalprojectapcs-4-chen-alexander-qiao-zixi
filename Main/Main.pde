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

int gameOverCount = 0; 
boolean gameOver = false;

int clockTimerSeconds;
int clockTimerMinutes;

void setup(){
  size(500, 500); // PLACEHOLDER
  background(255);
  count = 0;
  textSize(20);
  noStroke();
  clockTimerMinutes = count / 3600;
  clockTimerSeconds = (int)((count % 3600.0) / 60);
  
  //Character Construction
  PImage character1 = loadImage("character1.png");
  PImage character1Reversed = loadImage("character1Reversed.png");
  characterAssets.add(character1);
  characterAssetsReversed.add(character1Reversed);
  
  PImage character2 = loadImage("character2.png");
  PImage character2Reversed = loadImage("character2Reversed.png");
  characterAssets.add(character2);
  characterAssetsReversed.add(character2Reversed);
  
  int randomChoice = (int)random(characterAssets.size());  
  mainCharacter = new PlayerCharacter(50, width / 2, height / 2, characterAssets.get(randomChoice), characterAssetsReversed.get(randomChoice));


  
  //Filling the ArrayList of weapon assets
  PImage knife = loadImage("knife.png");
  PImage knifeReversed = loadImage("knifeReversed.png");
  weaponAssets.add(knife);
  weaponAssetsReversed.add(knifeReversed);
  weaponAssetName.add("knife");
  
  PImage fireball = loadImage("fireball.png");
  PImage fireballReversed = loadImage("fireballReversed.png");
  weaponAssets.add(fireball);
  weaponAssetsReversed.add(fireballReversed);
  weaponAssetName.add("fireball");
  
  //Filling the ArrayList of enemyAssets
  PImage enemy1 = loadImage("enemy1.png");
  PImage enemy1Reversed = loadImage("enemy1Reversed.png");
  enemyAssets.add(enemy1);
  enemyAssetsReversed.add(enemy1Reversed);
  
  PImage enemy2 = loadImage("skeletonReversed.png");
  PImage enemy2Reversed = loadImage("skeleton.png");
  enemyAssets.add(enemy2);
  enemyAssetsReversed.add(enemy2Reversed);
  
}


void draw(){
  if(mainCharacter.getHP() > 0){
    playGame();
    //if(count == 3){
    //  mainCharacter.takeDamage(mainCharacter.getHP());
    //}
  }
  else{
    gameOver();
    gameOver = true;
  }
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
  
  //Weapon Spawning testing
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
      
        knife1 = new AttackProjectile("knife", (int)mainCharacter.getX() + 10, (int)mainCharacter.getY(), weaponAssets.get(0), weaponAssetsReversed.get(0), 150, false, true, knife1Direction, mainCharacter);
        knife2 = new AttackProjectile("knife", (int)mainCharacter.getX() + 10, (int)mainCharacter.getY(), weaponAssets.get(0), weaponAssetsReversed.get(0), 150, false, true, knife2Direction, mainCharacter);
        knife3 = new AttackProjectile("knife", (int)mainCharacter.getX() + 10, (int)mainCharacter.getY(), weaponAssets.get(0), weaponAssetsReversed.get(0), 150, false, true, knife3Direction, mainCharacter);
        fireball = new AttackProjectile("fireball", (int)mainCharacter.getX() + 10, (int)mainCharacter.getY(), weaponAssets.get(1), weaponAssetsReversed.get(1), 150, true, true, fireBallDirection, mainCharacter);
      
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
      EnemyCharacter skeleton = new EnemyCharacter(20, 100, randomSpawnLocation[0], randomSpawnLocation[1], enemyAssets.get(1), enemyAssetsReversed.get(1));
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

  
        EnemyCharacter bat = new EnemyCharacter(40, 25, randomSpawnLocation[0], randomSpawnLocation[1], enemyAssets.get(0), enemyAssetsReversed.get(0));
        allEnemies.add(bat);
        EnemyCharacter bat2 = new EnemyCharacter(40, 25, randomSpawnLocation2[0], randomSpawnLocation2[1], enemyAssets.get(0), enemyAssetsReversed.get(0));
        allEnemies.add(bat2);
        EnemyCharacter bat3 = new EnemyCharacter(40, 25, randomSpawnLocation3[0], randomSpawnLocation3[1], enemyAssets.get(0), enemyAssetsReversed.get(0));
        allEnemies.add(bat3);
      }
      else if(spawnChances < chanceForDoubleSpawns){
        float[] randomSpawnLocation = setEnemyPositions();
        float[] randomSpawnLocation2 = setEnemyPositions();
  
        EnemyCharacter bat = new EnemyCharacter(40, 25, randomSpawnLocation[0], randomSpawnLocation[1], enemyAssets.get(0), enemyAssetsReversed.get(0));
        allEnemies.add(bat);
        EnemyCharacter bat2 = new EnemyCharacter(40, 25, randomSpawnLocation2[0], randomSpawnLocation2[1], enemyAssets.get(0), enemyAssetsReversed.get(0));
        allEnemies.add(bat2);
      }
      else{
        float[] randomSpawnLocation = setEnemyPositions();
        EnemyCharacter bat = new EnemyCharacter(40, 25, randomSpawnLocation[0], randomSpawnLocation[1], enemyAssets.get(0), enemyAssetsReversed.get(0));
        allEnemies.add(bat);
      }
    }
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
  
  
  for(int i = 0; i < allEnemies.size(); i++){
    EnemyCharacter currentEnemy = allEnemies.get(i);
    currentEnemy.display();
    if(currentEnemy.chargingStatus()){
      currentEnemy.updateLocation();
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
    image(gameOver, width / 4, height / 5);
    gameOverCount++;
    
    textSize(20);
    fill(255, 215, 0);
    text("Press Space to try again", 150, 400);
  }
}

void resetup(){
  while(allProjectiles.size() > 0){
    allProjectiles.remove(0);
  }
  while(allEnemies.size() > 0){
    allEnemies.remove(0);
  }
  background(255);
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
    EnemyCharacter bat1 = new EnemyCharacter(150, 10, initialX, initialY, enemyAssets.get(0), enemyAssetsReversed.get(0), true, mainCharacter);
    EnemyCharacter bat2 = new EnemyCharacter(150, 10, initialX, initialY + 35, enemyAssets.get(0), enemyAssetsReversed.get(0), true, mainCharacter);
    EnemyCharacter bat3 = new EnemyCharacter(150, 10, initialX, initialY - 35, enemyAssets.get(0), enemyAssetsReversed.get(0), true, mainCharacter);
    EnemyCharacter bat4 = new EnemyCharacter(150, 10, initialX + 35, initialY, enemyAssets.get(0), enemyAssetsReversed.get(0), true, mainCharacter);
    EnemyCharacter bat5 = new EnemyCharacter(150, 10, initialX - 35, initialY, enemyAssets.get(0), enemyAssetsReversed.get(0), true, mainCharacter);
    EnemyCharacter bat6 = new EnemyCharacter(150, 10, initialX, initialY + 70, enemyAssets.get(0), enemyAssetsReversed.get(0), true, mainCharacter);
    EnemyCharacter bat7 = new EnemyCharacter(150, 10, initialX, initialY - 70, enemyAssets.get(0), enemyAssetsReversed.get(0), true, mainCharacter);
    EnemyCharacter bat8 = new EnemyCharacter(150, 10, initialX + 35, initialY + 35, enemyAssets.get(0), enemyAssetsReversed.get(0), true, mainCharacter);
    EnemyCharacter bat9 = new EnemyCharacter(150, 10, initialX - 35, initialY + 35, enemyAssets.get(0), enemyAssetsReversed.get(0), true, mainCharacter);
    EnemyCharacter bat10 = new EnemyCharacter(150, 10, initialX + 35, initialY - 35, enemyAssets.get(0), enemyAssetsReversed.get(0), true, mainCharacter);
    EnemyCharacter bat11 = new EnemyCharacter(150, 10, initialX - 35, initialY - 35, enemyAssets.get(0), enemyAssetsReversed.get(0), true, mainCharacter);
    EnemyCharacter bat12 = new EnemyCharacter(150, 10, initialX + 70, initialY, enemyAssets.get(0), enemyAssetsReversed.get(0), true, mainCharacter);
    EnemyCharacter bat13 = new EnemyCharacter(150, 10, initialX - 70, initialY, enemyAssets.get(0), enemyAssetsReversed.get(0), true, mainCharacter);
          
    allEnemies.add(bat1);
    allEnemies.add(bat2);
    allEnemies.add(bat3);
    allEnemies.add(bat4);
    allEnemies.add(bat5);
    allEnemies.add(bat6);
    allEnemies.add(bat7);
    allEnemies.add(bat8);
    allEnemies.add(bat9);
    allEnemies.add(bat10);
    allEnemies.add(bat11);
    allEnemies.add(bat12);
    allEnemies.add(bat13);
  }
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
