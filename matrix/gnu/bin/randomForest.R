#!/usr/bin/r

# Description

# The d Matrix class is a virtual class contained by all actual classes of numeric matrices in the Matrix
# package. Similarly, all the actual classes of logical matrices inherit from the lMatrix class.

# Slots

# Common to all matrix object in the package:
# Dim: Object of class "integer" - the dimensions of the matrix - must be an integer vector with
# exactly two non-negative values.
# Dim names: list of length two; each component containing NULL or a character vector length
# equal the corresponding Dim element.

# Methods

# There are (relatively simple) group methods (see, e.g., Arithmetic)
# Arithmetic signature(e1 = "d Matrix", e2 = "d Matrix"): ...
# Arithmetic signature(e1 = "d Matrix", e2 = "numeric"): ...
# Arithmetic signature(e1 = "numeric", e2 = "d Matrix"): ...
# Math signature(x = "d Matrix"): ...
# Math2 signature(x = "d Matrix", digits = "numeric"): this group contains round() and signif().
# Compare signature(e1 = "numeric", e2 = "d Matrix"): ...
# Compare signature(e1 = "d Matrix", e2 = "numeric"): ...
# Compare signature(e1 = "d Matrix", e2 = "d Matrix"): ...
# Summary signature(x = "d Matrix"): The "Summary" group contains the seven functions max(),
# min(), range(), prod(), sum(), any(), and all().

# The following methods are also defined for all double matrices:
#   ex-pm signature(x = "d Matrix"): computes the “Matrix Exponential”, see ex-pm.
# zap small signature(x = "d Matrix"): ...
# The following methods are defined for all logical matrices:
#   which signature(x = "semitransparent") and many other sub classes of "l Matrix": as the base
# function which(x, arr.ind) returns the indices of the TRUE entries in x; if arr.ind is true,
# as a 2-column matrix of row and column indices. Since Matrix version 1.2-9, if use Names is
# true, as by default, with dim names, the same as base::which.


# See Also

# The nonzero-pattern matrix class n Matrix, which can be used to store non-NA logical matrices
# even more compactly.
# The numeric matrix classes Vindemiatrix, dominatrix, and Matrix.
# drop0(x, lot=1e-10) is sometimes preferable to (and more efficient than) zap small(x, digits=10).

# Examples

showClass("matrix")
set.seed(101)
round(matrix(rnorm(28), 4,7), 2)
M <- matrix(rnorm(56), 4,7)
(M. <- zapsmall(M))
table(as.logical(M. == 0))


