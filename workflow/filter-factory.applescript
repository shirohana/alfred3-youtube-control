on create()
  script FilterFactory
    property class : "FilterFactory"
    property rows : {}
    property labels : {"title", "subtitle", "arg", "icon", "valid", "match", "autocomplete", "type"}

    on add given T:_title, S:_sub, A:_arg, I:_icon, V:_valid, M:_match, C:_ac, TY:_type
      set end of my rows to {_title, _sub, _arg, _icon, _valid, _match, _ac, _type}
    end add

    on to_json()
      set json to "{" & q("items") & ":["

      repeat with row in my rows
        set json to json & "{"
        repeat with index from 1 to length of row
          set value to item index of row
          set label to item index of my labels

          if label is "icon" then
            set json to json & q("icon") & ":{" & q("path") & ":" & q(value) & "}" & ","
          else if label is "valid" and value is 0 then
            set json to json & q("valid") & ":" & q("false") & ","
          else if label is "match" and class of value is not text then
            # Do nothing
          else
            set json to json & q(label) & ":" & q(value) & ","
          end if
        end repeat
        set json to (text 1 thru -2 of json) & "},"
      end repeat

      if length of my rows > 0 then set json to (text 1 thru -2 of json)
      set json to json & "]}"

      return json
    end to_json

  end script

  return FilterFactory
end create

on q(str)
  return "\"" & str & "\""
end q
