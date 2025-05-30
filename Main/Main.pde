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
        fireball = new AttackProjectile("fireball", (int)mainCharacter.getX() + 10, (int)mainCharacter.getY(), weaponAssets.get(1), weaponAssets.get(1), 150, true, true, fireBallDirection, mainCharacter);
      
      allProjectiles.add(knife1);
      allProjectiles.add(knife2);
      allProjectiles.add(knife3);
      allProjectiles.add(fireball);
  }
  
  if(count % 30 == 0 && count >= 30){
    float randomSpawnLocationX = random(width);
    float randomSpawnLocationY = random(height);
    while(randomSpawnLocationX <= mainCharacter.getX() + 50 && randomSpawnLocationX >= mainCharacter.getX() - 50){
      randomSpawnLocationX = random(width);
    }
    while(randomSpawnLocationY <= mainCharacter.getY() + 50 && randomSpawnLocationY >= mainCharacter.getY() - 50){
      randomSpawnLocationY = random(height);
    }
    EnemyCharacter bat = new EnemyCharacter(25, 25, randomSpawnLocationX, randomSpawnLocationY, enemyAssets.get(0), enemyAssetsReversed.get(0));
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
        }
      }
    }
  }
  
  
  for(int i = 0; i < allEnemies.size(); i++){
    EnemyCharacter currentEnemy = allEnemies.get(i);
    currentEnemy.display();
    currentEnemy.convergeOnPlayer(mainCharacter);
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
