# Mixed Network Visualization Function

R project where the directed and undirected networks are combined in a single plot. This is useful for visualizing networks with vertex that are only directional like the marital status in a network of symptoms.

## Note:

The function is currently exclusive for the Ising Model generated networks but it is expected for further expansion in the future

## Description

The function is an expansion to the R IsingFit function that allows the user to use the OR mode in some columns. The algorithm will apply the AND rule first and then it will use the OR rule on the selected columns by the user. The algorithm will return the adjacency matrix of the network and the network graph generated through the qgraph function.

To use it, you must install the following libraries:

* library(qgraph)
* library(IsingFit)

## Usage

```
IsingWithCausation(x, or_rules, layout = 'spring', gamma = 0.25)
```

## Arguments

x             Input matrix. The dimension of the matrix is nobs x nvars; each row is a vectorof observations of the variables. Must be cross-sectional data

or_rules      Array with the position of the columns that will enforce the OR rule

layout        The network layout is based on the qgraph layout option. In the IsingFit package the returning graph was with the **spring** layout.

gamma         A value of hyperparameter gamma in the extended BIC. Can be anything be-tween 0 and 1. Defaults to .25

## Value

The function returns (invisibly) a ’IsingCausalMix’ object that contains the following items

weiadj        The Weighted adjacency matrix

q             The object that is returned by qgraph (class ’qgraph’)

## Examples

```
library("qgraph")
library("IsingSampler")
library("IsingFit")

N <- 6 # Number of nodes
nSample <- 1000 # Number of samples

# Ising parameters:
Graph <- matrix(sample(0:1,N^2,TRUE,prob = c(0.8, 0.2)),N,N) * runif(N^2,0.5,2)
Graph <- pmax(Graph,t(Graph))
diag(Graph) <- 0
Thresh <- -rowSums(Graph) / 2

# Simulate:
Data <- IsingSampler(nSample, Graph, Thresh)
result <- IsingWithCausation(Data, c(6), layout = 'spring', gamma = 0)
result$weiadj
result$q
```

