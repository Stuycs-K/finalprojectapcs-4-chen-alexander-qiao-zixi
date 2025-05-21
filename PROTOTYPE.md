
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

UML Diagrams and descriptions of key algorithms, classes, and how things fit together.
![image](https://github.com/user-attachments/assets/52d104ad-a278-417f-b7f4-1896886a93f5)



    
# Intended pacing:

How you are breaking down the project and who is responsible for which parts.

### Entity Class Framework:
- getDirection()
- getImg()
- reverseImg()
- getX()
- getY()

### Character Class Framework:
- getHP()

### Player Character Framework:
- playerMovement()

### Enemy Character Framework:
- getSpeed()
- setSpeed(int newSpeed)
- convergeOnPlayer()

### Attack Projectile Framework:
- getSpeed()
- setSpeed(int newSpeed)
- monodirectionalAttack()

### Draw Method:
- Drawing each entity
- Moving each entity
- Redrawing the background to make sure nothing stays between cycles

### Setup Method: 
- Draw the initial characters
- Draw the background


A timeline with expected completion dates of parts of the project. (CHANGE THIS!!!!!)

