#
Git Version Control Structures
#

GitFileChanges {
  Created  List(String)
  Modified List(String)
  Deleted  List(String)
  Renamed  List((String, String))
}

GitCommitInfo {
  Hash         String
  AuthorName   String
  AuthorEmail  String
  Date         String
  Message      String
  ParentHashes List(String)
}

GitStatus {
  LocalBranch  String
  RemoteBranch String
  RemoteDiff   String
  Clean        Bool
  Changes      GitFileChanges
}
