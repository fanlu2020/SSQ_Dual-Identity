#########################################################
## The dual identity of Asian Americans
## Code for creating factor analysis presented
## in manuscript and section 2 of supplementary materials
#########################################################

getwd()
setwd("return output from getwd()")

rm(list=ls(all=TRUE))

library(foreign) 
library(psych)
library(MASS)
library(GPArotation)

install.packages("psych")
install.packages("GPArotation")

dat2 <- read.dta("DualIDpostNAAS16factor.dta", convert.factors=TRUE)
head(dat2, n=30)

#
#
R <- cor(scale(dat2), use="pairwise")
R
#
res <- fa(R, nfactors=2, rotate="none", fm="pa",cor="poly")
res
#
#
#
plot(res$values, main = "Scree plot",type="b", ylab="Eigenvalue", xlab="Eigenvalue #", pch=16)
#
#
#
print(loadings(res), cutoff=0)
#
#
#
lambda <- loadings(res)
coms <- apply(lambda, 1, function(x)sum(x^2))
uniq <- 1 - coms
cbind(coms, uniq)
lambda
#
plot(c(-1.,1.1), c(-0.5, .6), main = "2-factor unrotated solution", type="n", xlab="Factor 1", ylab="Factor 2")
arrows(rep(0, nrow(lambda)), rep(0, nrow(lambda)), lambda[,1], lambda[,2], code=2)
abline(h=0, v=0)
text(lambda[,1], lambda[,2], rownames(R))
#
# Apply oblique rotation
#
res2 <- fa(R, nfactors=2, rotate="promax", fm="pa")
#
lambda2 <- loadings(res2)
lambda2
#
plot(c(-1.1,1.1), c(-.3, .9), type="n", xlab="Factor 1", ylab="Factor 2", 
     main="Components of AAPI social identity \n (Promax rotation)")
arrows(rep(0, nrow(lambda2)), rep(0, nrow(lambda2)), lambda2[,1], lambda2[,2], code=2)
abline(h=0, v=0)
text(lambda2[,1], lambda2[,2], rownames(R), cex=0.8, adj = -0.2)



