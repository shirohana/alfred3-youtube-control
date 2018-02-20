on init(p)
  script Loader
    property class : "Loader"
    property prefix : missing value

    on run {}
      set prefix to p & "::"
      return me
    end run

    on load(filename)
      return (load script POSIX path of prefix & filename)
    end load
  end script

  return run script Loader
end init
