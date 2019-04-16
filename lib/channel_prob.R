



#split the text into single character
train_truth_chr <- tolower(unlist(str_split(paste(train_truth_text, collapse = "#"),"")))

###1. calculate chars[x]: number of times 'x' appeared in the training set
#select characters which are letters or " "
train_truth_letter <- train_truth_chr[train_truth_chr %in% letters|train_truth_chr =="#"]

#calculate chars[x]
char_x <- table(train_truth_letter)

#rename chars[x]: replace " " with "#"
names(char_x) <- c("#", letters)

###2. calculate chars[x, y]: number of times 'x, y' appeared in the training set (x can be " ").
################################have problem here###############################################
xy_list = c()

for (i in 1: length(train_truth_chr)-1){
  substring <- paste(train_truth_chr[i:(i+1)], collapse = "")
  xy_list[i] = substring
}

char_xy = table(xy_list)


# calculate the channel probabilities
channel_prob <- function(candidates, typo){
  if (length(candidates) > 0){
  # calculate Approximate String Distances
  distance <- adist(tolower(typo), candidates, counts = TRUE)
  
  #classify the type of typo
  typo_type = rep(NA, length(candidates))
  
  # deletion
  typo_type[attr(distance, "counts")[,,'ins'] == 1 & distance != 2] = "DEL"
  #insertion
  typo_type[attr(distance, "counts")[,,'del'] == 1 & distance != 2] = "INS"
  #reversal
  typo_type[distance == 2] = "REV"
  #substitution
  typo_type[attr(distance, "counts")[,,'sub'] == 1] = "SUB"
  
  # calculate the channel prob
  numerator = rep(0, length(candidates))
  demoninator = rep(0, length(candidates))
  
  for (i in 1:length(candidates)){
    if (typo_type[i] == "DEL"){
      p <- str_locate(attr(distance,"trafos")[i], 'I')[1]
      Cp_1 <- ifelse(p == 1, "#", substr(candidates[i], (p-1), (p-1)))
      Cp <- substr(candidates[i], p, p)
      numerator[i] <- del.mat[Cp_1, Cp]
      demoninator[i] = char_xy[paste(Cp_1, Cp, sep="")]
    }
    
    if (typo_type[i] == "INS"){
      p <- str_locate(attr(distance,"trafos")[i], 'D')[1]
      Cp_1 <- ifelse(p == 1, "#", substr(candidates[i], (p-1), (p-1)))
      Tp <- substr(typo, p, p)
      numerator[i] <- add.mat[Cp_1,  Tp]
      demoninator[i] = char_x[Cp_1]
    }
    
    if (typo_type[i] == "REV"){
      p <- str_locate(attr(distance,"trafos")[i], 'D')[1]
      Cp <- substr(candidates[i], p, p)
      Cp1 <- substr(candidates[i], (p+1), (p+1))
      numerator[i] <- rev.mat[Cp,  Cp1]
      demoninator[i] = char_xy[paste(Cp, Cp1, sep="")]
    }
    if (typo_type[i] == "SUB"){
      p <- str_locate(attr(distance,"trafos")[i], 'S')[1]
      Cp <- substr(candidates[i], p, p)
      Tp <- substr(typo, p, p)
      numerator[i] <- sub.mat[Tp,  Cp]
      demoninator[i] = char_xy[paste(Tp, Cp, sep="")]
    }
    
  }
  return(numerator/demoninator)
  }
  else{
    return(1)
  }
}
  
 
  # treat non-alphabetic characters as one class and assume their frequency would be larger than the others 
  #numerator <- ifelse(is.numeric(numerator), numerator, 0.00001)
  #denom <- ifelse(is.numeric(denom), denom, 0.00001)





