% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/IBM_tabul_stochasticInteg.R
\name{IBM_tabul_stochasticInteg}
\alias{IBM_tabul_stochasticInteg}
\title{Distribution of the contrast in the Inversion - Best Matching (IBM) method}
\usage{
IBM_tabul_stochasticInteg(
  n.sim = 200,
  n.varCovMat = 100,
  sample1 = NULL,
  sample2 = NULL,
  min_size = NULL,
  comp.dist = NULL,
  comp.param = NULL,
  parallel = FALSE,
  n_cpu = 2
)
}
\arguments{
\item{n.sim}{Number of trajectories of simulated gaussian processes (number of random draws for tabulation).}

\item{n.varCovMat}{Number of time points on which gaussian processes are simulated.}

\item{sample1}{Observations of the first sample under study.}

\item{sample2}{Observations of the second sample under study.}

\item{min_size}{(default to NULL) In the k-sample case, useful to provide the minimal size among all samples. Otherwise, useless.}

\item{comp.dist}{A list with four elements corresponding to the component distributions (specified with R native names for these distributions)
involved in the two admixture models. The two first elements refer to the unknown and known components of the 1st admixture model,
and the last two ones to those of the second admixture model. If there are unknown elements, they must be specified as 'NULL' objects.
For instance, 'comp.dist' could be specified as follows: list(f1=NULL, g1='norm', f2=NULL, g2='norm').}

\item{comp.param}{A list with four elements corresponding to the parameters of the component distributions, each element being a list
itself. The names used in this list must correspond to the native R argument names for these distributions.
The two first elements refer to the parameters of unknown and known components of the 1st admixture model, and the last
two ones to those of the second admixture model. If there are unknown elements, they must be specified as 'NULL' objects.
For instance, 'comp.param' could be specified as follows: : list(f1=NULL, g1=list(mean=0,sd=1), f2=NULL, g2=list(mean=3,sd=1.1)).}

\item{parallel}{(default to FALSE) Boolean to indicate whether parallel computations are performed (speed-up the tabulation).}

\item{n_cpu}{(default to 2) Number of cores used for computations when parallelizing.}
}
\value{
A list with four elements, containing: 1) random draws of the quantity 'sample size times the empirical contrast',
as defined in the IBM approach (see 'Details' above); 2) the estimated unknown component weights for the two admixture
models; 3) the value of the quantity 'sample size times the empirical contrast'; 4) the sequence of points in the
support that were used to evaluate the variance-covariance matrix of empirical processes.
}
\description{
Tabulate the distribution related to the inner convergence part of the contrast, by simulating trajectories of gaussian
processes and applying some transformations. Useful to perform the test hypothesis then, by retrieving the (1-alpha)-quantile
of interest. See 'Details' below and the cited paper therein for further information.
}
\details{
See the paper presenting the IBM approach at the following HAL weblink: https://hal.science/hal-03201760
}
\examples{
\donttest{
## Simulate data:
list.comp <- list(f1 = 'norm', g1 = 'norm',
                  f2 = 'norm', g2 = 'norm')
list.param <- list(f1 = list(mean = 1, sd = 1), g1 = list(mean = 2, sd = 0.7),
                   f2 = list(mean = 1, sd = 1), g2 = list(mean = 3, sd = 1.2))
X.sim <- rsimmix(n=1000, unknownComp_weight=0.7, comp.dist = list(list.comp$f1,list.comp$g1),
                 comp.param = list(list.param$f1, list.param$g1))$mixt.data
Y.sim <- rsimmix(n=1200, unknownComp_weight=0.6, comp.dist = list(list.comp$f2,list.comp$g2),
                 comp.param = list(list.param$f2, list.param$g2))$mixt.data
## Tabulate 1st term of stochastic integral (inner convergence) in a real-life setting:
list.comp <- list(f1 = NULL, g1 = 'norm',
                  f2 = NULL, g2 = 'norm')
list.param <- list(f1 = NULL, g1 = list(mean = 2, sd = 0.7),
                   f2 = NULL, g2 = list(mean = 3, sd = 1.2))
U <- IBM_tabul_stochasticInteg(n.sim = 2, n.varCovMat = 20, sample1 = X.sim, sample2 = Y.sim,
                               min_size = NULL, comp.dist = list.comp, comp.param = list.param,
                               parallel = FALSE, n_cpu = 2)
}

}
\author{
Xavier Milhaud \href{mailto:xavier.milhaud.research@gmail.com}{xavier.milhaud.research@gmail.com}
}
