% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/createDenseUnetModel.R
\name{createDenseUnetModel2D}
\alias{createDenseUnetModel2D}
\title{2-D implementation of the dense U-net deep learning architecture.}
\usage{
createDenseUnetModel2D(inputImageSize, numberOfOutputs = 1,
  numberOfLayersPerDenseBlock = c(6, 12, 36, 24), growthRate = 48,
  initialNumberOfFilters = 96, reductionRate = 0, depth = 7,
  dropoutRate = 0, weightDecay = 1e-04, mode = "classification")
}
\arguments{
\item{inputImageSize}{Used for specifying the input tensor shape.  The
shape (or dimension) of that tensor is the image dimensions followed by
the number of channels (e.g., red, green, and blue).}

\item{numberOfOutputs}{Meaning depends on the \code{mode}.  For
'classification' this is the number of segmentation labels.  For 'regression'
this is the number of outputs.}

\item{growthRate}{number of filters to add for each dense block layer
(default = 48).}

\item{initialNumberOfFilters}{number of filters at the beginning}

\item{reductionRate}{reduction factor of transition blocks}

\item{depth}{number of layers---must be equal to 3 * N + 4 where
N is an integer (default = 7).}

\item{dropoutRate}{= per drop out layer rate (default = 0.2)}

\item{weightDecay}{= weight decay (default = 1e-4)}

\item{numberOfLayersPerDenseBlocks}{number of dense blocks per layer
(default = 1).}
}
\value{
an DenseUnet keras model
}
\description{
Creates a keras model of the dense U-net deep learning architecture for
image segmentation
}
\details{
X. Li, H. Chen, X. Qi, Q. Dou, C.-W. Fu, P.-A. Heng. H-DenseUNet: Hybrid
Densely Connected UNet for Liver and Tumor Segmentation from CT Volumes

available here:

https://arxiv.org/pdf/1709.07330.pdf

with the author's implementation available at:

https://github.com/xmengli999/H-DenseUNet
}
\examples{

library( ANTsR )
library( ANTsRNet )
library( keras )

imageIDs <- c( "r16", "r27", "r30", "r62", "r64", "r85" )
trainingBatchSize <- length( imageIDs )

# Perform simple 3-tissue segmentation.

segmentationLabels <- c( 1, 2, 3 )
numberOfLabels <- length( segmentationLabels )
initialization <- paste0( 'KMeans[', numberOfLabels, ']' )

domainImage <- antsImageRead( getANTsRData( imageIDs[1] ) )

X_train <- array( data = NA, dim = c( trainingBatchSize, dim( domainImage ), 1 ) )
Y_train <- array( data = NA, dim = c( trainingBatchSize, dim( domainImage ) ) )

images <- list()
segmentations <- list()

for( i in seq_len( trainingBatchSize ) )
  {
  cat( "Processing image", imageIDs[i], "\\n" )
  image <- antsImageRead( getANTsRData( imageIDs[i] ) )
  mask <- getMask( image )
  segmentation <- atropos( image, mask, initialization )$segmentation

  X_train[i,,, 1] <- as.array( image )
  Y_train[i,,] <- as.array( segmentation )
  }
Y_train <- encodeUnet( Y_train, segmentationLabels )

# Perform a simple normalization

X_train <- ( X_train - mean( X_train ) ) / sd( X_train )

# Create the model

model <- createDenseUnetModel2D( c( dim( domainImage ), 1 ),
  numberOfOutputs = numberOfLabels )

model \%>\% compile( loss = loss_multilabel_dice_coefficient_error,
  optimizer = optimizer_adam( lr = 0.0001 ),
  metrics = c( multilabel_dice_coefficient ) )

# Comment out the rest due to travis build constraints

# Fit the model

# track <- model \%>\% fit( X_train, Y_train,
#              epochs = 100, batch_size = 4, verbose = 1, shuffle = TRUE,
#              callbacks = list(
#                callback_model_checkpoint( "unetModelInterimWeights.h5",
#                    monitor = 'val_loss', save_best_only = TRUE ),
#                callback_reduce_lr_on_plateau( monitor = "val_loss", factor = 0.1 )
#              ),
#              validation_split = 0.2 )

# Save the model and/or save the model weights

# save_model_hdf5( model, filepath = 'unetModel.h5' )
# save_model_weights_hdf5( unetModel, filepath = 'unetModelWeights.h5' ) )

}
\author{
Tustison NJ
}
