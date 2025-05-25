PlayerCharacter mainCharacter = new PlayerCharacter(); //TO BE UPDATED WHEN CONSTRUCTOR ADDED
ArrayList<EnemyCharacter> allEnemies = new ArrayList<EnemyCharacter>();
ArrayList<AttackProjectile> allProjectiles = new ArrayList<AttackProjectile>();
ArrayList<PImage> allAssets = new ArrayList<PImage>();
int count;
boolean left, right, up, down; 

void setup(){
  size(500, 500); // PLACEHOLDER
  background(0,255,0);
  count = 0;
}

void draw(){
  //background(0, 255, 0);
  //circle(mouseX, mouseY, 50); //Circles used as placeholder for entities while partner gets it sorted out
  
  //Enemy Spawning testing
  if(count == 60){
    float chosenX = random(width);
    float chosenY = random(height);
    circle(chosenX, chosenY, 50);
    count = 0;
  }
  
  //MOVEMENT HERE WHEN IMPLEMENTED
  
  for(int i = 0; i < allEnemies.size(); i++){
    //Commented out for now while EnemyCharacter isn't implemented
    //allEnemies.get(i).convergeOnPlayer();
  }
  
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
