on run {}
  # Prepare loader
  set _loader to load script POSIX path of ((path to me as text) & "::") & "loader.scpt"
  set Loader to init(path to me as text) of _loader

  set selector to init(Loader) of load("youtube-selector.scpt") of Loader
  set playlist to create() of load("filter-factory.scpt") of Loader

  set player to selector's get_player()

  if player is null then
    tell application "Alfred 3" to run trigger "select-player" in workflow "me.shirohana.alfred-youtube-control"
    return
  end if

  set info to init(player) of load("youtube-info.scpt") of Loader

  if info's has_playlist() then
    set Cache to init() of load("cache.scpt") of Loader
    set Utils to load("utils.scpt") of Loader

    set next_songs to info_of_next_n_songs(9) of info

    repeat with song in next_songs
      set song_title to escape(title of song) of Utils
      set icon_path to Cache's download(thumbnail_url_of_youtube(href of song) of Utils)
      set action to "goto:" & (href of song)

      tell playlist to add given T:song_title, S:"", A:action, I:icon_path, M:0, C:"", TY:"", V:1
    end repeat
  else
    tell playlist to add given T:"No playlist available for current YouTube player", S:"Choose another player", A:"select", I:"icon.png", M:0, C:"", TY:"", V:1
  end if

  return to_json() of playlist
end run
