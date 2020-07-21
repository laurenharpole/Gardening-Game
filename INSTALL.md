# Installation Instruction

## Step 1: Install oCaml Graphics
### Install Graphics on Windows:
1. In the terminal, enter the following command:
``` opam install graphics ```
2. NOTE: text in oCaml Graphics does not work on windows

### Install Graphics on OSX/Linux:
1. If your device doesn't have it, install Homebrew.
  - Note: Even if you already have oCaml and opam installed, they must
   be installed through Homebrew in order to correctly link X Quartz to oCaml.
2. In the terminal, enter the following commands:
  - ```brew install Caskroom/cask/xquartz```
  - ```brew install pkg-config```
  - ```brew install ocaml --with-x11```
    - Note: if 'install' doesn't work, try the command using 'reinstall'
  - ```brew install opam```
  - ```opam switch 4.09.0```
  - ```opam install graphics ounit utop ocamlbuild```
  - ```opam install utop```
3. Before starting the game, you must restart your device to get finish X Quartz setup.

## Step 2: Start the Game
1. In the terminal at the project folder, enter utop and copy+paste the 
following commands:

```
#require "graphics";;
#load "plant.cmo";;
#load "tile.cmo";;
#load "item.cmo";;
#load "garden.cmo";;
#load "inventory.cmo";;
#load "player_info.cmo";;
#load "shop_info.cmo";;
#load "gameState.cmo";;
#load "graphicsController.cmo";;
#load "game.cmo";;
#use "game.ml";;
start ();;
```

## Step 3: Instructions
- Welcome to the game!
- Garden actions:
  - To till the earth, click on hoe, then click on tile to turn grass 
  to Dirt and then Tilled earth
  - Plant seed: Once earth is Tilled, you can click on a flower 
  seed you have and plant it
  by clicking on the tile you wish to plant it in
  - Click on water can, then click on plant to water it (must be watered once
  a day). If the plant is watered, it is shown by having a blue border.
  - Type 'sleep' into command line to go to the next day and watch your plants
  grow!
  - Type 'help' into command line if you forgot some commands
  - Plants are harvestable within 3 days (or sleeps). Once plants are
  harvestable, they are outlined in a yellow border.
  - Plants die after 3 days and if they are not watered each day
  - If a plant has died (turned gray) you can remove it by clicking on the hoe
  and tilling that tile

- Shop Actions:
  - type 'open shop' and 'close shop' into command line 
  to open and close the shop
  - click on item in shop to buy it
  - click on item in your inventory to sell it. Note that you must grow your
  seeds to a harvestable state before selling them back to store
  - all seeds are worth $10
  - you cannot sell your water can or hoe