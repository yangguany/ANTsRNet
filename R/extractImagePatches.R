#' Extract 2-D or 3-D image patches.
#'
#' @param image Input ANTs image with one or more components
#' @param patchSize Width, height, and depth (if 3-D) of patches.
#' @param maxNumberOfPatches Maximum number of patches returned.  If
#' "all" is specified, then all patches in sequence (defined by the
#" strideLength are extracted.
#' @param strideLength Defines the sequential patch overlap for
#' maxNumberOfPatches = all.  Can be a image-dimensional vector or a scalar.
#' @param maskImage optional image specifying the sampling region for
#' the patches when \code{maximumNumberOfPatches} does not equal "all".
#' The way we constrain patch selection using a mask is by forcing
#' each returned patch to have a masked voxel at its center.
#' @param randomSeed integer seed that allows reproducible patch extraction
#' across runs.
#' @param returnAsArray specifies the return type of the function.  If
#' \code{FALSE} (default) the return type is a list where each element is
#' a single patch.  Otherwise the return type is an array of size
#' \code{dim( numberOfPatches, patchSize )}.
#'
#' @return a list (or array) of image patches.
#' @author Tustison NJ
#' @examples
#'
#' library( ANTsR )
#'
#' image <- antsImageRead( getANTsRData( "r16" ) )
#' maskImage <- getMask( image, 1, 1000 )
#' patchSet1 <- extractImagePatches( image, c( 32, 32 ), 10, c( 32, 32 ), randomSeed = 0 )
#' patchSet2 <- extractImagePatches( image, c( 32, 32 ), 10, c( 32, 32 ), randomSeed = 1 )
#' patchSet3 <- extractImagePatches( image, c( 32, 32 ), 10, c( 32, 32 ), maskImage, randomSeed = 0 )
#'
#' @export
extractImagePatches <- function( image, patchSize, maxNumberOfPatches = 'all',
  strideLength = 1, maskImage = NA, randomSeed, returnAsArray = FALSE )
{
  if ( ! missing( randomSeed ) )
    {
    set.seed( randomSeed )
    }
  imageSize <- dim( image )
  dimensionality <- length( imageSize )

  if( dimensionality != 2 && dimensionality != 3 )
    {
    stop( "Unsupported dimensionality." )
    }

  numberOfImageComponents <- image@components

  if( length( imageSize ) != length( patchSize ) )
    {
    stop( "Mismatch between the image size and the specified patch size.\n" )
    }
  if( any( patchSize > imageSize ) )
    {
    stop( "Patch size is greater than the image size.\n")
    }

  imageArray <- as.array( image )
  if( numberOfImageComponents > 1 )
    {
    if( dimensionality == 2 )
      {
      imageArray <- aperm( imageArray, c( 2, 3, 1 ) )
      } else {
      imageArray <- aperm( imageArray, c( 2, 3, 4, 1 ) )
      }
    }

  patchList <- list()
  patchArray <- array( data = NA )
  midPatchIndex <- round( patchSize / 2 )

  numberOfExtractedPatches <- maxNumberOfPatches

  if( tolower( maxNumberOfPatches ) == 'all' )
    {
    strideLengthVector <- strideLength
    if( length( strideLength ) == 1 )
      {
      strideLengthVector <- rep.int( strideLength, dimensionality )
      } else if( length( strideLength ) != dimensionality ) {
      stop( paste0( "strideLength is not a scalar or vector of
        length dimensionality." ) )
      } else if( any( strideLength < 1 ) ) {
      stop( paste0( "strideLength must be a positive integer." ) )
      }

    numberOfExtractedPatches <- 1

    indices <- list()
    for( d in seq_len( dimensionality ) )
      {
      indices[[d]] <- seq.int( from = 1, to = imageSize[d] - patchSize[d] + 1,
        by = strideLengthVector[d] )
      numberOfExtractedPatches <-
        numberOfExtractedPatches * length( indices[[d]] )
      }

    if( returnAsArray )
      {
      if( numberOfImageComponents == 1 )
        {
        patchArray <- array( data = NA,
          dim = c( numberOfExtractedPatches, patchSize ) )
        } else {
        patchArray <- array( data = NA, dim =
          c( numberOfExtractedPatches, patchSize, numberOfImageComponents ) )
        }
      }

    count <- 1
    if( dimensionality == 2 )
      {
      for( i in indices[[1]] )
        {
        for( j in indices[[2]] )
          {
          startIndex <- c( i, j )
          endIndex <- startIndex + patchSize - 1

          if( numberOfImageComponents == 1 )
            {
            patch <- imageArray[startIndex[1]:endIndex[1],
              startIndex[2]:endIndex[2]]
            } else {
            patch <- imageArray[startIndex[1]:endIndex[1],
              startIndex[2]:endIndex[2],]
            }

          if( returnAsArray )
            {
            if( numberOfImageComponents == 1 )
              {
              patchArray[count,,] <- patch
              } else {
              patchArray[count,,,] <- patch
              }
            } else {
            patchList[[count]] <- patch
            }

          count <- count + 1
          }
        }
      } else {
      for( i in indices[[1]] )
        {
        for( j in indices[[2]] )
          {
          for( k in indices[[3]] )
            {
            startIndex <- c( i, j, k )
            endIndex <- startIndex + patchSize - 1

            if( numberOfImageComponents == 1 )
              {
              patch <- imageArray[startIndex[1]:endIndex[1],
                startIndex[2]:endIndex[2], startIndex[3]:endIndex[3]]
              } else {
              patch <- imageArray[startIndex[1]:endIndex[1],
                startIndex[2]:endIndex[2], startIndex[3]:endIndex[3],]
              }

            if( returnAsArray )
              {
              if( numberOfImageComponents == 1 )
                {
                patchArray[count,,,] <- patch
                } else {
                patchArray[count,,,,] <- patch
                }
              } else {
              patchList[[count]] <- patch
              }

            count <- count + 1
            }
          }
        }
      }
    } else {

    randomIndices <-
      array( data = NA, dim = c( maxNumberOfPatches, dimensionality ) )

    if( !is.na( maskImage ) )
      {
      maskArray <- as.array( maskImage )
      maskArray[which( maskArray != 0 )] <- 1

      # The way we constrain patch selection using a mask is by assuming that
      # each patch must have a masked voxel at its midPatchIndex.

      maskIndices <- which( maskArray != 0, arr.ind = TRUE )

      shiftedMaskIndices <- maskIndices
      negativeIndices <- c()
      for( d in seq_len( dimensionality ) )
        {
        shiftedMaskIndices[, d] <- maskIndices[, d] - midPatchIndex[d]
        negativeIndices <- append( negativeIndices, which( shiftedMaskIndices[, d] <= 0 ) )
        shiftedMaskIndices[, d] <- maskIndices[, d] + midPatchIndex[d]
        negativeIndices <- append( negativeIndices, which( shiftedMaskIndices[, d] > imageSize[d] ) )
        }

      negativeIndices <- unique( negativeIndices )
      if( length( negativeIndices ) > 0 )
        {
        maskIndices <- maskIndices[-negativeIndices,]
        }

      # After pruning the mask indices, which were originally defined in terms of the
      # midPatchIndex, we subtract the midPatchIndex so that it's now defined at the
      # corner for patch selection.

      for( d in seq_len( dimensionality ) )
        {
        maskIndices[, d] <- maskIndices[, d] - midPatchIndex[d]
        }

      numberOfExtractedPatches <- min( maxNumberOfPatches, nrow( maskIndices ) )

      randomIndices <- maskIndices[
        sample.int( nrow( maskIndices ), numberOfExtractedPatches ),]
      } else {
      for( d in seq_len( dimensionality ) )
        {
        randomIndices[, d] <- sample.int(
          imageSize[d] - patchSize[d] + 1, maxNumberOfPatches, replace = TRUE )
        }
      }

    if( returnAsArray )
      {
      if( numberOfImageComponents == 1 )
        {
        patchArray <- array( data = NA,
          dim = c( numberOfExtractedPatches, patchSize ) )
        } else {
        patchArray <- array( data = NA, dim =
          c( numberOfExtractedPatches, patchSize, numberOfImageComponents ) )
        }
      }

    startIndex <- rep( 1, dimensionality )
    for( i in seq_len( numberOfExtractedPatches ) )
      {
      startIndex <- randomIndices[i,]
      endIndex <- startIndex + patchSize - 1

      if( dimensionality == 2 )
        {
        if( numberOfImageComponents == 1 )
          {
          patch <- imageArray[startIndex[1]:endIndex[1],
            startIndex[2]:endIndex[2]]
          } else {
          patch <- imageArray[startIndex[1]:endIndex[1],
            startIndex[2]:endIndex[2],]
          }
        } else {
        if( numberOfImageComponents == 1 )
          {
          patch <- imageArray[startIndex[1]:endIndex[1],
            startIndex[2]:endIndex[2], startIndex[3]:endIndex[3]]
          } else {
          patch <- imageArray[startIndex[1]:endIndex[1],
            startIndex[2]:endIndex[2], startIndex[3]:endIndex[3],]
          }
        }

      if( returnAsArray )
        {
        if( dimensionality == 2 )
          {
          if( numberOfImageComponents == 1 )
            {
            patchArray[i,,] <- patch
            } else {
            patchArray[i,,,] <- patch
            }
          } else {
          if( numberOfImageComponents == 1 )
            {
            patchArray[i,,,] <- patch
            } else {
            patchArray[i,,,,] <- patch
            }
          }
        } else {
        patchList[[i]] <- patch
        }
      }
    }

  if( returnAsArray )
    {
    return( patchArray )
    } else {
    return( patchList )
    }
}
