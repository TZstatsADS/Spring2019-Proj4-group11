#Normalization of channel probabilities (paper C3 section3, page 95)

readfile <- function(file_name){
  readLines(paste("../data/ground_truth/",file_name,sep=""), warn=FALSE)
}

#read the ground truth text
ground_truth_text <- lapply(file_name_vec, readfile)

#split the text into single character
ground_truth_chr <- tolower(unlist(str_split(unlist(ground_truth_text),"")))

###1. calculate chars[x]: number of times 'x' appeared in the training set
#select characters which are letters or " "
ground_truth_letter <- ground_truth_chr[ground_truth_chr %in% letters|ground_truth_chr ==" "]

#calculate chars[x]
char_x <- table(ground_truth_letter)

#rename chars[x]: replace " " with "@"
names(char_x) <- c("@", letters)

#save
save(char_x, file = "../output/char_x.RData")

###2. calculate chars[x, y]: number of times 'x, y' appeared in the training set (x can be " ").
char_xy <- matrix(0, nrow = 27, ncol = 26)
colnames(char_xy) <- letters
rownames(char_xy) <- c(letters, " ")

#unlist
ground_truth_text_unlist <- tolower(unlist(ground_truth_text))

#calculate the number of appearance for each xy (e.g "ab", " t")
num_appear <- function(pattern){
  sum(lengths(regmatches(ground_truth_text_unlist, gregexpr(pattern, ground_truth_text_unlist))))
}

#assign the value for char_xy matrix
for (x in c(letters, " ")){
  for (y in letters){
    pattern = paste(x, y, sep = "")
    char_xy[x,y] <- num_appear(pattern)
  }
}

#rename
rownames(char_xy) <- c(letters, "@")

#save
save(char_xy, file = "../output/char_xy.RData")
