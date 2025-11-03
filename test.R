library(stringr)

albumurl = "https://yelloweyes.bandcamp.com/album/confusion-gate"
destdir = "/Users/osx/Downloads/"

# helper function
select = function(x,i) x[i]

# grep artist url
artisturl = strsplit(albumurl,".bandcamp.com/")[[1]]
artisturl = paste0(artisturl[1],".bandcamp.com")
print(artisturl)

# download album url
tmpfile = tempfile(fileext = ".html")
download.file(albumurl, destfile=tmpfile)

# get track info
a = readLines(tmpfile)
ttitles = a[grep("track-title",a)]
ttitles = strsplit(ttitles,"\"track-title\">")
ttitles = lapply(ttitles,select,i=2)
ttitles = gsub("</span></a>", "", ttitles)
turlsbc = a[grep("track-title",a)]
turlsbc = regmatches(turlsbc, regexpr('(?<=href=")[^"]+', turlsbc, perl = TRUE))
turlsbc = paste0(artisturl,turlsbc)

# get artist and album names
#system2("code",args=tmpfile)
artistname = a[grep("data-band=",a)]
artistname = str_split(artistname,"data-band=")
artistname = gsub("&quot;",'"',artistname)
artistname = gsub("&amp;",'&',artistname)
artistname = str_split(artistname,'"artist"[:]"')[[1]][2]
artistname = str_split(artistname,'"[,]')[[1]][1]
albumtitle = a[grep("data-band=",a)]
albumtitle = str_split(albumtitle,"data-band=")
albumtitle = gsub("&quot;",'"',albumtitle)
albumtitle = gsub("&amp;",'&',albumtitle)
albumtitle = str_split(albumtitle,'"album_title"[:]"')[[1]][2]
albumtitle = str_split(albumtitle,'"[,]')[[1]][1]

# get track raw urls
a = readLines(tmpfile)
turls = a[grep("data-band=",a)]
turls = gsub("&quot;",'"',turls)
turls = gsub("&amp;",'&',turls)
turls = strsplit(turls,'"file":[{]"mp3-128":"')[[1]]
turls = turls[grep("^https",turls)]
turls = strsplit(turls,'"[}]')
turls = lapply(turls,select,i=1)
turls = unlist(turls)

# get track names
a = readLines(tmpfile)
tnames = a[grep("data-band=",a)]
tnames = gsub("&quot;",'"',tnames)
tnames = gsub("&amp;",'&',tnames)
tnames = strsplit(tnames,'"title"[:]"')[[1]]
tnames = tnames[grep("unreleased_track",tnames)]
tnames = str_split(tnames,'"[,]')
tnames = lapply(tnames,select,i=1)
tnames = unlist(tnames)

# get album cover art
a = readLines(tmpfile)
albumarturl = a[grep("popupImage",a)][1]
albumarturl = str_split(albumarturl,'href[=]"')[[1]][2]
albumarturl = str_split(albumarturl,'">')[[1]][1]
print(albumarturl)

# make artist album dir
albumdir = paste0(artistname," - ",albumtitle)
print(albumdir)
albumdir = file.path(destdir,albumdir)
print(albumdir)
dir.create(albumdir, showWarnings = FALSE)

# make mp3 names
mp3paths = file.path(albumdir,paste0(tnames,".mp3"))

# download tracks
for(i in seq_along(turls)){
  print(paste0("downloading track: ",i,"/",length(turls)))
  print(tnames[i])
  download.file(turls[i], destfile=mp3paths[i])
}

# download album cover art
download.file(albumarturl, file.path(albumdir,"_cover.jpg"))







