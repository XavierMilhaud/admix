% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/knownComp_to_uniform.R
\name{knownComp_to_uniform}
\alias{knownComp_to_uniform}
\title{Transforms the known component of the admixture distribution to a Uniform distribution}
\usage{
knownComp_to_uniform(data, comp.dist, comp.param)
}
\arguments{
\item{data}{Observations of the sample under study, following an admixture distribution.}

\item{comp.dist}{A list with two elements corresponding to component distributions (specified with R native names for these distributions) involved
in the admixture model. Unknown elements must be specified as 'NULL' objects, e.g. when 'f' is unknown: list(f=NULL, g='norm').}

\item{comp.param}{A list with two elements corresponding to the parameters of the component distributions, each element being a list
itself. The names used in this list must correspond to the native R argument names for these distributions.
Unknown elements must be specified as 'NULL' objects, e.g. if 'f' is unknown: list(f=NULL, g=list(mean=0,sd=1)).}
}
\value{
The transformed data, i.e. the transformed mixture distribution where the known component g now follows a
Uniform(0,1) distribution.
}
\description{
In admixture such that the probability density function (pdf) follows l = p*f + (1-p)*g, where p is the unknown
weight and f is the unknown component distribution: transforms g of the two-component mixture ditribution to a
Uniform distribution. Useful to use Patra and Sen estimator for the estimation of the unknown weight p.
}
\examples{
## Simulate data:
list.comp <- list(f1 = 'norm', g1 = 'norm')
list.param <- list(f1 = list(mean = 3, sd = 0.5),
                   g1 = list(mean = 0, sd = 1))
sample1 <- rsimmix(n=1500, unknownComp_weight=0.5, comp.dist = list(list.comp$f1,list.comp$g1),
                                                   comp.param=list(list.param$f1,list.param$g1))
plot_mixt_density(samples = list(sample1[['mixt.data']]), support = 'continuous')
## Transform the known component into a Uniform(0,1) distribution:
list.comp <- list(f1 = NULL, g1 = 'norm')
list.param <- list(f1 = NULL, g1 = list(mean = 0, sd = 1))
transformed_data <- knownComp_to_uniform(data = sample1[['mixt.data']],
                                         comp.dist = list.comp, comp.param = list.param)
plot_mixt_density(samples = list(transformed_data), support = 'continuous')

}
\author{
Xavier Milhaud \href{mailto:xavier.milhaud.research@gmail.com}{xavier.milhaud.research@gmail.com}
}
