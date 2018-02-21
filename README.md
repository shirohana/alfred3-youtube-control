alfred3-youtube-control
=======================

> Control your YouTube player in an easy way :musical_note:

Requirement
-----------

#### System (Required by Alfred)
- OS X 10.9+, 64-bit Intel

#### Software
- [Alfred 3](alfred-official) with Powerpack (current: v3.5.1 [883])

#### Browser (Choose any)
- Google Chrome (default)

[alfred-official]: https://www.alfredapp.com/

Download
--------

[Releases](https://github.com/shirohana/alfred3-youtube-control/releases)

Feature
-------

- Toggle play/pause, jump to next/previous video
- Show playlist and choose any one to play (with YouTube thumbnail)
- Multi-player supported (with YouTube thumbnail)
- Fully customizable Hotkeys
- Programmable (with external trigger)

Configuration
-------------

This workflow use `y` with a whitespace as default trigger, all commands are start with it.

In default, no hotkey was presetted, you can modify then in left side of workflow:

##### Workflow structure:
![workflow structure][structure]

Quick start
-----------

### Focus current player
##### usage: `y <Enter>`
![gif-focus][gif-focus]

### Toggle play/pause
##### usage: `y p[lay]<Enter>` or `y p[ause]<Enter>`
![gif-play-pause][gif-play-pause]

### Jump to next video
##### usage: `y n[ext]<Enter>`
![gif-next][gif-next]

### Jump to previous video (if has)
##### usage: `y pr[evious]<Enter>`
![gif-prev][gif-prev]

### Choose song in playlist (if has)
##### usage: `y l[ist]<Enter>`
![gif-playlist][gif-playlist]

### Change current player
##### usage: `y c[hange]<Enter>`
###### Note: Previous player will auto paused
![gif-change-player][gif-change-player]

### Close player
##### usage: `y cl[ose]<Enter>`
![gif-close][gif-close]

Special thanks
--------------

Thanks [Pixel Lab](https://www.iconfinder.com/Pixellabs) to provide these beautiful icons in free
on [Iconfinder](https://www.iconfinder.com/iconsets/music-control-1), it makes this small project
looks wonderful (๑ơ ω ơ)

License
-------
MIT

[gif-focus]: https://media.giphy.com/media/fjxPCq74UtEVaZZJWi/giphy.gif
[gif-play-pause]: https://media.giphy.com/media/fjxtSxUFHMSp5TSFbK/giphy.gif
[gif-next]: https://media.giphy.com/media/46zwLMce1WBnv7U41D/giphy.gif
[gif-prev]: https://media.giphy.com/media/RLUSiAxXlf4FI4fiNJ/giphy.gif
[gif-playlist]: https://media.giphy.com/media/j0P7GyDtJW3hH0lei2/giphy.gif
[gif-change-player]: https://media.giphy.com/media/7NUWnbW4aup0jBR3k7/giphy.gif
[gif-close]: https://media.giphy.com/media/3ojsgk1c6o3JXO0Ps4/giphy.gif
[structure]: https://i.imgur.com/yBNpos3.png
