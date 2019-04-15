
#####################################################################################
#### this R file includes all the scoring functions which implemented in C2 Paper ###
#####################################################################################



# Levenshtein edit distance

LED_score <- function(w_c){
  return(1 - (stringdist::stringdist(w_c,w_e)/(1+stringdist::stringdist(w_e,total_candidate[[w_e]][length(total_candidate[[w_e]])]))))
}


# String similarity
## One issue we found for this calculation is that there's a discrepancy between this C2 paper and the original paper "Islam and Inkpen, 2009a"
## C2 paper has "squared" on the numerator for each scoring calculation, while the original paper does not

SS_score <- function(w_c){
  
  NLS_score <- function(){
    res <- c()
    i <- 1
    len <- nchar(w_c)
    for(item in str_split(w_e,'')[[1]]){
      if(sum(item %in% str_split(w_c,'')[[1]][i:len]) > 0){
        res <- c(res,item)
        i <- which(item == str_split(w_c,'')[[1]]) + 1
      }
    }
    return((2*(length(res)^2))/(nchar(w_c)+nchar(w_e)))
  }
  
  NM1_score <- function(){
    len <- 0
    for(i in 1:min(nchar(w_c),nchar(w_e))){
      if(substr(w_c,i,i) == substr(w_e,i,i)){
        len <- len + 1
      }
      else{break}
    }
    return(2*(len^2)/(nchar(w_c)+nchar(w_e)))
  }
  
  NMn_score <- function(){
    subsequence <- c()
    len <- 0
    for(i in 1:min(nchar(w_c),nchar(w_e))){
      if(substr(w_c,i,i) == substr(w_e,i,i)){
        len <- len + 1
        subsequence <- c(subsequence,len)
      }
      else{
        subsequence <- c(subsequence,len)
        len <- 0
      }
    }
    return(2*(max(subsequence)^2)/(nchar(w_c) + nchar(w_e)))
  }

  NMz_score <- function(){
    len <- 0
    for(i in 0:min(nchar(w_c)-1,nchar(w_e)-1)){
      if(substr(w_c,nchar(w_c)-i,nchar(w_c)-i) == substr(w_e,nchar(w_e)-i,nchar(w_e)-i)){
        len <- len + 1
      }
      else{break}
    }
    return(2*(len^2)/(nchar(w_c)+nchar(w_e)))
  }
  
  # The reason we picked 1/4 for each coefficient is that the originial paper "Islam Inkpen, 2009a" used 1/4.
  # But from a more technical perspective, we should do cross validation and confirm 1/4 is truly the most optimal value.
  
  return(NLS_score()/4+NM1_score()/4+NMn_score()/4+NMz_score()/4)
}



# Language popularity

LP_score <- function(w_c){
  freq <- c()
  for(i in total_candidate[[w_e]]){
    freq <- c(freq,sum(i == corpus))
  }
  freq_c <- sum(w_c == corpus)
  return(freq_c/max(freq))
}

correction <- function(x){
  return(x %in% true_correction)
}