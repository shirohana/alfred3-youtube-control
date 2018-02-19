on init(bundleid, filename)
  script Storage
    property class : "storage"
    property _filename : missing value

    on run {bundleid, filename}
      set my _filename to POSIX path of (path to home folder) & "Library/Application Support/Alfred 3/Workflow Data/" & bundleid
      if not file_exists(my _filename) then do shell script "mkdir " & (quoted form of my _filename)
      set my _filename to my _filename & "/" & filename
      return me
    end run

    on set_value(k, v)
      my ensure_file()
      tell application "System Events"
        set f to property list file (my _filename)
        make new property list item at the end of property list items of contents of f with properties {kind:(class of v), name:k, value:v}
      end tell
    end set_value

    on get_value(k)
      tell application "System Events"
        set f to property list file (my _filename)
        return value of property list item k of contents of f
      end tell
    end get_value

    on get_value_default(k, default)
      try
        return my get_value(k)
      on error
        return default
      end try
    end get_value_default

    on ensure_file()
      if not file_exists(my _filename) then do shell script "defaults write " & quoted form of my _filename & " default 1"
    end ensure_file

  end script

  return run script Storage with parameters {bundleid, filename}
end init

on file_exists(p)
  try
    get POSIX file p as alias
    return true
  on error
    return false
  end try
end file_exists
