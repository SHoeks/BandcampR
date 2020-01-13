# functions gets the track urls
get_track_urls = function(album_url){

  # set exec path
  phantomjs_exe=paste0(get_lib_path(),'get_page.exe')

  # set temp dir
  temp_dir=paste0(gsub("\\\\", "/", tempdir()))

  # create return object
  return_list = list()

  # init phantomjs
  vars = paste0("var webPage = require('webpage'); var page = webPage.create();
          var fs = require('fs'); var path = '",temp_dir,"/page.html'")
  func = paste0("page.open('",album_url,"', function (status) {
      var content = page.content;
      fs.write(path,content,'w')
      phantom.exit();
  });")
  js_file_path = paste0(temp_dir,"/download_page.js")
  fileConn<-file(js_file_path)
  writeLines(c(vars,func),fileConn)
  close(fileConn)

  # run phantomjs and read page
  system(paste0(phantomjs_exe," ",js_file_path))
  a = processFile(paste0(temp_dir,"/page.html"))
  a = paste(a, collapse = ' ')

  # find track urls
  t = str_split(a,'track')[[1]]
  t = str_remove(t[str_detect(t,'" itemprop=\"url\"><span class=\"')],'" itemprop=\"url\"><span class=\"')
  t_urls = paste0(str_split(album_url,'/album/')[[1]][1],'/track',t)

  # get album name
  t = str_split(a,'"trackTitle" itemprop="name"')[[1]]
  t = str_sub(t[2],1,100)
  t = str_trim(str_split(t,'>')[[1]][2])
  t = str_trim(str_split(t,"<")[[1]][1])
  t = str_replace_all(t,'\\|','')
  t = str_replace_all(t, "[[:punct:]]", " ")
  t = str_replace_all(t, "  ", " ")
  album = toString(t)

  # get artist name
  t = str_split(a,'itemprop="byArtist"')[[1]][2]
  t = str_sub(t,1,100)
  t = str_split(t,'bandcamp.com\">')[[1]][2]
  t = str_split(t,"<")[[1]][1]
  t = str_to_lower(t)
  artist = correct_capitalization(t)

  # get track titles
  t = str_split(a,'span class="track-title" itemprop=\"name\">')[[1]]
  t = str_sub(t,1,100)[2:length(t)]
  t = str_split(t,'</span>',simplify = T)
  t = t[!str_detect(t,'span')]
  return_list$raw_track_names = t
  titles = str_replace_all(t, "  ", " ")
  titles = str_to_lower(titles)
  for(i in 1:length(titles)) titles[i] = correct_capitalization(titles[i])


  # fill return object
  return_list$artist = artist
  return_list$album = str_trim(album)

  # check indivudual words track titles
  titles = capitalize_roman_numbering(titles)

  return_list$titles = titles[1:length(t_urls)]
  return_list$titles = str_replace_all(return_list$titles, "[[:punct:]]", " ")
  for(i in 1:length(return_list$titles)) return_list$titles[i] = correct_capitalization(return_list$titles[i])
  return_list$track_urls = t_urls[1:length(t_urls)]
  return_list$n = length(t_urls)

  # return track urls
  return(return_list)

}
