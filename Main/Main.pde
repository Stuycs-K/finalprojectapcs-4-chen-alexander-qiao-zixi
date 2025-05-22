PlayerCharacter mainCharacter = new PlayerCharacter(); //TO BE UPDATED WHEN CONSTRUCTOR ADDED
ArrayList<EnemyCharacter> allEnemies = new ArrayList<EnemyCharacter>();
ArrayList<AttackProjectile> allProjectiles = new ArrayList<AttackProjectile>();
ArrayList<PImage> allAssets = new ArrayList<PImage>();
long startTime;
int count = 0;

void setup(){
  size(400, 400); // PLACEHOLDER
  background(0,255,0);
  startTime = System.currentTimeMillis();
}

void draw(){
  //background(0, 255, 0);
//circle(mouseX, mouseY, 50); //Circles used as placeholder for entities while partner gets it sorted out
  long currentTime = System.currentTimeMillis();
  
  System.out.println(currentTime - startTime);
  if(count == 60){
    circle(mouseX, mouseY, 50);
    count = 0;
  }
  
  
  count++; 
}
