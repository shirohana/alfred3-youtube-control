on escape(str)
  set r to ""
  repeat with c in str
    if "\\\"" contains c then set c to "\\" & c
    set r to r & c
  end repeat
  return r
end escape

on thumbnail_url_of_youtube(href)
  set video_id to do shell script¬
      "echo " & (quoted form of href) &¬
      "|grep -Eo 'v=(\\w|-)+'" &¬
      "|cut -d= -f2" &¬
      "|xargs echo"
  return "https://img.youtube.com/vi/" & video_id & "/mqdefault.jpg"
end thumbnail_url_of_youtube
