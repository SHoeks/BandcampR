# set wd
setwd('C:/Users/Selwyn/Dropbox/BandcampR/')

# unload pkg and remove installation
detach("package:BandcampR", unload=TRUE); remove.packages('BandcampR')

# install pkg
install.packages('BandcampR_0.1.0.zip', repos = NULL)
.rs.restartR()

# test run
library(BandcampR)

# test function
DownloadAlbum('https://witchesbrew024.bandcamp.com/album/witches-brew',getwd())
