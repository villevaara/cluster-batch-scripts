
install_package_wrapper <- function(package_name,
                                    cran_mirror,
                                    force_reinstall = FALSE) {
  download_package <- (
    !require(package_name, character.only=TRUE) | force_reinstall)
  if (download_package) {
    install.packages(package_name, repos = cran_mirror)
  } else {
    print(paste0("Package ", package_name, " already installed."))
  }
  library(package_name, character.only=TRUE)
}


cran_mirror <- "https://cloud.r-project.org"

install_package_wrapper("stringi", cran_mirror)
install_package_wrapper("stringr", cran_mirror)
install_package_wrapper("tidyverse", cran_mirror)
install_package_wrapper("plyr", cran_mirror)
