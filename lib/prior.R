#define ELE function
ele <- function(x) {
  pr_c <- (x + 0.5)/(N + V/2)
  return(pr_c)
  }


# calculate the prior probabilities 
prior_prob <- function(train_corpus){
  train_corpus <- tolower(train_corpus)
  N <- length(candidate_dict) ##########
  V <- length(train_corpus) ###########
  #calculate freq(c)
  freqs <- rep(list(0), length(candidate_dict))
  names(freqs) <- candidate_dict
  nonzero_freqs <- table(train_corpus)
  freqs[names(nonzero_freqs)] <- nonzero_freqs
  priors <- lapply(freqs, ele) #ELE
  return(priors)
}
