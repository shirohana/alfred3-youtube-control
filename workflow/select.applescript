# Available argv:
#   - missing value: return json as ScriptFilter
#   - long: id of `CrTb` to select and return message if have
on run argv
  # Prepare loader
  set Loader to init(path to me as text) of (load script POSIX path of ((path to me as text) & "::") & "loader.scpt")

  set selector to init(Loader) of load("youtube-selector.scpt") of Loader

  if length of argv is 0 then
    set player_list to create() of load("filter-factory.scpt") of Loader
    set Cache to init() of load("cache.scpt") of Loader
    set Utils to load("utils.scpt") of Loader

    # Add help message
    tell player_list to add given T:"Select a player", S:"", A:"", I:"icon.png", M:"", C:"", TY:"", V:0

    repeat with player in selector's get_players()
      tell application "Google Chrome" to tell player
        set {song_title, tab_id, the_url} to {title, id, URL}
      end tell

      set song_title to escape(song_title) of Utils
      set icon_path to Cache's download(thumbnail_url_of_youtube(the_url) of Utils)

      # Add YouTube tab with title and thumbnail
      tell player_list to add given T:song_title, S:"", A:tab_id, I:icon_path, M:0, C:"", TY:"", V:1
    end repeat

    return to_json() of player_list
  else
    set tab_id to item 1 of argv as number
    set player to selector's get_player()

    if player is not null then
      set info to init(player) of load("youtube-info.scpt") of Loader
      set youtube to init(player) of load("youtube-controller.scpt") of Loader
      if info's is_playing() and player's id is not equal to tab_id then tell youtube to pause()
    end if

    tell selector to set_player(get_tab_from_id(tab_id))
    tell application "Alfred 3" to run trigger "open" in workflow "me.shirohana.alfred-youtube-control"
  end if
end run
