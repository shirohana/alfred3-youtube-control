on escape(str)
  set r to ""
  repeat with c in str
    if "\\\"" contains c then set c to "\\" & c
    set r to r & c
  end repeat
  return r
end escape

on encode(str)
  set escape_from to "&'\"<>" & tab
  set escape_to to {"&amp;", "&apos;", "&quot;", "&lt;", "&gt;", "&#009;"}
  set r to ""
  repeat with c in str
    if escape_from contains c then set c to item (offset of c in escape_from) of escape_to
    set r to r & c
  end repeat
end encode

on thumbnail_url_of_youtube(youtube_url)
  set youtube_id to do shell script "echo " & quoted form of youtube_url & "|grep -Eo 'v=(\\w|-)+'|cut -d= -f2|xargs echo"
  return "https://img.youtube.com/vi/" & youtube_id & "/mqdefault.jpg"
end thumbnail_url_of_youtube
