#!/bin/bash
sudo apt-get update

## issues with blocked dependencies, check it and remove manually 
## ls /usr/local/lib/R/site-library/ -l | grep 00LOCK

# installing python dependencies
pip install scvi-tools cell2location scanpy anndata igraph networkx leidenalg community smfishHmrf scikit-learn --user >> log.txt

# installing R dependencies
# install SCDC
sudo apt-get install -y libssl-dev libcurl4-openssl-dev libharfbuzz-dev libfribidi-dev liblapack-dev libopenblas-dev gfortran >> log.txt
sudo R -e "if (!require('remotes')) { options(timeout = 600000000, install.lock=FALSE); install.packages('remotes', repos='http://cran.rstudio.com/')}"  2>> log.txt
sudo R -e "if (!require('xbioc')) { options(timeout = 600000000, install.lock=FALSE); remotes::install_github('renozao/xbioc')}" 2>> log.txt
sudo R -e "if (!require('devtools')) { options(timeout = 600000000, install.lock=FALSE); install.packages('devtools', repos='http://cran.rstudio.com/')}" 2>> log.txt
sudo R -e "if (!require('SCDC')) { options(timeout = 600000000, install.lock=FALSE); devtools::install_github('meichendong/SCDC')}" 2>> log.txt
## install RCTD
sudo apt-get install -y libgsl-dev >> log.txt
sudo R -e "if (!require('spacexr')) { options(timeout = 600000000, install.lock=FALSE); devtools::install_github('dmcable/spacexr', build_vignettes = FALSE, INSTALL_opts = '--no-lock')}" 2>> log.txt
## install MuSiC
sudo R -e "if (!require('TOAST')) { options(timeout = 600000000, install.lock=FALSE); BiocManager::install('TOAST', update = FALSE)}" 2>> log.txt
sudo R -e "if (!require('SingleCellExperiment')) { options(timeout = 600000000, install.lock=FALSE); BiocManager::install('SingleCellExperiment', update = FALSE)}" 2>> log.txt
sudo R -e "if (!require('MuSiC')) { options(timeout = 600000000, install.lock=FALSE); devtools::install_github('xuranw/MuSiC')}" 2>> log.txt
# ### # DeconRNASeq
sudo R -e "if (!require('DeconRNASeq')) { options(timeout = 600000000, install.lock=FALSE); BiocManager::install('DeconRNASeq', update = FALSE)}" 2>> log.txt

# ### Seurat
sudo R -e "if (!require('Seurat')) { options(timeout = 600000000, install.lock=FALSE); install.packages('Seurat', repos='http://cran.rstudio.com/')}" 2>> log.txt

# #### DWLS
sudo R -e "if (!require('MAST')) {options(timeout = 600000000, install.lock=FALSE); BiocManager::install('MAST', update = FALSE)}" 2>> log.txt
sudo R -e "if (!require('DWLS')) {options(timeout = 600000000, install.lock=FALSE); remotes::install_github('sistia01/DWLS')}" 2>> log.txt

# ### install SPOTlight (Version 0.1.7)
sudo apt-get install -y libgmp3-dev cmake >> log.txt
sudo R -e "if (!require('SPOTlight')) { options(timeout = 600000000, install.lock=FALSE); devtools::install_github('https://github.com/MarcElosua/SPOTlight/tree/spotlight-0.1.7')}" 2>> log.txt
# ### Giotto
sudo R -e "devtools::install_github('RubD/Giotto')" >> log.txt
### # install spatstat.geom
sudo R -e "if (!require('spatstat.geom')) { options(timeout = 600000000, install.lock=FALSE); install.packages('spatstat.geom', repos='http://cran.rstudio.com/')}" 2>> log.txt
# ### install CARD
sudo apt-get install -y libudunits2-dev libgdal-dev >> log.txt
sudo R -e "if (!require('CARD')) { options(timeout = 600000000, install.lock=FALSE); devtools::install_github('YingMa0107/CARD')}" 2>> log.txt
### install STdeconvolve
sudo R -e "if (!require('STdeconvolve')) { options(timeout = 600000000, install.lock=FALSE); remotes::install_github('JEFworks-Lab/STdeconvolve')}" 2>> log.txt
### other R dependencies
sudo R -e "if (!require('parallel')) { options(timeout = 600000000, install.lock=FALSE); install.packages('parallel', repos='http://cran.rstudio.com/')}" 2>> log.txt
sudo R -e "if (!require('doParallel')) { options(timeout = 600000000, install.lock=FALSE); install.packages('doParallel', repos='http://cran.rstudio.com/')}" 2>> log.txt
sudo R -e "if (!require('reticulate')) { options(timeout = 600000000, install.lock=FALSE);  install.packages('reticulate', repos='http://cran.rstudio.com/')}" 2>> log.txt
### # install EnDecon
sudo R -e "if (!require('EnDecon')) { options(timeout = 600000000, install.lock=FALSE); devtools::install_github('Zhangxf-ccnu/EnDecon')}" 2>> log.txt
adding kernel to work at Jupyter
sudo R -e "if (!require('IRkernel')) { options(timeout = 600000000, install.lock=FALSE);  devtools::install_github('IRkernel/IRkernel')}" 2>> log.txt
jupyter kernelspec install /usr/local/lib/R/site-library/IRkernel/kernelspec --name 'R' --user