#
Path Manipulation Operations
#

Path {
  Join(Parts List(String)) [ Parts . native_path_join ]
  Dirname(P String)        [ P . native_path_dirname ]
  Basename(P String)       [ P . native_path_basename ]
  Extension(P String)      [ P . native_path_ext ]
  Resolve(P String)        [ P . native_path_resolve ]
  IsAbsolute(P String)     [ P . native_path_is_abs ]
}
