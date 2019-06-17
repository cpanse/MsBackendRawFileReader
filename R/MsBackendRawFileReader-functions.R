#' @export MsBackendRawFileReader
#' @importFrom methods new
#' @aliases MsBackendRawFileReader
MsBackendRawFileReader <- function() {
    if (!requireNamespace("rawDiag", quietly = TRUE))
        stop("The use of 'MsBackendRawFileReader' requires package 'rawDiag'. Please ",
             "install.")
    new("MsBackendRawFileReader")
}

#' Read the header for each spectrum from the MS file `x`
#'
#' @author Christian Panse 2019-06-15 
#' adapted from the MsBackendMzR-function.R file by Johannes Rainer
#'
#' @return `DataFrame` with the header.
#' @noRd
.rawDiag_header <- function(x) {
   
    stopifnot(x$check())
    requireNamespace("rawDiag", quietly = TRUE)
    
    first <- x$getFirstScanNumber()
    last <- x$getLastScanNumber()
    
    S4Vectors::DataFrame(
      scanIndex = first:last,
      msLevel = sapply(first:last, function(sn){x$GetMsLevel(sn)}),
      precursorMz = sapply(first:last, function(sn){x$GetPepmass(sn)}),
      rtime =  sapply(first:last, function(sn){x$GetRTinSeconds(sn)})
    )
}