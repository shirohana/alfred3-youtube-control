on run {}
  # Prepare loader
  set _loader to load script POSIX path of ((path to me as text) & "::") & "loader.scpt"
  set Loader to init(path to me as text) of _loader

  set menu_list to create() of load("filter-factory.scpt") of Loader

  # If Google Chrome is not running, quit workflow
  tell application "System Events" to set chrome_running to (name of processes contains "Google Chrome")

  if chrome_running is false then
    tell menu_list to add given T:"No player running", S:"Launch Google Chrome first", A:"", I:"icon.png", M:0, C:"", TY:"", V:0
    return to_json() of menu_list
  end if

  set selector to init(Loader) of load("youtube-selector.scpt") of Loader
  tell selector to set { player, players } to { get_player(), get_players() }

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
  else
    set Utils to load("utils.scpt") of Loader
    set info to init(player) of load("youtube-info.scpt") of Loader

    tell info
      # Add item: Now playing...
      set song_title to escape(song_title()) of Utils
      tell menu_list to add given T:"Now playing...", S:song_title, A:"focus", I:"img/music.png", M:"focus", C:"focus", TY:"", V:1

      # Add item: Play | Pause
      if is_playing() then
        tell menu_list to add given T:"Pause", S:"", A:"play/pause", I:"img/pause.png", M:"play pause", C:"pause", TY:"", V:1
      else
        tell menu_list to add given T:"Play", S:"", A:"play/pause", I:"img/play.png", M:"play pause", C:"play", TY:"", V:1
      end if

      # Add item: Next (if has)
      if has_next_song() then
        set song_title to escape(next_song_title()) of Utils
        tell menu_list to add given T:"Next", S:song_title, A:"next", I:"img/next.png", M:"next", C:"next", TY:"", V:1
      end if

      # Add item: Previous (if has)
      if has_previous_song() then
        set song_title to escape(previous_song_title()) of Utils
        tell menu_list to add given T:"Previous", S:song_title, A:"prev", I:"img/prev.png", M:"previous", C:"previous", TY:"", V:1
      end if

      # Add item: Playlist (if has)
      if has_playlist() then
        set list_title to escape(playlist_title()) of Utils
        tell menu_list to add given T:"Playlist", S:list_title, A:"playlist", I:"img/playlist.png", M:"list playlist", C:"list", TY:"", V:1
      end
    end tell

    # Add item: Change player (if has more than 1 players)
    if count of players is greater than 1 then
      set subtitle to "There are " & (count of players) & " YouTube players"
      tell menu_list to add given T:"Change player", S:subtitle, A:"select", I:"img/eject.png", M:"change", C:"change", TY:"", V:1
    end if

    # Add item: Close
    tell menu_list to add given T:"Close", S:"", A:"close", I:"img/close.png", M:"close", C:"close", TY:"", V:1
  end if

  return to_json() of menu_list
end run
