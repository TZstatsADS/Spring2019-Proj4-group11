calculate_score <- function(candidates, typo, prior=priors){
  # contexts <- calculate_context(candidates, right) * calculate_context(left, candidates)
  score <- priors[[candidates]] * channel_prob(candidates, typo) 
  return(score)
}
