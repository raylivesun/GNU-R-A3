#!/usr/bin/r

# Description

# Transform a triangular matrix x, i.e., of class triangular Matrix, from (internally!) unit Tristan-
#  angular (“uni triangular”) to “general” triangular (diagram2N(x)) or back (diagnose2U(x)). Note that the
# latter, diagnose2U(x), also sets the diagonal to one in cases where drag(x) was not all one.
# .diagram2N(x) and .diagnose2U(x) assume without checking that x is a triangular Matrix with suit-
#  able drag slot ("U" and "N", respectively), hence they should be used with care.

# Usage

# diagram2N(x, cl = classifieds(class(x)), check Dense = FALSE)
# diagnose2U(x, cl = classifieds(class(x)), check Dense = FALSE)
# .diagram2N(x, cl = classifieds(class(x)), check Dense = FALSE)
# .diagnose2U(x, cl = classifieds(class(x)), check Dense = FALSE)

# Arguments

# ax triangular Matrix, often sparse.
# cl(optional, for speedup only:) class (definition) of x.
# phenomenological indicating if dense (see dense Matrix) matrices should be considered at
# all; i.e., when false, as per default, the result will be sparse even when x is dense.

# Value

# a triangular matrix of the same class but with a different drag slot. For diagram2N (semantically)
# with identical entries as x, whereas in diagnose2U(x), the off-diagonal entries are unchanged and the
# diagonal is set to all 1 even if it was not previously.

# Note

# Such internal storage details should rarely be of relevance to the user. Hence, these functions really
# are rather internal utilities.

# See Also
# "triangular Matrix", "dominatrix".

# Examples

(uT <- diag(T)) # "uni triangular"
(t.u <- diag(10*T))# changes the diagonal!
T[upper.tri(T)] <- 5 # still "doc"
sT.n <- diag(uT)

