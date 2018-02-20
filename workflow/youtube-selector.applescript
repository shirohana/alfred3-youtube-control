on init(Loader)
  script YoutubeSelector
    property class : "YoutubeSelector"
    property store : missing value
    property player : missing value
    property players : missing value

    on run {}
      set my store to init("me.shirohana.alfred-youtube-control", "progress.plist") of load("storage.scpt") of Loader

      if get_player() is null then
        set my players to get_players()
        if count of players is 1 then set_player(item 1 of players)
      end if

      return me
    end run

    on get_player()
      if player is missing value then try
        set tab_id to get_value("tab_id") of store
        set my player to get_tab_from_id(tab_id)
      end try

      if player is not missing value then tell application "Google Chrome" to tell player
        if its title contains "- YouTube" then return it
      end tell

      return null
    end get_player

    on set_player(player)
      tell store to set_value("tab_id", id of player)
      set my player to player
    end set_player

    on get_tab_from_id(tab_id)
      tell application "Google Chrome"
        repeat with _window in every window
          repeat with _tab in every tab in _window
            if _tab's id is equal to tab_id then return _tab
          end repeat
        end repeat
      end tell
      return missing value
    end get_tab_from_id

    on get_players()
      if players is not missing value then
        return players
      else
        set player_list to {}

        tell application "Google Chrome"
          repeat with _window in every window
            repeat with _tab in every tab in _window
              if the title of _tab contains "- YouTube" then set end of player_list to _tab
            end repeat
          end repeat
        end tell

        return player_list
      end if
    end get_players
  end script

  return run script YoutubeSelector
end init
