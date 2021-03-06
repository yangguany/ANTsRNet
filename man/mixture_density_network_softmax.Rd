% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mixtureDensityUtilities.R
\name{mixture_density_network_softmax}
\alias{mixture_density_network_softmax}
\title{Softmax function for mixture density with temperature adjustment}
\usage{
mixture_density_network_softmax(logits, temperature = 1)
}
\arguments{
\item{logits}{input}
}
\value{
softmax loss value
}
\description{
Ported from:
}
\details{
https://github.com/cpmpercussion/keras-mdn-layer/
}
\examples{

library( keras )


}
\author{
Tustison NJ
}
