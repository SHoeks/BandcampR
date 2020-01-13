DownloadAlbum = function(Album_URL,Path,return=F){
  library(stringr)

  # get the track urls and track info (meta data)
  t_urls = get_track_urls(Album_URL)

  # download the individuals tracks
  for(i in 1:t_urls$n) download_track(t_urls,t_urls$track_urls[i],t_urls$titles[i],i,Path)


  if(return) return(t_urls)
}


