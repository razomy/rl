#
Path Manipulation Operations
#

Path {
  Join(parts List(String)) [ Parts . native_path_join ]
  Dirname(p String)        [ P . native_path_dirname ]
  Basename(p String)       [ P . native_path_basename ]
  Extension(p String)      [ P . native_path_ext ]
  Resolve(p String)        [ P . native_path_resolve ]
  IsAbsolute(p String)     [ P . native_path_is_abs ]
}
