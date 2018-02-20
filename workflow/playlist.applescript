on run {}
  # Prepare loader
  set Loader to init(path to me as text) of (load script POSIX path of ((path to me as text) & "::") & "loader.scpt")

  set selector to init(Loader) of load("youtube-selector.scpt") of Loader
  set playlist to create() of load("filter-factory.scpt") of Loader

  set player to selector's get_player()

  # Show player selector when player is not specified
  if player is null then
    tell application "Alfred 3" to return¬
        run trigger "select-player" in workflow "me.shirohana.alfred-youtube-control"
  end if

  set info to init(player) of load("youtube-info.scpt") of Loader

  # When there's no playlist in current player
  if not has_playlist() of info then
    tell playlist to add given¬
        T:"No playlist available for current YouTube player", S:"Choose another player",¬
        A:"select", I:"icon.png", M:0, C:"", TY:"", V:1
  else
    set Cache to init() of load("cache.scpt") of Loader
    set Utils to load("utils.scpt") of Loader

    # Push songs in playlist to output
    repeat with song in info_of_next_n_songs(9) of info
      set song_title to escape(song's title) of Utils
      set thumbnail_url to thumbnail_url_of_youtube(song's href) of Utils
      set icon_path to download(thumbnail_url) of Cache
      set action to "goto:" & href of song

      tell playlist to add given¬
          T:song_title, S:"",¬
          A:action, I:icon_path, M:0, C:"", TY:"", V:1
    end repeat
  end if

  return to_json() of playlist
end run
