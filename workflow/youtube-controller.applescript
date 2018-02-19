on init(target)
  script YoutubeControl
    property class : "YoutubeControl"

    on execute(jscode)
      tell application "Google Chrome" to tell target to return execute javascript jscode
    end execute

    on focus()
      set found to false

      tell application "Google Chrome"
        repeat with _window in every window
          set idx to 1
          repeat with _tab in every tab in _window
            if _tab is target then
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
      tell application "Google Chrome" to delete (target as any)
    end close

    on toggle_play()
      tell application "Google Chrome" to tell target to execute javascript "document.querySelector('#movie_player .ytp-play-button').click();"
    end toggle_play

    on play_next_video()
      tell application "Google Chrome" to tell target to execute javascript "document.querySelector('#movie_player .ytp-next-button').click();"
    end play_next_video

    on play_previous_video()
      tell application "Google Chrome" to tell target to execute javascript "document.querySelector('#movie_player .ytp-prev-button').click();"
    end play_previous_video

    on play()
      tell application "Google Chrome" to tell target
        execute javascript "var player = document.getElementById('movie_player');"
        execute javascript "if (player.classList.contains('paused-mode')) { player.querySelector('.ytp-play-button').click(); }"
      end tell
    end play

    on pause()
      tell application "Google Chrome" to tell target
        execute javascript "var player = document.getElementById('movie_player');"
        execute javascript "if (player.classList.contains('playing-mode')) { player.querySelector('.ytp-play-button').click(); }"
      end tell
    end pause

    on is_playing()
      tell application "Google Chrome" to tell target
        return execute javascript "document.getElementById('movie_player').classList.contains('playing-mode');"
      end tell
    end is_playing

    on has_next_video()
      return true
    end has_next_video

    on has_previous_video()
      tell application "Google Chrome" to tell target
        return execute javascript "document.querySelector('#movie_player .ytp-prev-button[aria-disabled=false]') !== null;"
      end tell
    end has_previous_video
  end script

  return YoutubeControl
end init
