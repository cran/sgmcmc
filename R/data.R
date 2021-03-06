#' Load example datasets
#'
#' Download and load one of the example datasets for the package: 
#'  \code{covertype} or \code{mnist}.
#'  These datasets are required for the vignettes in the package.
#'  The code generating these datasets is available at \url{https://github.com/jbaker92/sgmcmc-data}.
#'
#' @param dataset string which determines the dataset to load: 
#'  either \code{"covertype"} or \code{"mnist"}.
#' 
#' @return Returns the desired dataset. The next two sections give more details about each dataset. 
#' 
#' @section covertype:
#'
#' The samples in this dataset correspond to 30×30m patches of forest in the US, 
#' collected for the task of predicting each patch’s cover type, 
#' i.e. the dominant species of tree. 
#' We use the LIBSVM dataset, which transforms the data to a binary problem rather than multiclass.
#'
#' format: A matrix with 581012 rows and 55 variables. The first column is the 
#'  classification labels, the other columns are the 54 explanatory variables.
#'
#' source: \url{https://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/binary.html}
#'
#' @section mnist:
#'
#' The MNIST dataset is a dataset of handwritten digits from 0-9. Each image is 28x28 pixels. 
#' We can interpret this as a large matrix of numbers, representing the value at each pixel.
#' These 28x28 matrices are then flattened to be vectors of length 784. For each image, there
#' is an associated label, which determines which digit the image is of. This image is encoded
#' as a vector of length 10, where element i is 1 if the digit is i-1 and 0 otherwise.
#' The dataset is split into two parts: 55,000 data points of training data 
#' and 10,000 points of test data. 
#'
#' format: A list with two elements \code{train} and \code{test}.
#' \itemize{
#'  \item The training set mnist$train is a list with two entries: images and labels,
#'  located at mnist$train$images, mnist$train$labels respectively.
#'  \item The dataset mnist$train$images is a matrix of size 55000x784, 
#'  the labels mnist$train$labels is a matrix of size 55000x10.
#'  \item The test set mnist$test is a list with two entries: images and labels,
#'  located at mnist$test$images, mnist$test$labels respectively.
#'  \item The dataset mnist$test$images is a matrix of size 10000x784, 
#'  the labels mnist$test$labels is a matrix of size 10000x10. }
#'
#' source: \url{http://yann.lecun.com/exdb/mnist/}
#' 
#' @export
#'
#' @examples
#' \dontrun{
#' # Download the covertype dataset
#' covertype = get_dataset("covertype")
#' # Download the mnist dataset
#' mnist = get_dataset("mnist")
#' }
getDataset = function(dataset) {
    if ( dataset != "covertype" && dataset != "mnist" ) {
        stop("Only covertype and mnist datasets are available")
    }
    temp = tempfile()
    utils::download.file("https://github.com/jbaker92/sgmcmc-data/archive/master.tar.gz", temp)
    extr_temp = tempfile()
    utils::untar(temp, exdir = extr_temp)
    load(paste0(extr_temp, "/sgmcmc-data-master/data/", dataset, ".rda"))
    return(get(dataset))
}
