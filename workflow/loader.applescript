on init(p)
  script Loader
    property class : "Loader"
    property prefix : missing value

    on run {p}
      set my prefix to p & "::"
      return me
    end run

    on load(filename)
      set scpt to load script POSIX path of my prefix & filename
      return scpt
    end load
  end script

  return run script Loader with parameters {p}
end init
