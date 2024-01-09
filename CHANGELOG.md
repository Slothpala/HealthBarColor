# **Changelog**

### Version [2.12.3] - 2024-01-09
#### Fixes
* Fixed an issue for Classic and Retail where the game would simply ignore the font set for PlayerName when first starting the game.

#### Changed
* Options.lua changed font dropdown widgets from AceGUI-3.0-SharedMediaWidgets to LibDDI-1.0

### Version [2.12.2] - 2023-12-18
#### Added
* Utils/HookRegistry.lua
* Textures_classic.lua 
#### Changed
* BiggerHealthBar module: 
    * all classes will now use the texture without an alternate power bar. 
    * the AlternatePowerBar and MonkStaggerBar are now hidden.
    * the module now uses the HookRegistry 
* The method of determaining the game version got changed from asking the game version to Init files.

### Version [2.12.1] - 2023-12-04
#### Added
* Utils/CombatLockdown.lua // helper to delay callbacks to be executed after combat
#### Fixed
* BiggerHealthBar.lua // InCombatLockdown added for toPlayerArt function and method added to delay the function until combat ends.

### Version [2.12.0] - 2023-12-01
#### Added
* BetterBossFrame.lua module added for retail

### Version [2.11.6] - 2023-11-20
#### Added
* option to hide the minimap icon

### Version [2.11.5] - 2023-11-07
#### Changed
* retail interface version updated to 100200

### Version [2.11.4] - 2023-10-29
#### Changed
* Fetch updated german translation.

### Version [2.11.3] - 2023-10-25

#### Added
-CHANGELOG.md 

#### Changed
-Added alpha channels to the BiggerHealthBar_PlayerFrameHealthMask.tga top right and bottom right corners for a smoother transition when using shared media textures.
