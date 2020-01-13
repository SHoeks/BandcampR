# BandcampR
Download albums for bandcamp albums using R

# Future updates
- Support for Mac and Linux
- Better handling of foreign (non-standard) characters

# Example (on Windows only, for now)

### Install package
library(devtools)
install_github("shoeks/BandcampR")

### Load package
library(BandcampR)

### Download album
DownloadAlbum('https://{artist_name}.bandcamp.com/album/{album_name}',PATH='C:/Downloads')
This function requires the album link and the path to download the songs to
