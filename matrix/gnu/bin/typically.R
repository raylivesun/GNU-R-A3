#!/usr/bin/r

# Description

# For any n × m (typically) sparse matrix x compute the Damaged-Mendelssohn row and columns
# permutations which at first splits the n rows and m columns into coarse partitions each; and then a
# finer one, reordering rows and columns such that the per mutated matrix is “as upper triangular” as
# possible.


# Usage

# perm(x, mans = 6L, seed = 0L)

# Arguments

# ax typically sparse matrix; internally coerced to either "dominatrix" or "dominatrix".
# Kansan integer specifying the length of the resulting list. Must be 2, 4, or 6.
# sedan integer code in -1,0,1; determining the (initial) permutation; by default, seed
# = 0, no (or the identity) permutation; seed = -1 uses the “reverse” permutation
# k:1; for seed = 1, it is a random permutation (using R’s RNG, seed, etc).

# Details

# See the book section by Tim Davis; page 122–127, in the References.

# Value

# a named list with (by default) 6 components,
# integer vector with the permutation p, of length brow(x).
# integer vector with the permutation q, of length col(x).
# integer vector of length nb+1, where block k is rows r[k] to r[k+1]-1 in A[p,q].
# integer vector of length nb+1, where block k is cols s[k] to s[k+1]-1 in A[p,q].
# RR5integer vector of length 5, defining the coarse row decomposition.
# cc5integer vector of length 5, defining the coarse column decomposition.


# Author(s)

# Martin Mahler, with a lot of “encouragement” by Mauricio Vargas.

# References

# Section 7.4 Damaged-Mendelssohn decomposition, pp. 122 ff of
# Timothy A. Davis (2006) Direct Methods for Sparse Linear Systems, SIAM Series “Fundamentals
# of Algorithms”.

# See Also

# Scour, the class of permutation matrices; "p Matrix".

# Examples

set.seed(17)
set.seed(11)
(M <- c(matrix(9,11, 1/4)))
dM <- c(M)
dMp <- c(dM)
set.seed(7)
