% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/IBM_theoretical_contrast.R
\name{IBM_theoretical_contrast}
\alias{IBM_theoretical_contrast}
\title{Theoretical contrast in the Inversion - Best Matching (IBM) method}
\usage{
IBM_theoretical_contrast(
  par,
  theo.par,
  fixed.p.X = NULL,
  G = NULL,
  comp.dist,
  comp.param,
  sample1,
  sample2
)
}
\arguments{
\item{par}{Numeric vector with two elements, corresponding to the two parameter values at which to compute the contrast. In practice
the component weights for the two admixture models.}

\item{theo.par}{Numeric vector with two elements, the known (true) mixture weights.}

\item{fixed.p.X}{Arbitrary value chosen by the user for the component weight related to the unknown component of the first
admixture model. Only useful for optimization when the known components of the two models are identical
(G1=G2, leading to unidimensional optimization).}

\item{G}{Distribution on which to integrate when calculating the contrast.}

\item{comp.dist}{A list with four elements corresponding to the component distributions (specified with R native names for these distributions)
involved in the two admixture models. The two first elements refer to the unknown and known components of the 1st admixture model,
and the last two ones to those of the second admixture model. No unknown elements permitted.
For instance, 'comp.dist' could be specified as follows: list(f1='rnorm', g1='norm', f2='rnorm', g2='norm').}

\item{comp.param}{A list with four elements corresponding to the parameters of the component distributions, each element being a list
itself. The names used in this list must correspond to the native R argument names for these distributions.
The two first elements refer to the parameters of unknown and known components of the 1st admixture model, and the last
two ones to those of the second admixture model. No unknown elements permitted. For instance, 'comp.param' could be specified
as follows: : list(f1 = list(mean=2,sd=0.3), g1 = list(mean=0,sd=1), f2 = list(mean=2,sd=0.3), g2 = list(mean=3,sd=1.1)).}

\item{sample1}{Observations of the first sample under study.}

\item{sample2}{Observations of the second sample under study.}
}
\value{
The theoretical contrast value evaluated at parameter values.
}
\description{
Defines the theoretical contrast in the IBM approach. Useful in case of simulation studies, since all parameters are
known to the user. For further information about the considered contrast in the IBM approach, see 'Details' below.
}
\details{
See the paper presenting the IBM approach at the following HAL weblink: https://hal.science/hal-03201760
}
\examples{
## Simulate data:
list.comp <- list(f1 = 'norm', g1 = 'norm',
                  f2 = 'norm', g2 = 'norm')
list.param <- list(f1 = list(mean = 3, sd = 0.5), g1 = list(mean = 0, sd = 1),
                   f2 = list(mean = 1, sd = 0.1), g2 = list(mean = 5, sd = 2))
sample1 <- rsimmix(n=1500, unknownComp_weight=0.5, comp.dist = list(list.comp$f1,list.comp$g1),
                                                   comp.param=list(list.param$f1,list.param$g1))
sample2 <- rsimmix(n=2000, unknownComp_weight=0.7, comp.dist = list(list.comp$f2,list.comp$g2),
                                                   comp.param=list(list.param$f2,list.param$g2))
## Create the distribution on which the contrast will be integrated:
G <- stats::rnorm(n = 1000, mean = sample(c(sample1[['mixt.data']],sample2[['mixt.data']]),
                                          size = 1000, replace = TRUE),
                  sd = stats::density(c(sample1[['mixt.data']],sample2[['mixt.data']]))$bw)
## Compute the theoretical contrast at parameters (p1,p2) = (0.2,0.7):
IBM_theoretical_contrast(par = c(0.2,0.7), theo.par = c(0.5,0.7), fixed.p.X = NULL, G = G,
                         comp.dist = list.comp, comp.param = list.param,
                         sample1 = sample1[['mixt.data']], sample2 = sample2[['mixt.data']])

}
\author{
Xavier Milhaud \href{mailto:xavier.milhaud.research@gmail.com}{xavier.milhaud.research@gmail.com}
}
