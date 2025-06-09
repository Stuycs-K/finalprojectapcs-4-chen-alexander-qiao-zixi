
# Technical Details:

# Project Description

Period 4

Zixi Qiao and Alexander Chen

Chimera Spectre Studio Games, Animations, and Reading Club

Vampire Survivors Parody: Brief Description
This will work similar to Vampire Survivors. The player will control a character with the keyboard and have automatic attacks. Enemies will converge upon the player’s location until they are all wiped out. There will be three stages and the player will be able to choose between different sets of gear. However, there will be no leveling up or attaining new weapons during a game.
Based on: https://en.wikipedia.org/wiki/Vampire_Survivors

## Expanded Description

### Critical Features:
- WASD Movement of PC
- Converging enemies on PC
- Directional attacks that deal damage to enemies upon hit
- PC loses health when touched/hit by enemy
- Visible health bar for PC and enemies
- Different sets of gear with different properties and PC stats
- Different sets of enemies with different properties/stats

### Nice to have:
- Boss enemy
- Good character assets
- Numbers to appear when they take damage
     
# Project Design

## UML Diagrams and descriptions of key algorithms, classes, and how things fit together.

### Original UML Diagram:
![image](https://github.com/user-attachments/assets/ec7e9b20-c0e9-4f0d-9866-9ebd668782dd)

### Updated UML Diagram:
![image](https://github.com/user-attachments/assets/fb4613ce-7f73-45ec-bd57-7b45aed2d9bc)

### NEW NEW UML Diagram
![image](https://github.com/user-attachments/assets/97157d1e-06e2-4d88-9686-d5cfc6d5f19c)


# Intended pacing:

How you are breaking down the project and who is responsible for which parts.

### Entity Class Framework: Together
- getDirection()
- getImg()
- reverseImg()
- getX()
- getY()

### Character Class Framework: Zixi
- getHP()

### Player Character Framework: Zixi
- playerMovement()

### Enemy Character Framework: Zixi
- getSpeed()
- setSpeed(int newSpeed)
- convergeOnPlayer()

### Attack Projectile Framework: Alex
- getSpeed()
- setSpeed(int newSpeed)
- monodirectionalAttack()

### Draw Method: Together
- Drawing each entity
- Moving each entity
- Redrawing the background to make sure nothing stays between cycles

### Setup Method: Alex
- Draw the initial characters
- Draw the background
- Set up image assets to be used

### keyPressed: Alex
- Make sure that when WASD pressed character moves in corresponding direction.


By 5/22: Completed Entity class and template for main.

By 5/25: Completed Characters class and its subclasses.

By 5/27: Completed AttackProjectiles class and implemented collision damage. Began implementing image assets.

By 6/1: Completed map movement and timer. MVP ready.

By 6/7: Implemented all new enemies, weapons, item pickups for leveling up gear/healing, and end screens.

By 6/8: Completed final product and video.
