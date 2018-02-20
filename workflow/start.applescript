on run {}
  # Prepare loader
  set Loader to init(path to me as text) of (load script POSIX path of ((path to me as text) & "::") & "loader.scpt")

  set menu_list to create() of load("filter-factory.scpt") of Loader

  tell application "System Events" to set chrome_running to (name of processes contains "Google Chrome")

  # If Google Chrome is not running, quit workflow
  if chrome_running is false then
    tell menu_list to add given¬
        T:"No player running", S:"Launch Google Chrome first",¬
        A:"", I:"icon.png", M:0, C:"", TY:"", V:0
    return to_json() of menu_list
  end if

  set selector to init(Loader) of load("youtube-selector.scpt") of Loader
  set player to get_player() of selector
  set players to get_players() of selector

  # If no player available, return only helper buttons
  if player is null then
    if count of players is equal to 0 then
      tell menu_list to add given¬
          T:"Create player", S:"Open YouTube player in Google Chrome",¬
          A:"create", I:"icon.png", M:0, C:"create", TY:"", V:1
    else
      tell menu_list to add given¬
          T:"Choose player", S:"There are " & (count of players) & " YouTube players available",¬
          A:"select", I:"icon.png", M:0, C:"select", TY:"", V:1
    end if
    return to_json() of menu_list
  end if

  # If player exists and return controls
  set Utils to load("utils.scpt") of Loader
  set info to init(player) of load("youtube-info.scpt") of Loader

  tell info
    # Add item: Now playing...
    tell menu_list to add given¬
        T:"Now playing...", S:Utils's escape(song_title() of info),¬
        A:"focus", I:"img/music.png", M:"focus", C:"focus", TY:"", V:1

    # Add item: Play | Pause
    if is_playing() then
      tell menu_list to add given¬
          T:"Pause", S:"", A:"play/pause",¬
          I:"img/pause.png", M:"play pause", C:"pause", TY:"", V:1
    else
      tell menu_list to add given¬
          T:"Play", S:"", A:"play/pause",¬
          I:"img/play.png", M:"play pause", C:"play", TY:"", V:1
    end if

    # Add item: Jump next (if has)
    if has_next_song() then tell menu_list to add given¬
        T:"Next", S:Utils's escape(next_song_title() of info),¬
        A:"next", I:"img/next.png", M:"next", C:"next", TY:"", V:1

    # Add item: Jump previous (if has)
    if has_previous_song() then tell menu_list to add given¬
        T:"Previous", S:Utils's escape(previous_song_title() of info),¬
        A:"prev", I:"img/prev.png", M:"previous", C:"previous", TY:"", V:1

    # Add item: Playlist (if has)
    if has_playlist() then tell menu_list to add given¬
        T:"Playlist", S:Utils's escape(playlist_title() of info),¬
        A:"playlist", I:"img/playlist.png", M:"list playlist", C:"list", TY:"", V:1
  end tell

  # Add item: Change player (when has more than 1 players)
  if count of players > 1 then tell menu_list to add given¬
      T:"Change player", S:"There are " & (count of players) & " YouTube players",¬
      A:"select", I:"img/eject.png", M:"change", C:"change", TY:"", V:1

  # Add item: Close player
  tell menu_list to add given¬
      T:"Close", S:"",¬
      A:"close", I:"img/close.png", M:"close", C:"close", TY:"", V:1

  return to_json() of menu_list
end run
