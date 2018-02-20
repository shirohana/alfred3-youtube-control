on init(youtube)
  script YoutubeControl
    property class : "YoutubeControl"

    on execute from jscode
      tell application "Google Chrome" to tell youtube to return execute javascript jscode
    end execute

    on toggle_play()
      execute from¬
          "document.querySelector('#movie_player .ytp-play-button').click();"
    end toggle_play

    on play_next_video()
      execute from¬
          "document.querySelector('#movie_player .ytp-next-button').click();"
    end play_next_video

    on play_previous_video()
      execute from¬
          "document.querySelector('#movie_player .ytp-prev-button').click();"
    end play_previous_video

    on play()
      execute from¬
          "var player = document.getElementById('movie_player');" &¬
          "if (player.classList.contains('paused-mode')) {" &¬
          "  player.querySelector('.ytp-play-button').click();" &¬
          "}"
    end play

    on pause()
      execute from¬
          "var player = document.getElementById('movie_player');" &¬
          "if (player.classList.contains('playing-mode')) {" &¬
          "  player.querySelector('.ytp-play-button').click();" &¬
          "}"
    end pause

    on is_playing()
      return execute from¬
        "document.getElementById('movie_player').classList.contains('playing-mode');"
    end is_playing

    on has_next_video()
      return true
    end has_next_video

    on has_previous_video()
      return execute from¬
        "document.querySelector('#movie_player .ytp-prev-button[aria-disabled=false]') !== null;"
    end has_previous_video

    on focus()
      set found to false

      tell application "Google Chrome"
        repeat with _window in every window
          set idx to 1
          repeat with _tab in every tab in _window
            if _tab is youtube then
              activate
              set active tab index of _window to idx
              set index of _window to 1
              set found to true
              exit repeat
            end if
            set idx to idx + 1
          end repeat
          if found then exit repeat
        end repeat
      end tell
      return
    end focus

    on close()
      tell application "Google Chrome" to delete (youtube as any)
    end close
  end script

  return YoutubeControl
end init
