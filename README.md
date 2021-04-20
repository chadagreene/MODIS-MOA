# File Descriptions 
* **`modismoaps`** plots a MODIS Mosaic of Antarctica image on a polar stereographic map. Also plots grounding lines or coastlines. This function is fast and does not hijack the colormap. 
* **`modismoa`** (not recommended because it's slow and clunky) same as `modismoaps`, but this function is for use with Matlab's Mapping Toolbox. 

# Requirements 
You'll need [Antarctic Mapping Tools for Matlab](https://github.com/chadagreene/Antarctic-Mapping-Tools) (Greene et al., 2017). You'll also need to download the data, described below.

# Data Download 
To use these functions, you'll need to download the image mosaics. For each year, a 750 m resolution and a 125 m version are necessary because the `modismoaps` function automatically switches between the two datasets, depending on the area of the map extents. 

Log into Earthdata and download the following: 

### 2014 mosaic:
By default, the `modismoaps` function plots the 2014 highpass filtered image mosaics. Download them here:

* [https://daacdata.apps.nsidc.org/pub/DATASETS/nsidc0730_MEASURES\_MOA2014\_v01/geotiff/moa750\_2014\_hp1\_v01.tif](https://daacdata.apps.nsidc.org/pub/DATASETS/nsidc0730_MEASURES_MOA2014_v01/geotiff/moa750_2014_hp1_v01.tif)
* [https://daacdata.apps.nsidc.org/pub/DATASETS/nsidc0730\_MEASURES\_MOA2014\_v01/geotiff/moa125\_2014\_hp1\_v01.tif](https://daacdata.apps.nsidc.org/pub/DATASETS/nsidc0730_MEASURES_MOA2014_v01/geotiff/moa125_2014_hp1_v01.tif)

### 2009 mosaic (optional): 
You'll only need to download the 2009 data if you specifically want to plot the 2009 mosaic rather than the default 2014. I like to have them all available to me, because sometimes it's helpful to see how the surface has changed over time. Here's the 2009 data (You'll need to unzip the 2009 & 2004 data): 

* [https://daacdata.apps.nsidc.org/pub/DATASETS/nsidc0593\_moa2009\_v02/geotiff/moa750\_2009\_hp1\_v02.0.tif.gz](https://daacdata.apps.nsidc.org/pub/DATASETS/nsidc0593_moa2009_v02/geotiff/moa750_2009_hp1_v02.0.tif.gz)
* [https://daacdata.apps.nsidc.org/pub/DATASETS/nsidc0593\_moa2009\_v02/geotiff/moa125\_2009\_hp1\_v02.0.tif.gz](https://daacdata.apps.nsidc.org/pub/DATASETS/nsidc0593_moa2009_v02/geotiff/moa750_2009_hp1_v02.0.tif.gz)

### 2004 mosaic (optional): 
* [https://daacdata.apps.nsidc.org/pub/DATASETS/nsidc0280\_moa2004\_v02/geotiff/moa750\_2004\_hp1\_v02.0.tif.gz](https://daacdata.apps.nsidc.org/pub/DATASETS/nsidc0280_moa2004_v02/geotiff/moa750_2004_hp1_v02.0.tif.gz)
* [https://daacdata.apps.nsidc.org/pub/DATASETS/nsidc0280\_moa2004\_v02/geotiff/moa125\_2004\_hp1\_v02.0.tif.gz](https://daacdata.apps.nsidc.org/pub/DATASETS/nsidc0280_moa2004_v02/geotiff/moa125_2004_hp1_v02.0.tif.gz)

### Grounding lines and coastlines: 
Grounding lines and coastlines are included in this toolbox as .mat files, so you *don't* need to download the shapefiles. 

### Note on data versions:
The versioning of the MOA data is somewhat confusing. v01 of the 2014 is equivalent to v02 of the 2004 and 2009 data. And v1.1 of the 2004 and 2009 data are the same exact data as v02 of those years, but the version number was incremented simply because of some data hosting agreement. To my knowledge, the links listed above are the latest and greatest of each of the datasets, but please let me know if you're reading this and the data have been updated. 

# Citing This Data
If these functions are useful for you, please cite MODIS MOA and the AMT paper as follows: 

Haran, T., J. Bohlander, T. Scambos, T. Painter, and M. Fahnestock. 2021, updated 2019. MODIS Mosaic of Antarctica Image Map, Version 2. Boulder, Colorado USA. NASA National Snow and Ice Data Center Distributed Active Archive Center. doi: https://doi.org/10.5067/68TBT0CGJSOJ.

Greene, C. A., Gwyther, D. E., & Blankenship, D. D. (2017). Antarctic Mapping Tools for Matlab. Computers & Geosciences, 104, 151–157. Elsevier BV. [https://doi.org/10.1016/j.cageo.2016.08.003](https://doi.org/10.1016/j.cageo.2016.08.003)