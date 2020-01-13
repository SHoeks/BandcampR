# BandcampR
Download albums for bandcamp albums using R

# Future updates
- Support for Mac and Linux
- Better handling of foreign (non-standard) characters

# Example (on Windows only, for now)

### Install package
```R
library(devtools)
install_github("shoeks/BandcampR")
```

### Load package
```R
library(BandcampR)
```

### Download album
```R
DownloadAlbum('https://{artist_name}.bandcamp.com/album/{album_name}',PATH='C:/Downloads')
```
This function requires two inputs: 
- The album url 
- The target path (download folder)
