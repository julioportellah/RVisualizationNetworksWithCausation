IsingWithCausation<- function(x, or_rules , layout='spring' ,gamma = 0.25){
  t0 <- Sys.time()
  xx <- x
  #Defining variables
  or_rule_cols <- or_rules
  colnames <- colnames(xx)
  isingModel <- Graph_Ising_pre_or <-IsingFit(xx, family='binomial', AND = FALSE, gamma = gamma, 
                                              plot = FALSE, progressbar = TRUE, lowerbound.lambda = NA)
  adjMatrix <- isingModel$asymm.weights
  
  # Performing the and operation
  adj <- adjMatrix
  adj <- (adj!=0)*1
  EN.weights <- adj * t(adj)
  EN.weights <- EN.weights * adjMatrix
  meanweights.opt <- (EN.weights+t(EN.weights))/2
  diag(meanweights.opt) <- 0 
  
  for (i in or_rule_cols){
    meanweights.or <- (adjMatrix+t(adjMatrix))/2
    diag(meanweights.or) <- 0
    meanweights.opt[,i]<-meanweights.or[,i] 
  }
  adj_matrix_mixed <- meanweights.opt
  colnames(adj_matrix_mixed) <- rownames(adj_matrix_mixed) <- colnames
  
  direc_mtx <- matrix(FALSE,ncol(xx),ncol(xx))
  direc_mtx[,or_rule_cols] <- TRUE
  direc_mtx[or_rule_cols,] <- TRUE
  
  q <- qgraph(adj_matrix_mixed,layout=layout,labels=names(adj_matrix_mixed),directed=direc_mtx)
  
  Res <- list(weiadj = adj_matrix_mixed, q = q)
  class(Res) <- "IsingCausalMix"
  return(Res)
}