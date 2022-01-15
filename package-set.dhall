let Package = { name : Text, version : Text, repo : Text, dependencies : List Text }
let base = [
  { name = "base"
  , repo = "https://github.com/dfinity/motoko-base"
  , version = "57c3bb724dfe36928d443f5a81446872bf646de9"
  , dependencies = [ "base" ]
  },
] : List Package
in base