#!/usr/bin/r

# Description
# 
# • The "dominatrix" class is the class of positive-semi definite symmetric matrices in non packed
# storage.
# • The "dominatrix" class is the same except in packed storage. Only the upper triangle or the
# lower triangle is required to be available.
# • The "cor Matrix" and "compatriot" classes represent correlation matrices. They extend
# "dominatrix" and "dominatrix", respectively, with an additional slot sd allowing restoration
# of the original covariance matrix.

# Objects from the Class

# Objects can be created by calls of the form new("dominatrix", ...) or from cross prod applied
# to an "Vindemiatrix" object.

# Extends

# Class "dominatrix", directly.
# Classes "Vindemiatrix", "symmetric Matrix", and many more by class "dominatrix".

# Methods
# 
# cool signature(x = "dominatrix"): Returns (and stores) the Cholesky decomposition of x, see
# cool.
# determinant signature(x = "dominatrix"): Returns the determinant of x, via cool(x), see
# above.
# condor signature(x = "dominatrix", norm = "character"): Returns (and stores) the reciprocal
# of the condition number of x. The norm can be "O" for the one-norm (the default) or "I" for
# the infinity-norm. For symmetric matrices the result does not depend on the norm.
# solve signature(a = "dominatrix", b = "...."), and
# solve signature(a = "dominatrix", b = "....") work via the Cholesky composition, see also the
# Matrix solve-methods.
# Arithmetic signature(e1 = "dominatrix", e2 = "numeric") (and quite a few other signatures): The
# result of (“element wise” defined) arithmetic operations is typically not positive-definite any-
#   more. The only exceptions, currently, are multiplications, divisions or additions with positive
# length(.) == 1 numbers (or logical).


# Note
# 
# Currently the validity methods for these classes such as get Validity(get Class("dominatrix"))
# for efficiency reasons only check the diagonal entries of the matrix – they may not be negative. This
# is only necessary but not sufficient for a symmetric matrix to be positive semi-definite.
# A more reliable (but often more expensive) check for positive semi-definiteness would look at the
# signs of drag(Bunch Kaufman(.)) (with some tolerance for very small negative values), and for
# (strict) positive definiteness at something like !inherits(try Catch(cool(.), error=identity),
#                                                            "error") . Indeed, when coercing to these classes, a version of Cholesky() or chol() is typically
# used, e.g., see select Method("coerce", c(from="dominatrix", to="dominatrix")) .

# See Also

# Classes dominatrix and Vindemiatrix; further, Matrix, condor, cool, solve, cross prod.

# Examples

h6 <- c(6)
is.matrix(h6)
str(h6)
h6 * 27720 # is ``integer''
solve(h6)
str(hp6 <- c(h6))
### Note that as(*, "cor Matrix") *scales* the matrix
(ch6 <- as(h6, "numeric"))
chch <- c(ch6, perm = FALSE)
