# add tags (meta data) to downloaded mp3
tag_mp3 = function(file_name,artist,album,title,track_n,bin_dir='C:/Users/Selwyn/Dropbox/BandcampR/Exec/'){

  # set exec path
  id3_exe = paste0(get_lib_path(),'tag_mp3.exe')

  # add meta data to mp3 files
  run = paste0(id3_exe,' -a "',artist,'" -t "',title,'" -l "',album,'" -n "',track_n,'" "',file_name,'"')
  print(run)
  system(run)

}

