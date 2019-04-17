perform_correction <- function(typo){
  # check if typo has any candiates
  candidates <- choose_candidate(typo)
  if(length(candidates)==0) {
    return(typo)
  }
  else {
    #choose the candidate with highest score
    scores <- sapply(candidates, calculate_score, typo) 
    candidate_chosen <- candidates[which.max(scores)]
    return(candidate_chosen)
  }
}


