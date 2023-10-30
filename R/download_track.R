# function downloads track (mp3)
download_track = function(t_urls,track_url,track_filename,track_number,PATH){

  # set exec path
  if(Sys.info()["sysname"]=="Darwin"){
    wget_exe= "/opt/homebrew/bin/wget"
  }else if(Sys.info()["sysname"]=="Windows"){
    wget_exe = paste0(get_lib_path(),'get_mp3.exe')
  }

  # set temp dir
  temp_dir=paste0(gsub("\\\\", "/", tempdir()))

  # get bandcamp track page
  run = paste0(wget_exe,' --output-document="',temp_dir,'/track.txt" ',track_url)
  print(run)
  system(run)
  f = readChar(paste0(temp_dir,"/track.txt"), file.info(paste0(temp_dir,"/track.txt"))$size)

  # find track url
  l = str_locate(f,"mp3-128")
  if(is.na(l[1,1])) return(NA) # no track available
  f2 = str_sub(f,l[1],l[2]+1000)
  f2 = str_split(f2,"https",simplify = T)
  f2 = str_split(f2,"\\}",simplify = T)
  if(nrow(f2)<2){
    print('ooh')
    f2 = str_split(f,'t4.bcbits.com/stream/',simplify = T)[2]
    f2 = str_split(f2,'\\}',simplify = T)[1]
    f2 = paste0('https://t4.bcbits.com/stream/',str_remove(f2,'\\"'))
  }else{
    f2 = paste0("https",f2[2,1])
    f2 = str_sub(f2,1,str_length(f2)-1)
  }

  # create folder for track
  if(substr(PATH , nchar(PATH ), nchar(PATH))!='/') PATH = paste0(PATH,'/')
  folder = paste0(PATH,'/',t_urls$artist,'/',str_replace_all(t_urls$album, "[[:punct:]]", " "))
  dir.create(folder,recursive=T,showWarnings=F);

  ## downloads mp3
  system(paste0(wget_exe,' -qc --output-document="',temp_dir,'/',track_filename,'.mp3" "',f2,'"'))


  # tag the downloaded mp3s
  tag_mp3(paste0(temp_dir,'/',track_filename,'.mp3'),t_urls$artist,t_urls$album,track_filename,track_number)


  file.copy(paste0(temp_dir,'/',track_filename,'.mp3'), paste0(folder,'/',track_filename,'.mp3'))
  file.remove(paste0(temp_dir,'/',track_filename,'.mp3'))

}
