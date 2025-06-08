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
EnemyCharacter reaper;

//Pickup Starting Variables
ArrayList<ItemPickups> allPickups = new ArrayList<ItemPickups>();
ArrayList<PImage> pickupAssets = new ArrayList<PImage>();
ArrayList<PImage> pickupAssetsReversed = new ArrayList<PImage>();

//Moving map stuff
float cameraX = 0;
float cameraY = 0;
int mapWidth = 30 * 128;  // Total map width (tiles * tile width)
int mapHeight = 30 * 72;
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
boolean timeStop = false;

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

void setup() {
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
  for (int i = 0; i < 20; i++) {
    for (int i2 = 0; i2 < 20; i2++) {
      int randomChoice = (int)random(4);
      if (randomChoice == 0) {
        mapBuffer.image(grassAssets.get((int)random(grassAssets.size())), (192 * i), (108 * i2));
      } else {
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
  knife.resize(30, 0);
  PImage knifeReversed = loadImage("knifeReversed.png");
  knifeReversed.resize(30, 0);

  weaponAssets.add(knife);
  weaponAssetsReversed.add(knifeReversed);

  PImage fireball = loadImage("fireball.png");
  fireball.resize(30, 0);
  PImage fireballReversed = loadImage("fireballReversed.png");
  fireballReversed.resize(30, 0);
  weaponAssets.add(fireball);
  weaponAssetsReversed.add(fireballReversed);

  PImage kingBible = loadImage("bible.png");
  kingBible.resize(30, 0);
  weaponAssets.add(kingBible);
  weaponAssetsReversed.add(kingBible);

  PImage bossAttack1 = loadImage("bossAttack1.png");
  bossAttack1.resize(30, 0);
  PImage bossAttack1Reversed = loadImage("bossAttack1Reversed.png");
  bossAttack1Reversed.resize(30, 0);
  weaponAssets.add(bossAttack1);
  weaponAssetsReversed.add(bossAttack1Reversed);
  weaponAssetName.add("bossAttack1");

  PImage trident = loadImage("trident.png");
  trident.resize(40, 0);
  PImage tridentReversed = loadImage("tridentReversed.png");
  tridentReversed.resize(40, 0);
  weaponAssets.add(trident);
  weaponAssetsReversed.add(tridentReversed);
  weaponAssetName.add("trident");

  PImage strongerTrident = loadImage("trident.png");
  strongerTrident.resize(50, 0);
  PImage strongerTridentReversed = loadImage("tridentReversed.png");
  strongerTridentReversed.resize(50, 0);
  weaponAssets.add(strongerTrident);
  weaponAssetsReversed.add(strongerTridentReversed);
  weaponAssetName.add("strongerTrident");

  //Filling the ArrayList of enemyAssets
  PImage enemy1 = loadImage("enemy1.png");
  enemy1.resize(35, 0);
  PImage enemy1Reversed = loadImage("enemy1Reversed.png");
  enemy1Reversed.resize(35, 0);
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
  enemyBoss.resize(300, 0);
  PImage enemyBossReversed = loadImage("reaperReversed.png");
  enemyBossReversed.resize(300, 0);
  enemyAssets.add(enemyBoss);
  enemyAssetsReversed.add(enemyBossReversed);

  PImage enemyBossMob = loadImage("skeletonReversed.png");
  enemy2.resize(60, 0);
  PImage enemyBossMobReversed = loadImage("skeleton.png");
  enemy2Reversed.resize(60, 0);
  enemyAssets.add(enemyBossMob);
  enemyAssetsReversed.add(enemyBossMobReversed);

  reaper = new EnemyCharacter("reaper", 4, 15000, 100, 100, enemyAssets.get(4), enemyAssetsReversed.get(4));

  PImage enemy5 = loadImage("tritont.png");
  enemy5.resize(65, 0);
  PImage enemy5Reversed = loadImage("tritontReversed.png");
  enemy5Reversed.resize(65, 0);
  enemyAssets.add(enemy5);
  enemyAssetsReversed.add(enemy5Reversed);

  PImage strongerBat = loadImage("enemy1.png");
  strongerBat.resize(45, 0);
  PImage strongerBatReversed = loadImage("enemy1Reversed.png");
  strongerBatReversed.resize(45, 0);
  enemyAssets.add(strongerBat);
  enemyAssetsReversed.add(strongerBatReversed);

  //Filling assets list
  PImage floorChicken = loadImage("floorChicken.png");
  floorChicken.resize(30, 0);
  pickupAssets.add(floorChicken);
  pickupAssetsReversed.add(floorChicken);
}

void draw() {
  if (!chosenCharacter) {
    selectionScreenCharacter();
  } else if (!chosenStartingWeapon) {
    selectionScreenWeapon();
  } else if (mainCharacter.getHP() > 0 && reaper.getHP() > 0) {
    playGame();
    //mainCharacter.setHP(0);
  } else {
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

void playGame() {
  background(255);
  fill(0);

  image(mapBuffer, cameraX, cameraY);

  updateCamera();

  if (clockTimerSeconds < 10) {
    text(clockTimerMinutes + ":0" + clockTimerSeconds, width / 2, 75);
  } else {
    text(clockTimerMinutes + ":" + clockTimerSeconds, width / 2, 75);
  }
  text((int)frameRate + " frames", width - 250, 50);

  if (knifeLevel > 10) {
    knifeLevel = 10;
  }

  if (fireballLevel > 10) {
    fireballLevel = 10;
  }

  if (bibleLevel > 10) {
    bibleLevel = 10;
  }

  int knifeSpawnRate = 60;
  int fireballSpawnRate;
  if (fireballLevel == 0) {
    fireballSpawnRate = 60;
  } else {
    fireballSpawnRate = 60 / fireballLevel;
  }

  //knife spawning
  if (count % knifeSpawnRate == 0 && count >= knifeSpawnRate && knifeLevel != 0) {

    float knifeAngles = 180 / (knifeLevel + 1) * (PI / 180);
    if (knifeLevel % 2 == 0) {
      AttackProjectile knife1;
      PVector knife1Direction;

      AttackProjectile knife2;
      PVector knife2Direction;

      if (mainCharacter.getDirection().mag() == 0) {
        knife1Direction = new PVector(-100, 0);
        if (mainCharacter.getFacing()) {
          knife1Direction.x = -knife1Direction.x;
        }
      } else {
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


      for (int i = 1; i < knifeLevel / 2; i++) {
        PVector knife3Direction = knife1Direction.copy().rotate(knifeAngles * i);
        PVector knife4Direction = knife2Direction.copy().rotate(- knifeAngles * i);

        AttackProjectile knife3 = new AttackProjectile("knife", (int)mainCharacter.getX() + 10, (int)mainCharacter.getY(), weaponAssets.get(0), weaponAssetsReversed.get(0), 150, false, true, knife3Direction, mainCharacter);
        AttackProjectile knife4 = new AttackProjectile("knife", (int)mainCharacter.getX() + 10, (int)mainCharacter.getY(), weaponAssets.get(0), weaponAssetsReversed.get(0), 150, false, true, knife4Direction, mainCharacter);

        allProjectiles.add(knife3);
        allProjectiles.add(knife4);
      }
    } else {
      AttackProjectile knife1;
      PVector knife1Direction;

      if (mainCharacter.getDirection().mag() == 0) {
        knife1Direction = new PVector(-100, 0);
        if (mainCharacter.getFacing()) {
          knife1Direction.x = -knife1Direction.x;
        }
      } else {
        knife1Direction = new PVector(-mainCharacter.getDirection().x, -mainCharacter.getDirection().y);
      }
      knife1Direction.setMag(200);

      knife1 = new AttackProjectile("knife", (int)mainCharacter.getX() + 10, (int)mainCharacter.getY(), weaponAssets.get(0), weaponAssetsReversed.get(0), 150, false, true, knife1Direction, mainCharacter);
      allProjectiles.add(knife1);

      for (int i = 0; i < knifeLevel / 2; i++) {
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
  if (count % fireballSpawnRate == 0 && count >= fireballSpawnRate && fireballLevel != 0) {
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
  if (!biblesSpawned && bibleLevel != 0) {
    spawnBibles();
  }



  int chanceForTripleSpawns = 0;
  int chanceForDoubleSpawns = 0;
  int spawnRate = 60;
  if (count > 9240) {
    if (count % 120 == 0) {
      EnemyCharacter larry = new EnemyCharacter(3, 1000, reaper.getX() + 200, reaper.getY() - 50, enemyAssets.get(5), enemyAssetsReversed.get(5));
      allEnemies.add(larry);
      EnemyCharacter skeletor = new EnemyCharacter(3, 1000, reaper.getX() - 200, reaper.getY() - 50, enemyAssets.get(5), enemyAssetsReversed.get(5));
      allEnemies.add(skeletor);
      EnemyCharacter lawrie = new EnemyCharacter(3, 1000, reaper.getX(), reaper.getY() + 300, enemyAssets.get(5), enemyAssetsReversed.get(5));
      allEnemies.add(lawrie);
    }
  }
  if (count == 9120) {
    allEnemies.add(reaper);
  }
  if (count == 9000) {
    allEnemies = new ArrayList<EnemyCharacter>();
    allPickups = new ArrayList<ItemPickups>();
  } else if (count < 7650) {
    if (count >= 6300) {
      if (count % (spawnRate) == 0 && count > spawnRate) {
        float[] randomSpawnLocation = setEnemyPositions();
        EnemyCharacter nesufritto = new EnemyCharacter("nesufritto", 2, 400, randomSpawnLocation[0], randomSpawnLocation[1], enemyAssets.get(3), enemyAssetsReversed.get(3));
        allEnemies.add(nesufritto);
      }
    }
    if (count >= 5400) {
      if (count % (spawnRate/2) == 0 && count > spawnRate/2) {
        float[] randomSpawnLocation = setEnemyPositions();
        EnemyCharacter zombie = new EnemyCharacter(2, 750, randomSpawnLocation[0], randomSpawnLocation[1], enemyAssets.get(2), enemyAssetsReversed.get(2));
        allEnemies.add(zombie);
      }
    }
    if (count >= 4500) {
      if (count % spawnRate == 0 && count > spawnRate) {
        float[] randomSpawnLocation = setEnemyPositions();
        EnemyCharacter skeleton = new EnemyCharacter(3, 350, randomSpawnLocation[0], randomSpawnLocation[1], enemyAssets.get(1), enemyAssetsReversed.get(1));
        allEnemies.add(skeleton);

        if ((count) % (spawnRate * 15) == 0 && count > spawnRate) {
          //System.out.println("BAT SWARM");
          int locationChoice = (int)random(4);
          if (locationChoice == 0) {
            spawnSwarm("bat", "left");
          } else if (locationChoice == 1) {
            spawnSwarm("bat", "up");
          } else if (locationChoice == 2) {
            spawnSwarm("bat", "right");
          } else {
            spawnSwarm("bat", "down");
          }
        }
      }
    }
    if (count >= 3600 && count % 250 == 0) {
      float[] randomSpawnLocation = setEnemyPositions();
      EnemyCharacter tritont = new EnemyCharacter("tritont", 3, 250, randomSpawnLocation[0], randomSpawnLocation[1], enemyAssets.get(6), enemyAssetsReversed.get(6));
      allEnemies.add(tritont);
    } else if (count >= 1800) {
      if (count % 100 == 0) {
        float[] randomSpawnLocation = setEnemyPositions();
        EnemyCharacter tritont = new EnemyCharacter("tritont", 2, 100, randomSpawnLocation[0], randomSpawnLocation[1], enemyAssets.get(6), enemyAssetsReversed.get(6));
        allEnemies.add(tritont);
      }
    }
    if (count >= 2700) {
      chanceForDoubleSpawns = 30;
      chanceForTripleSpawns = 3;
      spawnRate = 30;
    } else if (count >= 1800) {
      chanceForDoubleSpawns = 20;
      chanceForTripleSpawns = 2;
      spawnRate = 45;
    } else if (count >= 900) {
      chanceForDoubleSpawns = 10;
      chanceForTripleSpawns = 1;
      spawnRate = 45;
    }
    if (count % spawnRate == 0 && count > spawnRate) {
      int spawnChances = (int)random(100);
      if (spawnChances < chanceForTripleSpawns) {
        float[] randomSpawnLocation = setEnemyPositions();
        float[] randomSpawnLocation2 = setEnemyPositions();
        float[] randomSpawnLocation3 = setEnemyPositions();

        EnemyCharacter bat = new EnemyCharacter(3, 25, randomSpawnLocation[0], randomSpawnLocation[1], enemyAssets.get(0), enemyAssetsReversed.get(0));
        allEnemies.add(bat);
        EnemyCharacter bat2 = new EnemyCharacter(3, 25, randomSpawnLocation2[0], randomSpawnLocation2[1], enemyAssets.get(0), enemyAssetsReversed.get(0));
        allEnemies.add(bat2);
        EnemyCharacter bat3 = new EnemyCharacter(3, 25, randomSpawnLocation3[0], randomSpawnLocation3[1], enemyAssets.get(0), enemyAssetsReversed.get(0));
        allEnemies.add(bat3);
      } else if (spawnChances < chanceForDoubleSpawns) {
        float[] randomSpawnLocation = setEnemyPositions();
        float[] randomSpawnLocation2 = setEnemyPositions();

        EnemyCharacter bat = new EnemyCharacter(3, 25, randomSpawnLocation[0], randomSpawnLocation[1], enemyAssets.get(0), enemyAssetsReversed.get(0));
        allEnemies.add(bat);
        EnemyCharacter bat2 = new EnemyCharacter(3, 25, randomSpawnLocation2[0], randomSpawnLocation2[1], enemyAssets.get(0), enemyAssetsReversed.get(0));
        allEnemies.add(bat2);
      } else {
        float[] randomSpawnLocation = setEnemyPositions();
        EnemyCharacter bat = new EnemyCharacter(3, 25, randomSpawnLocation[0], randomSpawnLocation[1], enemyAssets.get(0), enemyAssetsReversed.get(0));
        allEnemies.add(bat);
      }
    }
  }


  //display pickups
  for (int i = 0; i < allPickups.size(); i++) {
    allPickups.get(i).display(cameraX, cameraY);
    if (onTarget(allPickups.get(i), mainCharacter, 30)) {
      if (allPickups.get(i).getHealingStatus()) {
        mainCharacter.gainHealth(allPickups.get(i).getHealing());
        chickenCounter++;
      }

      if (allPickups.get(i).weaponUpgradeStatus()) {
        if (allPickups.get(i).getImg().equals(weaponAssets.get(0)) || allPickups.get(i).getImg().equals(weaponAssetsReversed.get(0))) {
          //System.out.println("KNIFE GET");
          knifeLevel++;
        } else if (allPickups.get(i).getImg().equals(weaponAssets.get(1)) || allPickups.get(i).getImg().equals(weaponAssetsReversed.get(1))) {
          //System.out.println("FIREBALL GET");
          fireballLevel++;
        } else if (allPickups.get(i).getImg().equals(weaponAssets.get(2)) || allPickups.get(i).getImg().equals(weaponAssetsReversed.get(2))) {
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
  for (int index = 0; index < allProjectiles.size(); index++) {
    AttackProjectile currentProjectile = allProjectiles.get(index);
    currentProjectile.monodirectionalAttack();

    if (currentProjectile.getName().equals("bible")) {
      currentProjectile.getDirection().rotate((PI / 90) + ((PI/360) * bibleLevel));
      if (mainCharacter.getX() - currentProjectile.getSourceX() != 0 || mainCharacter.getY() - currentProjectile.getSourceY() != 0) {
        currentProjectile.setX(currentProjectile.getX() + (mainCharacter.getX() - currentProjectile.getSourceX()));
        currentProjectile.setY(currentProjectile.getY() + (mainCharacter.getY() - currentProjectile.getSourceY()));
        currentProjectile.setSourceX(mainCharacter.getX());
        currentProjectile.setSourceY(mainCharacter.getY());
      }
      //System.out.println(currentProjectile.getDistanceMoved());
    }

    currentProjectile.display(cameraX, cameraY);

    if (currentProjectile.getRange() <= currentProjectile.getDistanceMoved() ||
      (!currentProjectile.getName().equals("bible") && (currentProjectile.getX() < 0 || currentProjectile.getX() > mapWidth ||
      currentProjectile.getY() < 0 || currentProjectile.getY() > mapHeight))) {
      allProjectiles.remove(currentProjectile);
      index--;
      continue;
    }

    for (int enemyIndex = 0; enemyIndex < allEnemies.size(); enemyIndex++) {
      if (currentProjectile.getFriendlyStatus() && onTarget(currentProjectile, allEnemies.get(enemyIndex), 30)) {
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
        collisionDamage(allEnemies.get(enemyIndex), damage);

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
        if (allEnemies.get(enemyIndex).getHP() <= 0) {
          int randomDropChance = (int)random(100);
          if (randomDropChance > 85) {
            ItemPickups weaponPickup = new ItemPickups(allEnemies.get(enemyIndex).getX(), allEnemies.get(enemyIndex).getY(), weaponAssets.get((int)random(3)), weaponAssetsReversed.get((int)random(3)), 0, false, true, false);
            allPickups.add(weaponPickup);
          } else if (randomDropChance > 75) {
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
    if (!currentProjectile.getFriendlyStatus() && onTarget(currentProjectile, mainCharacter, 30)) {
      int damage = 25;
      if (count >= 3600) damage = 35;
      collisionDamage(mainCharacter, damage);
      if (currentProjectile.getPiercing() == false) {
        allProjectiles.remove(currentProjectile);
        index--;
      }
    }
  }


  // move enemies
  for (int i = 0; i < allEnemies.size(); i++) {
    EnemyCharacter currentEnemy = allEnemies.get(i);
    currentEnemy.display(cameraX, cameraY);

    if (currentEnemy.chargingStatus()) {
      int chargingDamage = 1;
      if (currentEnemy.getName().equals("reaper")) {
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
      currentEnemy.updateLocation();
    } else {
      if (currentEnemy.getName().equals("nesufritto")) {
        currentEnemy.convergeNearPlayer(mainCharacter, 350);
        if (count % 300 == 0) {
          EnemyCharacter bat = new EnemyCharacter(4, 250, currentEnemy.getX(), currentEnemy.getY() + 35, enemyAssets.get(7), enemyAssetsReversed.get(7));
          EnemyCharacter bat1 = new EnemyCharacter(4, 250, currentEnemy.getX() - 35, currentEnemy.getY() - 35, enemyAssets.get(7), enemyAssetsReversed.get(7));
          EnemyCharacter bat2 = new EnemyCharacter(4, 250, currentEnemy.getX() + 35, currentEnemy.getY() - 35, enemyAssets.get(7), enemyAssetsReversed.get(7));
          allEnemies.add(bat);
          allEnemies.add(bat1);
          allEnemies.add(bat2);
        }
      } else if (currentEnemy.getName().equals("reaper")) {
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
          if (direction.mag() < 250) {
            direction.setMag(500);
          } else {
            direction.mult(1.5);
          }
          int offset = 250;
          if (currentEnemy.getFacing()) {
            offset = 50;
          }
          if (count % 60 == 0) {
            AttackProjectile attack1Lead = new AttackProjectile("bossAttack1", (int) currentEnemy.getX() + offset, (int) currentEnemy.getY()+50, weaponAssets.get(3), weaponAssetsReversed.get(3), 1000, false, false, direction, mainCharacter);
            allProjectiles.add(attack1Lead);
          }
          if (count % 60 == 20) {
            AttackProjectile attack1Mid = new AttackProjectile("bossAttack1", (int) currentEnemy.getX() + offset, (int) currentEnemy.getY()+50, weaponAssets.get(3), weaponAssetsReversed.get(3), 1000, false, false, direction, mainCharacter);
            allProjectiles.add(attack1Mid);
          }
          if (count % 60 == 40) {
            AttackProjectile attack1Back = new AttackProjectile("bossAttack1", (int) currentEnemy.getX() + offset, (int) currentEnemy.getY()+50, weaponAssets.get(3), weaponAssetsReversed.get(3), 1000, false, false, direction, mainCharacter);
            allProjectiles.add(attack1Back);
          }
        }
      } else if (currentEnemy.getName().equals("tritont")) {
        currentEnemy.convergeNearPlayer(mainCharacter, 250);
        if (count % 200 == 0) {
          PVector direction = new PVector(mainCharacter.getX() - currentEnemy.getX() + (float)(2*Math.random()-1), mainCharacter.getY() - currentEnemy.getY()+(float)(2*Math.random()-1));
          direction.setMag(500);
          if (count >= 3600) {
            AttackProjectile trident = new AttackProjectile("trident", (int)currentEnemy.getX() + 15, (int)currentEnemy.getY(), weaponAssets.get(5), weaponAssetsReversed.get(5), 1000, false, false, direction, currentEnemy);
            allProjectiles.add(trident);
          } else {
            AttackProjectile trident = new AttackProjectile("trident", (int)currentEnemy.getX() + 10, (int)currentEnemy.getY(), weaponAssets.get(4), weaponAssetsReversed.get(4), 700, false, false, direction, currentEnemy);
            allProjectiles.add(trident);
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

  //AHA MORE CHEATS
  if (godMode) {
    mainCharacter.setHP(mainCharacter.getMaxHP());
    fill(255, 0, 0);
    textSize(50);
    text("GOD MODE ON", 50, 50);
    fill(0);
  }

  if (!timeStop) {
    count++;
    if (count % 60 == 0 && count >= 60) {
      clockTimerSeconds++;
      //System.out.println(allEnemies.size());
    }
    if (clockTimerSeconds == 60) {
      clockTimerMinutes++;
      clockTimerSeconds = 0;
    }
  }
}

void gameOver() {
  if (gameOver) {
    PImage overlay = get();
    gameOver = false;
    textAlign(CENTER);

    if (mainCharacter.getHP() == 0) {
      PImage gameOverScene = loadImage("gameOver.png");
      tint(#FF0000, 200);
      image(overlay, 0, 0);

      gameOverScene.resize(width / 2, 0);
      tint(255);
      image(gameOverScene, width / 4, 100);

      fill(255, 215, 0);
      textSize(100);
      text("Press Space to try again", width / 2, height - 200);
    } else if (reaper.getHP() <= 0) {
      PImage victory = loadImage("victory.png");
      tint(#00FF00, 200);
      image(overlay, 0, 0);

      victory.resize(width / 2, 0);
      tint(255);
      image(victory, width / 4, -250);

      textSize(100);
      fill(255, 215, 0);
      text("Press Space to play again", width / 2, height - 200);
    }

    textSize(50);
    textAlign(LEFT);
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
  }
}

void resetup() {
  while (allProjectiles.size() > 0) {
    allProjectiles.remove(0);
  }
  while (allEnemies.size() > 0) {
    allEnemies.remove(0);
  }
  while (allPickups.size() > 0) {
    allPickups.remove(0);
  }
  textSize(50);
  image(mapBuffer, 0, 0);
  mainCharacter.setX(width / 2);
  mainCharacter.setY(height / 2);
  mainCharacter.setHP(mainCharacter.getMaxHP());
  reaper = new EnemyCharacter("reaper", 4, 15000, 100, 100, enemyAssets.get(4), enemyAssetsReversed.get(4));
  gameOver = false;
  count = 0;
  clockTimerSeconds = 0;
  clockTimerMinutes = 0;
  knifeLevel = knifeInitialLevel;
  fireballLevel = fireballInitialLevel;
  bibleLevel = bibleInitialLevel;
  biblesSpawned = false;
  killCounter = 0;
  chickenCounter = 0;
  timeStop = false; 

  textAlign(LEFT);
}

void selectionScreenCharacter() {
  background(75, 79, 116);
  drawGoldBorderCanvas();
  textAlign(CENTER);
  textSize(50);
  fill(255);
  text("CHOOSE YOUR CHARACTER", width / 2, 60);
  characterFrame(200, 200);
  imageMode(CENTER);
  PImage possibleCharacter1 = loadImage("character1.png");
  possibleCharacter1.resize(70, 0);
  image(possibleCharacter1, 200, 200);

  characterFrame(400, 200);
  PImage possibleCharacter2 = loadImage("character2.png");
  possibleCharacter2.resize(70, 0);
  image(possibleCharacter2, 400, 200);

  characterFrame(600, 200);
  PImage possibleCharacter3 = loadImage("character3.png");
  possibleCharacter3.resize(70, 0);
  image(possibleCharacter3, 600, 200);
}

void selectionScreenWeapon() {
  background(75, 79, 116);
  drawGoldBorderCanvas();
  textAlign(CENTER);
  textSize(50);
  fill(255);
  text("CHOOSE YOUR STARTING WEAPON", width / 2, 60);

  characterFrame(200, 200);
  imageMode(CENTER);
  PImage possibleWeapon1 = loadImage("knife.png");
  possibleWeapon1.resize(70, 0);
  image(possibleWeapon1, 200, 200);

  characterFrame(400, 200);
  PImage possibleWeapon2 = loadImage("fireball.png");
  possibleWeapon2.resize(70, 0);
  image(possibleWeapon2, 400, 200);

  characterFrame(600, 200);
  PImage possibleWeapon3 = loadImage("bible.png");
  possibleWeapon3.resize(70, 0);
  image(possibleWeapon3, 600, 200);
}

void drawGoldBorderCanvas() {
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

void characterFrame(int x, int y) {
  rectMode(RADIUS);
  fill(88, 63, 65);
  rect(x, y, 50, 50);
  fill(168, 113, 31);
  rect(x, y, 48, 48);
  fill(216, 179, 105);
  rect(x, y, 46, 46);
  fill(139, 139, 139);
  rect(x, y, 44, 44);
}

float[] setEnemyPositions() {
  float randomSpawnLocationX = random(mapWidth);
  float randomSpawnLocationY = random(mapHeight);
  while (randomSpawnLocationX <= mainCharacter.getX() + 200 && randomSpawnLocationX >= mainCharacter.getX() - 200) {
    randomSpawnLocationX = random(mapWidth);
  }
  while (randomSpawnLocationY <= mainCharacter.getY() + 200 && randomSpawnLocationY >= mainCharacter.getY() - 200) {
    randomSpawnLocationY = random(mapHeight);
  }
  float[] returnedAry = {randomSpawnLocationX, randomSpawnLocationY};
  return returnedAry;
}

void spawnSwarm(String type, String location) {
  float initialX, initialY;
  int imageIndex = 0;
  if (location.equals("left")) {
    initialX = mainCharacter.getX() - width/2;
    initialY = random(mapHeight);
  } else if (location.equals("up")) {
    initialX = random(mapWidth);
    initialY = mainCharacter.getY() - height/2;
  } else if (location.equals("right")) {
    initialX = mainCharacter.getY() + width/2;
    initialY = random(mapHeight);
  } else {
    initialX = random(mapWidth);
    initialY = mainCharacter.getY() + height/2;
  }

  if (type.equals("bat")) {
    imageIndex = 0;
  } else if (type.equals("skeleton")) {
    imageIndex = 1;
  }


  EnemyCharacter enemy1 = new EnemyCharacter(1000, 100, initialX, initialY, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy2 = new EnemyCharacter(1000, 100, initialX, initialY + 35, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy3 = new EnemyCharacter(1000, 100, initialX, initialY - 35, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy4 = new EnemyCharacter(1000, 100, initialX + 35, initialY, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy5 = new EnemyCharacter(1000, 100, initialX - 35, initialY, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy6 = new EnemyCharacter(1000, 100, initialX, initialY + 70, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy7 = new EnemyCharacter(1000, 100, initialX, initialY - 70, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy8 = new EnemyCharacter(1000, 100, initialX + 35, initialY + 35, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy9 = new EnemyCharacter(1000, 100, initialX - 35, initialY + 35, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy10 = new EnemyCharacter(1000, 100, initialX + 35, initialY - 35, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy11 = new EnemyCharacter(1000, 100, initialX - 35, initialY - 35, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy12 = new EnemyCharacter(1000, 100, initialX + 70, initialY, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);
  EnemyCharacter enemy13 = new EnemyCharacter(1000, 100, initialX - 70, initialY, enemyAssets.get(imageIndex), enemyAssetsReversed.get(imageIndex), true, mainCharacter);

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

//BIBLE HELPER METHODS
void spawnBibles() {
  float bibleAngle = (360 / (bibleLevel + 3)) * (PI / 180);
  PVector bibleDirection = new PVector(200 + (50 * bibleLevel), 0);
  PVector bibleLocation = new PVector(5, -120 + (60 + (bibleLevel / 2)));

  for (int i = 0; i < bibleLevel + 3; i++) {
    PVector newBibleDirection = bibleDirection.copy();
    PVector newBibleLocation = bibleLocation.copy();
    newBibleDirection.rotate(bibleAngle * i);
    newBibleLocation.rotate(bibleAngle * i);
    AttackProjectile bible1 = new AttackProjectile("bible", (int)(mainCharacter.getX() + newBibleLocation.x), (int)(mainCharacter.getY() + newBibleLocation.y), weaponAssets.get(2), weaponAssets.get(2), Integer.MAX_VALUE, true, true, newBibleDirection, mainCharacter);
    allProjectiles.add(bible1);
  }

  biblesSpawned = true;
}

void removeBibles() {
  for (int i = 0; i < allProjectiles.size(); i++) {
    if (allProjectiles.get(i).getName().equals("bible")) {
      //System.out.println("Something is remove");
      allProjectiles.remove(i);
      i--;
    }
  }
  biblesSpawned = false;
}

void timeChange() {
  clockTimerMinutes = count / 3600;
  clockTimerSeconds = (int)((count % 3600.0) / 60);
}

void keyPressed() {
  if (gameOver == true && key == ' ') {
    //System.out.println("Attempting to restart game");
    resetup();
  } else if (gameOver == false && key == '=') {
    godMode = !godMode;
  } else if (key == 'k') {
    knifeLevel++;
  } else if (key == 'f') {
    fireballLevel++;
  } else if (key == 'b') {
    bibleLevel++;
    removeBibles();
  } else if (key == '-') {
    mainCharacter.setHP(0);
  } else if(key == 'p'){
    timeStop = !timeStop;  
  }
  else if (key == '0') {
    count = 0;
    timeChange();
  } else if (key == '1') {
    count = 4500;
    timeChange();
  } else if (key == '2') {
    count = 6300;
    timeChange();
  } else if (key == '3') {
    count = 7200;
    timeChange();
  } else if (key == '4') {
    count = 9000;
    timeChange();
  } else {
    setMove(true);
  }
}

void keyReleased() {
  setMove(false);
}

void mouseClicked() {
  if (!chosenCharacter) {
    if (mouseX > 150 && mouseX < 250 && mouseY > 150 && mouseY < 250) {
      mainCharacter = new PlayerCharacter(50, width / 2, height / 2, characterAssets.get(0), characterAssetsReversed.get(0));
      chosenCharacter = true;
      imageMode(CORNER);
      textAlign(LEFT);
      rectMode(CORNER);
    } else if (mouseX > 350 && mouseX < 450 && mouseY > 150 && mouseY < 250) {
      mainCharacter = new PlayerCharacter(50, width / 2, height / 2, characterAssets.get(1), characterAssetsReversed.get(1));
      chosenCharacter = true;
      imageMode(CORNER);
      textAlign(LEFT);
      rectMode(CORNER);
    } else if (mouseX > 550 && mouseX < 650 && mouseY > 150 && mouseY < 250) {
      mainCharacter = new PlayerCharacter(50, width / 2, height / 2, characterAssets.get(2), characterAssetsReversed.get(2));
      chosenCharacter = true;
      imageMode(CORNER);
      textAlign(LEFT);
      rectMode(CORNER);
    }
  } else if (!chosenStartingWeapon) {
    if (mouseX > 150 && mouseX < 250 && mouseY > 150 && mouseY < 250) {
      chosenStartingWeapon = true;
      imageMode(CORNER);
      textAlign(LEFT);
      rectMode(CORNER);
      knifeLevel++;
      knifeInitialLevel++;
    } else if (mouseX > 350 && mouseX < 450 && mouseY > 150 && mouseY < 250) {
      chosenStartingWeapon = true;
      imageMode(CORNER);
      textAlign(LEFT);
      rectMode(CORNER);
      fireballLevel++;
      fireballInitialLevel++;
    } else if (mouseX > 550 && mouseX < 650 && mouseY > 150 && mouseY < 250) {
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
