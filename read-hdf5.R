# HDF5

# http://bioconductor.org/packages/release/bioc/vignettes/rhdf5/doc/rhdf5.pdf

# install HDF5 package
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")

# create HDF5 file
library(rhdf5)
created = h5createFile("example.h5")
created

# create groups within the HDF5 file

