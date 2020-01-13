# capitalize roman numbering
capitalize_roman_numbering = function(titles){
  for(tt in 1:length(titles)){
    temp = str_split(titles[tt],' ',simplify = T)
    ff = c()
    options(warn=-1)
    for(i in 1:length(temp)) ff = c(ff,as.roman(temp[i]))
    options(warn=0)
    ff2 = ff
    ff2[is.na(!ff)] = temp[is.na(!ff)]
    ff2[!is.na(ff)] = str_to_upper(toString(as.roman(ff[!is.na(ff)])))
    titles[tt] = paste0(ff2, collapse = ' ')
  }
  return(titles)
}
