# Available argv:
#   - "play": Force play current video
#   - "pause": Force pause current video
#   - "play/pause": Toggle play/pause on current video
#   - "next": Play next video
#   - "prev": Play previous video (if has)
#   - "close": Close current player
#   - "goto:%s": Redirect current YouTube page to '%s'
#   - "select": Show player selector (helper)
#   - "create": Open new YouTube page
on run argv
  # Prepare loader
  set _loader to load script POSIX path of ((path to me as text) & "::") & "loader.scpt"
  set Loader to init(path to me as text) of _loader

  set selector to init(Loader) of load("youtube-selector.scpt") of Loader
  set player to selector's get_player()
  set action to item 1 of argv

  if player is null then
    if action is "create" then
      tell application "Google Chrome"
        activate
        open location "https://www.youtube.com"
        delay 0.5
        activate
      end tell
    else
      tell application "Alfred 3" to run trigger "select-player" in workflow "me.shirohana.alfred-youtube-control"
    end if
  else
    set youtube to init(player) of load("youtube-controller.scpt") of Loader
    set info to init(player) of load("youtube-info.scpt") of Loader

    # Switch actions
    if action is "focus" then
      tell youtube to focus()
    else if action is "play/pause" then
      tell youtube to toggle_play()
    else if action is "next" and has_next_song() of info then
      tell youtube to play_next_video()
      tell info to return next_song_title()
    else if action is "prev" and has_previous_song() of info then
      tell youtube to play_previous_video()
      tell info to return previous_song_title()
    else if action is "close" then
      tell youtube to close()
    else if action is "play" then
      tell youtube to play()
    else if action is "pause" then
      tell youtube to pause()
    else if action starts with "goto:" then
      tell youtube to execute("window.location.href = " & quoted form of (text 6 thru -1 of action))
    else if action is "select" then
      tell application "Alfred 3" to run trigger "select-player" in workflow "me.shirohana.alfred-youtube-control"
    end if
  end if

  return
end run
