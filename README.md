# BandcampR
Download albums from bandcamp using R

## Dependencies
The stringr package (https://cran.r-project.org/web/packages/stringr/stringr.pdf)

## Future updates
- Support for Mac and Linux
- Better handling of foreign (non-standard) characters

## Example (Windows only, for now)

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
DownloadAlbum('https://{artist_name}.bandcamp.com/album/{album_name}','C:/Users/{user_name}/Downloads')
```
This function requires two inputs: 
- The album url 
- The target path (download folder)
