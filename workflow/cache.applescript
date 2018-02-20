on init()
  script Cache
    property class : "Cache"

    on download(link)
      set link to quoted form of link
      set filename to POSIX path of (path to temporary items) & (do shell script "md5 <<< " & link)
      if not file_exists(filename) then try
        do shell script "curl -o " & quoted form of filename & " " & link
      end try
      return filename
    end download
  end script

  return Cache
end init

on file_exists(p)
  try
    get POSIX file p as alias
    return true
  on error
    return false
  end try
end file_exists
