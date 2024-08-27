# Godot Template

This project is a barebones template for games built in Godot. It contains much
of the UI boilerplate code that is common to nearly every game, with almost no
frills or customization, and provides a solid foundation on which to build your
projects.

## High-Level Structure

- **Main** - Top-level manager node which orchestrates all of the primary scenes
and controls which one is shown to the player.
  - **MainMenu** - The main menu of the game. This is the first thing that will
  be displayed when the game starts.
  - **Game** - This is where you will build your actual gameplay. It is
  initially hidden, and gets displayed when you press "Start" from the main
  menu.
  - **SettingsMenu** - Basic settings menu that allows you to adjust volume and
  fullscreen. It is displayed upon pressing the "Settings" button from either
  the main menu or the pause menu. Upon pressing "Done" you will return to
  whichever menu you came from.
  - **Credits** - A space for you to design a credits sequence that will play
  after completing the game.
  - **PauseMenu** - Displayed when the game is paused. By default, pressing Esc
  on the keyboard, or Start/+/Menu on a controller will pause the game.