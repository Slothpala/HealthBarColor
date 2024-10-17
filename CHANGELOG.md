# **Changelog**
### Version [3.4.0] - TBD
#### Fixes
* Classic: Fixed an issue that caused an issue were the color of the druid class could not be changed.
#### Updated
* All flavors: Created a new addon-wide table (colorMixins). Instead of creating new color mixins every time SetGradient() is called, the addon will now reuse the mixins from this table, resulting in a slight performance improvement.

### Version [3.3.0] - 2024-09-02
#### Added
* Retail: New Module -> HideTotemFrame

#### Fixes
* UI: The titles for the health and power bar textures now use the correct locale.

### Version [3.2.9] - 2024-08-22
#### Updated
* retail: Improved the textures of BiggerHelthBar

### Version [3.2.8] - 2024-08-21
#### Updated
* retail interface version updated to 110002

### Version [3.2.7] - 2024-08-10
#### Removed
* Removed BetterBossFrame because I could not fix it after the changes.

### Version [3.2.6] - 2024-08-05
#### Fixes
* Retail: BiggerHealthBar.lua -> fixed the path of the mask texture.

### Version [3.2.5] - 2024-07-27
#### Fixes
* Retail: Init.lua -> healthTextMiddle now points to the correct FontString.
* Retail: BiggerHealthBar.lua -> Status texts are now anchored to the HealthBar, making them behave like they did before the tww pre patch.

### Version [3.2.4] - 2024-07-23
#### Updated
* Adapted to tww UI changes.

### Version [3.2.3] - 2024-06-11
#### Removed
* Removed some unused local variables.

### Version [3.2.2] - 2024-05-30
#### Fixes
* Fixed typos that prevented the targets ManaBarTextRight, Focus ManaBarText and Focus ManaBarTextRight from being affected by font settings for the Wrath and Cata versions.

### Version [3.2.1] - 2024-05-08
#### Updated
* retail interface version updated to 100207

### Version [3.2.0] - 2024-05-06
#### Added
* Cata support.

### Version [3.1.0] - 2024-04-21
#### Added
* Return of the PartyColor module. (Enable class colors for party frames (non raid style).)

### Version [3.0.4] - 2024-04-15
* Alternate Power Bar text added to player font module.

### Version [3.0.3] - 2024-04-06
#### Updated
* Classic Interface version to 11502

### Version [3.0.2] - 2024-03-23
#### Updated
* retail interface version updated to 100206
* updated OptionalDeps

### Version [3.0.1] - 2024-03-01
#### Fixes
* HBC_Unit.lua -> Fixed a problem where UnitPowerType was using the wrong index for classic clients, resulting in all powerTokens using the fallback value ("MANA").

### Version [3.0.0] - 2024-02-25
#### Updated
* The entire addon base has been rewritten from scratch.
    * Retail and Classic versions have been streamlined.

#### Highlights
* New color option "Blizzard green" added. That can restore the default blizzard green healthbar.
* All statusbars now use gradient colors.
* Performance improvements. The addon uses even fewer resources.
* Power Colors can be customized when playing with custom textures.
* BackgroundTextures added for classic.

#### Fixes
* Overabsorb module rewritten to work with the new absorb textures.

#### Removed
* PartyColor module as it never fully worked.

### Version [2.12.6] - 2024-02-18
#### Updated
* vanilla interface version updated to 11501

### Version [2.12.5] - 2024-01-17
#### Fixes
* disabled the overabsorb module until i have time to catch up to the changes on blizzards side.

### Version [2.12.4] - 2024-01-16
#### Updated
* retail interface version updated to 100205

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
