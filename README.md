# TowerShooter
Name of game: Tower Defence

![image](https://github.com/user-attachments/assets/9afdbfb2-643f-47ed-b201-0eafaa9b46cb)

![image](https://github.com/user-attachments/assets/3e450aea-5223-4adc-a93f-be708f6276f7)

## Description
Tower Defence is a simple tower defense game implemented in Processing. The objective of the game is to defend against waves of enemies using strategically placed towers.

## Features

- **Gameplay Elements:**
  - Towers: Different types of towers can be placed on the map to attack enemies.
  - Enemies: Waves of enemies spawn at regular intervals and move towards a goal.
  - Health and Money: Players start with a set number of lives and money. Lives are lost if enemies reach the goal, and money is used to build and upgrade towers.
  - Waves: Waves of enemies increase in difficulty as the game progresses, including boss waves.
  
- **User Interface:**
  - Menu Screen: Allows players to choose game difficulty before starting.
  - HUD: Displays current wave, remaining lives, money, and score during gameplay.
  - Game Over: Shows the final score and waves survived upon losing all lives.

## Installation

1. Clone the repository or download the project files.
2. Open the project in Processing IDE.
3. Run the `Tower_Defence.pde` file to start the game.

## Controls

- **Mouse:** Click to place towers on the map.
- **Keyboard:** Press `R` to restart the game when on the game over screen.

## Requirements

- Processing IDE (Version X.X or higher)
- Compatible with Windows, macOS, and Linux

 

**Vision** 

The concept for this game is that enemies will try to traverse the map following prebuilt track to get through to the players base. While walking along the track the enemies will be shot at by sci-fi towers that have been built by the player to kill / stop the enemies. The player will try to kill the enemies before they enter into their base which would result in a loss. The game is played in waves, the player must survive the wave of enemies to continue to the next wave, the game cannot be won, rather you compete to get the best score / highest number of waves. The game must include enemies with different abilities for example some could be faster or have more health. The game should have at least two modes for more experienced players. The towers should be able to rotate to face the target and shoot in the direction of the target. The game should have a grid layout for towers to be placed down neatly and on overlapping. The game should include a resort which should work at any time.

**Achievement**

I was able to complete my game completely. Players are able to place down upgradeable towers to defend against the enemy invaders. The game shows the players score, lives count, money count and current wave at the bottom of the screen. The map is set in the forest / field, the map includes a track which the enemies will follow to get to the players base, the track zig zags across the map creating plenty of spots for the player to set up their defense towers to defeat the enemies. The towers are able to track and shoot at enemies within a range around them. Upgraded towers will do more damage. The game has two modes EASY and HARD which the player can select from in the start menu. The HARD game mode increases the enemies health, speed and the chance that a blue enemy which is harder to kill will spawn. In hard mode the player also has less lives. My game includes different enemies that have differ abilities e.g. the blue enemy has more health. Every 10 waves a boss is spawned that has lots of health to increase the game's difficulty. The game includes a reset for when the player is bored or has lost the game. When the player loses, the screen displays the game over screen with stats from that game like waves survived and the players overall score which is based on how many enemies have been killed.

**Technical Challenges**

There were many technical challenges to overcome. The hardest technical challenge was shooting the bullets out of the tower, this involved some interesting math along with working with PVectors. PVector is a class to describe a two or three dimensional vector. I firstly had to make a Pvector to describe the location of the tower the bullet is being shot from. Then I had to calculate the position of the path for the bullet to travel on towards the target. This was achieved with the atan2 function which calculates the angle in radians from a specified point to the coordinate origin as measured from the positive x-axis, this then combined with vector subtraction I was able to calculate the path for the bullet. 
Another technically challenging problem to solve was rotating the tower sprite to face towards the target it was currently shooting at. This was achieved by reusing code involving the atan2 function to calculate the angle to the target, then using the processing rotation and translation functions move the image to the correct position. I used push and pop matrices to  start and stop the translations and rotations from affecting the placement of other sprites. All assets are called from a local file because calling them from the internet introduced ag to the game.

**Reflection**

Map design and implementation was far easier than I expected. This includes splitting the map up into 192 grids (16 columns, 12 rows) for objects to be in. Designing, building and implementing multiple classes spread out between different files was quite difficult, but it allowed me to compress my code and using multiple files made it easier to traverse a large code base quickly. I executed my plan and my game works well with no errors. All assets are called from a local file because calling them from the internet introduced ag to the game. I believe that there is more that I could have dont it make it better. If I could do this assignment again I would add more animations and improve the overall look of the game. I could also add more types of towers with a menu bar on the side where the user could choose from different towers that do different things. My plan worked out perfectly. The only problem was my artistic abilities, my sprites are very plain. If I could redo it I would try harder to draw better sprites or use ones from a free online repository. I could add a file to save the top score along with the player name. If I had more time I would add new maps / levels along with sound.



