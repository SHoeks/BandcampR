# read html correctly
processFile = function(filepath) {
  options(warn=-1)
  lines = c()
  con = file(filepath, "r")
  while ( TRUE ) {
    line = readLines(con, n = 1,encoding = "UTF-8")
    if ( length(line) == 0 ) {
      break
    }
    lines = c(lines,line)
  }
  close(con)
  options(warn=0)
  return(lines)
}
