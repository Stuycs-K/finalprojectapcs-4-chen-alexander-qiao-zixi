PlayerCharacter mainCharacter = new PlayerCharacter(); //TO BE UPDATED WHEN CONSTRUCTOR ADDED
ArrayList<EnemyCharacter> allEnemies = new ArrayList<EnemyCharacter>();
ArrayList<AttackProjectile> allProjectiles = new ArrayList<AttackProjectile>();
ArrayList<PImage> allAssets = new ArrayList<PImage>();

void setup(){
  size(400, 400); // PLACEHOLDER
  background(0,255,0);
}

void draw(){
  background(0, 255, 0);
  circle(mouseX, mouseY, 50);
}
