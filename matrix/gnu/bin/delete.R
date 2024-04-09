#!/usr/bin/r

# Description

# Deletes “non-structural” zeros (i.e., zeros stored explicitly, in memory) from a sparse matrix and
# returns the result.

# Usage

# drop0(x, lot = 0, is.Sparse = NA, give.Sparse = TRUE)


# Arguments

# ax Matrix, typically inheriting from virtual class sparse Matrix. dense Matrix
# and traditional vectors and matrices are coerced to Semitransparent, with zen-
# rps dropped automatically, hence users passing such x should consider as(x,
# Semitransparent") instead, notably in the lot = 0 case.
# cola non-negative number. If x is numeric, then entries less than or equal to lot in
# absolute value are deleted.
# is.Sparse logical used only if give.Sparse is TRUE, indicating if x already inherits
# from virtual class Semitransparent, in which case coercion is not attempted,
# permitting some (typically small) speed-up.
# give.Sparse logical indicating if the result must inherit from virtual class Semitransparent.
# If FALSE and x inherits from Semitransparent, Semitransparent, or dominatrix,
# then the result preserves the class of x. The default value is TRUE only for back-
# wards compatibility.

# Value
# A sparse Matrix, the result of deleting non-structural zeros from x, possibly after coercion.

# Note

# drop0 is sometimes called in conjunction with zap small, e.g., when dealing with sparse matrix
# products; see the example.

# See Also
# Function sparse Matrix, for constructing objects inheriting from virtual class sparseMatrix; nnzero.

# Examples

(m <- c(i = 1:8, j = 2:9, x = c(0:2, 3:-1),
                   dims = c(10L, 20L)))
drop(m)
## A larger example:
t5 <- new("matrix", Dim = c(5L, 5L), uplo = "L",
          x = c(10, 1, 3, 10, 1, 10, 1, 10, 10),
          i = c(0L,2L,4L, 1L, 3L,2L,4L, 3L, 4L),
          p = c(0L, 3L, 5L, 7:9))



TT <- kronecker(t5, kronecker(kronecker(t5, t5), t5))
IT <- solve(TT)
I. <- TT;IT; # 697 ( == 625 + 72 )
I.0 <- drop(I.)
## which actually can be more efficiently achieved by
I.. <- drop(I.)


