% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/deepEmbeddedClusteringUtilities.R
\docType{class}
\name{DeepEmbeddedClusteringModel}
\alias{DeepEmbeddedClusteringModel}
\title{Deep embedded clustering (DEC) model class}
\description{
Deep embedded clustering (DEC) model class
}
\section{Usage}{

}

\section{Arguments}{

\describe{
\item{numberOfUnitsPerLayer}{array describing the auteoencoder.}
\item{numberOfClusters}{number of clusters.}
\item{alpha}{parameter}
\item{initializer}{initializer for autoencoder}
}
}

\section{Details}{

\code{$initialize} instantiates a new class.

\code{$pretrain}

\code{$loadWeights}

\code{$extractFeatures}

\code{$predictClusterLabels}

\code{$targetDistribution}

\code{$compile}

\code{$fit}
}

\examples{
\dontrun{

library( keras )
library( ANTsRNet )

fmnist <- dataset_fashion_mnist()

numberOfTrainingData <- length( fmnist$train$y )
numberOfTestingData <- length( fmnist$test$y )

numberOfPixels <- prod( dim( fmnist$test$x[1,,] ) )

fmnist$train$xreshaped <- array_reshape( fmnist$train$x,
  dim = c( numberOfTrainingData, numberOfPixels ), order = "C" )
fmnist$test$xreshaped <- array_reshape( fmnist$train$x,
  dim = c( numberOfTrainingData, numberOfPixels ), order = "C" )

x <- rbind( fmnist$test$xreshaped, fmnist$train$xreshaped ) / 255
y <- c( fmnist$test$y, fmnist$train$y )

numberOfClusters <- length( unique( fmnist$train$y ) )

initializer <- initializer_variance_scaling(
  scale = 1/3, mode = 'fan_in', distribution = 'uniform' )
pretrainOptimizer <- optimizer_sgd( lr = 1.0, momentum = 0.9 )

decModel <- DeepEmbeddedClusteringModel$new(
   numberOfUnitsPerLayer = c( numberOfPixels, 500, 500, 2000, 10 ),
   numberOfClusters = numberOfClusters, initializer = initializer )

modelWeightsFile <- "decAutoencoderModelWeights.h5"
if( ! file.exists( modelWeightsFile ) )
  {
  decModel$pretrain( x = x, optimizer = optimizer_sgd( lr = 1.0, momentum = 0.9 ),
    epochs = 300L, batchSize = 256L )
  save_model_weights_hdf5( decModel$autoencoder, modelWeightsFile )
  } else {
  load_model_weights_hdf5( decModel$autoencoder, modelWeightsFile )
  }

decModel$compile( optimizer = optimizer_sgd( lr = 1.0, momentum = 0.9 ), loss = 'kld' )

yPredicted <- decModel$fit( x, maxNumberOfIterations = 2e4, batchSize = 256,
  tolerance = 1e-3, updateInterval = 10 )
}

}
\author{
Tustison NJ
}
