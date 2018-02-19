on init(target)
  script YoutubeInfo
    property class : "YoutubeInfo"

    on song_title()
      tell application "Google Chrome" to tell target to return its title
    end song_title

    on next_song_title()
      tell application "Google Chrome" to tell target to return execute javascript¬
          "document.querySelector('#movie_player .ytp-next-button').dataset.tooltipText;"
    end next_song_title

    on previous_song_title()
      tell application "Google Chrome" to tell target to return execute javascript¬
          "var n = document.querySelector('#movie_player .ytp-prev-button'); n.dataset.tooltipText || n.title;"
    end previous_song_title

    on is_playing()
      tell application "Google Chrome" to tell target to return execute javascript¬
          "document.getElementById('movie_player').classList.contains('playing-mode');"
    end is_playing

    on has_next_song()
      return true
    end has_next_song

    on has_previous_song()
      tell application "Google Chrome" to tell target to return execute javascript¬
          "document.querySelector('#movie_player .ytp-prev-button[aria-disabled=false]') !== null;"
    end has_previous_song

    on has_playlist()
      tell application "Google Chrome" to tell target to return execute javascript¬
          "document.getElementById('playlist').hasAttribute('hidden') === false"
    end has_playlist

    on playlist_title()
      tell application "Google Chrome" to tell target to return execute javascript¬
          "document.querySelector('#playlist .title').innerText"
    end playlist_title

    on info_of_next_n_songs(n)
      tell application "Google Chrome" to tell target to return execute javascript¬
          "var i = " & n & "; var list = []; var n = document.querySelector('#playlist ytd-playlist-panel-video-renderer[selected]');" &¬
          "while (i-->0 && n !== null) { list.push({ title: n.querySelector('[id=video-title]').innerText, href: n.querySelector('[id=wc-endpoint]').href }); n = n.nextElementSibling; }" &¬
          "list;"
    end info_of_next_n_songs
  end script

  return YoutubeInfo
end init
