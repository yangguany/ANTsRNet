% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/createConvolutionalAutoencoderModel.R
\name{createConvolutionalAutoencoderModel3D}
\alias{createConvolutionalAutoencoderModel3D}
\title{Function for creating a 3-D symmetric convolutional autoencoder model.}
\usage{
createConvolutionalAutoencoderModel3D(inputImageSize,
  numberOfFiltersPerLayer = c(32, 64, 128, 10),
  convolutionKernelSize = c(5, 5, 5), deconvolutionKernelSize = c(5, 5,
  5))
}
\arguments{
\item{inputImageSize}{vector definining spatial dimensions + channels}

\item{numberOfFiltersPerLayer}{vector defining the number of convolutional
filters in the encoding branch per layer}

\item{convolutionKernelSize}{kernel size fo the convolutional filters}

\item{deconvolutionKernelSize}{kernel size fo the convolutional transpose
filters}
}
\value{
two models:  the convolutional encoder and convolutional auto-encoder
}
\description{
Builds a convolutional autoencoder based on the specified array
definining the number of units in the encoding branch.  Ported to
Keras R from the Keras python implementation here:
}
\details{
\url{https://github.com/XifengGuo/DCEC}
}
\examples{

library( ANTsRNet )
library( keras )

ae <- createConvolutionalAutoencoderModel2D( c( 32, 32, 1 ) )

}
\author{
Tustison NJ
}
