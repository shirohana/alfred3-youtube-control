on init(bundleid, filename)
  script Storage
    property class : "storage"
    property db : missing value

    on run {}
      set dbpath to POSIX path of (path to home folder) &¬
          "Library/Application Support/Alfred 3/Workflow Data/" & bundleid

      if not file_exists(dbpath) then¬
          do shell script "mkdir " & (quoted form of dbpath)

      set my db to dbpath & "/" & filename

      return me
    end run

    on set_value(k, v)
      ensure_db()
      tell application "System Events"
        set f to property list file db
        make new property list item at the end of¬
            property list items of contents of f¬
            with properties { kind:(class of v), name:k, value:v }
      end tell
    end set_value

    on get_value(k)
      tell application "System Events"
        set f to property list file db
        return value of property list item k of contents of f
      end tell
    end get_value

    on ensure_db()
      if file_exists(db) is false then¬
          do shell script "defaults write " & (quoted form of db) & " default 1"
    end ensure_db
  end script

  return run script Storage
end init

on file_exists(p)
  try
    get POSIX file p as alias
    return true
  on error
    return false
  end try
end file_exists
