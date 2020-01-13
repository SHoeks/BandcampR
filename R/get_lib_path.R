get_lib_path = function(lib_name='BandcampR',lib_paths=.libPaths()){
  return(paste0(lib_paths[grep(lib_name,lapply(lib_paths,list.files))][1],'/',lib_name,'/'))
}
