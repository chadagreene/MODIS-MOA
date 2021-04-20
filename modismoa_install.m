% modismoa download and installation script. 
% 
% This function downloads (if necessary) and reformats MODIS Mosaic of
% Antarctica data for use by the modismoa function. This installation script only 
% needs to be run once.  Expect it to take ~10 minutes on a modern laptop
% computer.  Expect longer if you have not already downloaded the data.
% Expect it to take very long if you have not downloaded the data and you
% have a slow internet connection. 
% 
% This script was written by Chad A. Greene of the Institute for Geophysics
% and the University of Texas at Austin, July 2014. 
% Updated August as a plugin for Antarctic Mapping Tools. 
% I'll be updating this script to include MOA2014 as
% soon as the MOA2014 data are available. 
% 
% Requirements: 
% This installation script requires the Antarctic Mapping Tools package for
% Matlab. The modismoa function (the reason you are running this installation 
% script) requires Matlab's Mapping Toolbox. 
% 
% 
% The MOA mosaic is a composite image of 260 MODIS (Moderate Resolution
% Imaging Spectroradiometer) images acquired over the 2003-2004 austral
% summer season. It provides a nearly-perfect cloud-free view of the ice
% sheet, ice shelves, and land surfaces at a grid scale of 125 m, and
% estimated resolution of 150 m. All land areas and islands (larger than a
% few hundred meters) south of 60 deg S are included in the mosaic, as well
% as several persistent fast ice areas and some grounded icebergs. Two image
% data sets were compiled: a digitally smoothed red-light (band 1 of MODIS)
% image map; and a snow grain size image (normalized difference of calibrated
% band 1 and band 2 MODIS data).
% 
% The data are available via ftp and a mapserver website.
% 
%% Citing these Data
% When citing MODIS MOA data, please cite the following: 
% 
% Haran, T., J. Bohlander, T. Scambos, T. Painter, and M. Fahnestock. 2014. 
% MODIS Mosaic of Antarctica 2008-2009 <http://dx.doi.org/10.7265/N5KP8037
% (MOA2009)> Image Map 2009. [indicate subset used]. Boulder, Colorado USA:
% National Snow and Ice Data Center. 
% 
% Scambos, T., T. Haran, M. Fahnestock, T. Painter, and J. Bohlander. 2007. 
% MODIS-based Mosaic of Antarctica (MOA) data sets: Continent-wide Surface Morphology 
% and Snow Grain Size. Remote Sensing of Environment <http://dx.doi.org/10.1016/j.rse.2006.12.020
% 111(2): 242-257>. 
% 
% Bohlander, J., T. Scambos, T. Haran, M. Fahnestock, 2004. A New MODIS-
% based Mosaic of Antarctica: MOA. Eos. Trans. AGU, 85(47), F452.

%% Installation 
% To use the modismoa function, you must first run modismoa_install.  You will
% only need to run it once.  The installation script downloads the data and
% formats it in a way that is efficient for the modismoa function to
% call. This installation script may take some time to run because it
% downloads about 2.5 GB of data.  
% 
% If your network administrator has imposed strict firewall settings, the 
% automatic download may fail. If this happens, simply download these five
% files manually, place them in your current folder, and try to run the
% installation script again:
%  
% ftp://sidads.colorado.edu/pub/DATASETS/nsidc0593_moa2009/geotiff/moa125_2009_hp1_v1.1.tif.gz
% ftp://sidads.colorado.edu/pub/DATASETS/nsidc0593_moa2009/geotiff/moa750_2009_hp1_v1.1.tif.gz
% ftp://sidads.colorado.edu/pub/DATASETS/nsidc0593_moa2009/coastlines/moa_2009_coastline_v1.1.txt
% ftp://sidads.colorado.edu/pub/DATASETS/nsidc0593_moa2009/coastlines/moa_2009_groundingline_v1.1.txt
% ftp://sidads.colorado.edu/pub/DATASETS/nsidc0280_moa2004/geotiff/moa125_2004_hp1_v1.1.tif.gz
% ftp://sidads.colorado.edu/pub/DATASETS/nsidc0280_moa2004/geotiff/moa750_2004_hp1_v1.1.tif.gz
% ftp://sidads.colorado.edu/pub/DATASETS/nsidc0280_moa2004/coastlines/moa_2004_coastline_v1.1.txt
% ftp://sidads.colorado.edu/pub/DATASETS/nsidc0280_moa2004/coastlines/moa_2004_groundingline_v1.1.txt
% ftp://sidads.colorado.edu/pub/DATASETS/MOA/moa750_r1_hp1.img.gz

%% Author Info: 
% This script was written by Chad A. Greene of the Institute for Geophysics
% and The University of Texas at Austin in July of 2014. If you run into
% any problems, let me know at chad@chadagreene.com.  For verification purposes
% I'm also interested in hearing if the modismoa function works.  If it
% works, let me know what operating system you're using and what
% release of Matlab you have.  



%% Download and/or unzip 750 meter .tif data from 2009: 

if exist('moa125_2009_hp1_v1.1.tif','file')~=2 
    if exist('moa125_2009_hp1_v1.1.tif.gz','file')~=2
        try
            % Download may take ~2 minutes
            disp('Downloading 2009 data...')
            gunzip('ftp://sidads.colorado.edu/pub/DATASETS/nsidc0593_moa2009/geotiff/moa125_2009_hp1_v1.1.tif.gz'); 
        catch
            error('Auto download failed. Perhaps your firewall settings will not allow the download. The simplest solution is to download directly from ftp://sidads.colorado.edu/pub/DATASETS/MOA.') 
        end
    else
        gunzip('moa125_2009_hp1_v1.1.tif.gz'); 
    end
end

%% Download and/or unzip 750 meter .tif data from 2009 : 

if exist('moa750_2009_hp1_v1.1.tif','file')~=2 
    if exist('moa750_2009_hp1_v1.1.tif','file')~=2
        try
            % Download may take a minute
            gunzip('ftp://sidads.colorado.edu/pub/DATASETS/nsidc0593_moa2009/geotiff/moa750_2009_hp1_v1.1.tif.gz'); 
        catch
            error('Auto download failed. Perhaps your firewall settings will not allow the download. The simplest solution is to download directly from ftp://sidads.colorado.edu/pub/DATASETS/MOA.') 
        end
    else
        gunzip('moa750_2009_hp1_v1.1.tif.gz'); 
    end
end


%% Download, reformat, and save 2009 grounding line: 

if exist('moagl2009.mat','file')~=2
    if exist('moa_2009_groundingline_v1.1.txt','file')~=2
        try
            urlwrite('ftp://sidads.colorado.edu/pub/DATASETS/nsidc0593_moa2009/coastlines/moa_2009_groundingline_v1.1.txt','moa_2009_groundingline_v1.1.txt'); 
        catch
            error('Auto download failed. Perhaps your firewall settings will not allow the download. The simplest solution is to download directly from ftp://sidads.colorado.edu/pub/DATASETS/MOA.') 
        end
    end
end

fid = fopen('moa_2009_groundingline_v1.1.txt'); 
    C = textscan(fid,'%f %f');
fclose(fid);

gllat = C{2}; 
gllon = C{1}; 

save moagl2009 gllat gllon 
clear moagl gllat gllon C

%% Download, reformat, and save 2009 coast line: 

if exist('moacl2009.mat','file')~=2
    if exist('moa_2009_coastline_v1.1.txt','file')~=2
        try
            urlwrite('ftp://sidads.colorado.edu/pub/DATASETS/nsidc0593_moa2009/coastlines/moa_2009_coastline_v1.1.txt','moa_2009_coastline_v1.1.txt');         
        catch
            error('Auto download failed. Perhaps your firewall settings will not allow the download. The simplest solution is to download directly from ftp://sidads.colorado.edu/pub/DATASETS/MOA.') 
        end
    end
end

fid = fopen('moa_2009_coastline_v1.1.txt'); 
    C = textscan(fid,'%f %f');
fclose(fid);

cllat = C{2}; 
cllon = C{1}; 

save moacl2009 cllat cllon 

clear

disp('2009 data complete.')



%% Download and/or unzip 750 meter data for downsampling: 
% This is redundant and wasteful of hard-earned computer space, but makes things easier.  

if exist('moa750_r1_hp1.img','file')~=2 
    if exist('moa750_r1_hp1.img.gz','file')~=2
        try
            % Download may take a minute 
            disp('Downloading some legacy data.') 
            gunzip('ftp://sidads.colorado.edu/pub/DATASETS/MOA/moa750_r1_hp1.img.gz'); 
        catch
            error('Auto download failed. Perhaps your firewall settings will not allow the download. The simplest solution is to download directly from ftp://sidads.colorado.edu/pub/DATASETS/MOA.') 
        end
    else
        gunzip('moa750_r1_hp1.img.gz'); 
    end
end


%% Open, reformat, and save 750 meter data 

fid=fopen('moa750_r1_hp1.img','r','l');
    moa750_r1_hp1=fread(fid,[8056,6964],'uint16');
fclose(fid);
moa750_r1_hp1(moa750_r1_hp1==0)=NaN; 
moa750_r1_hp1=rot90(flipud(moa750_r1_hp1),3); 

xs = repmat(-3174075:750:2867175,[6964,1]); 
ys = repmat((2405950:-750:-2816300)',[1,8056]);

xs(isnan(moa750_r1_hp1))=NaN;
ys(isnan(moa750_r1_hp1))=NaN;
[lat,lon] = ps2ll(xs,ys,'EarthRadius',6378137.0,'Eccentricity',0.081819190843);


% DOWNSAMPLE: 
lat = lat(1:5:6964,1:5:8056); 
lon = lon(1:5:6964,1:5:8056); 
moa = moa750_r1_hp1(1:5:6964,1:5:8056); 
moa = 255*moa./max(moa(:)); 

save moa750_r1_hp1_downsampled lat lon moa
clear lat lon moa ys xs moa*

disp('Legacy data processing complete.')



%% Download and/or unzip 750 meter .tif data from 2004: 

if exist('moa125_2004_hp1_v1.1.tif','file')~=2 
    if exist('moa125_2004_hp1_v1.1.tif.gz','file')~=2
        try
            % Download may take ~2 minutes
            disp('Downloading 2004 data...')
            gunzip('ftp://sidads.colorado.edu/pub/DATASETS/nsidc0280_moa2004/geotiff/moa125_2004_hp1_v1.1.tif.gz'); 
        catch
            error('Auto download failed. Perhaps your firewall settings will not allow the download. The simplest solution is to download directly from ftp://sidads.colorado.edu/pub/DATASETS/MOA.') 
        end
    else
        gunzip('moa125_2004_hp1_v1.1.tif.gz'); 
    end
end

%% Download and/or unzip 750 meter .tif data from 2004 : 

if exist('moa750_2004_hp1_v1.1.tif','file')~=2 
    if exist('moa750_2004_hp1_v1.1.tif','file')~=2
        try
            % Download may take a minute
            gunzip('ftp://sidads.colorado.edu/pub/DATASETS/nsidc0280_moa2004/geotiff/moa750_2004_hp1_v1.1.tif.gz'); 
        catch
            error('Auto download failed. Perhaps your firewall settings will not allow the download. The simplest solution is to download directly from ftp://sidads.colorado.edu/pub/DATASETS/MOA.') 
        end
    else
        gunzip('moa750_2004_hp1_v1.1.tif.gz'); 
    end
end


%% Download, reformat, and save 2004 grounding line: 

if exist('moagl2004.mat','file')~=2
    if exist('moa_2004_groundingline_v1.1.txt','file')~=2
        try
            urlwrite('ftp://sidads.colorado.edu/pub/DATASETS/nsidc0280_moa2004/coastlines/moa_2004_groundingline_v1.1.txt','moa_2004_groundingline_v1.1.txt'); 
        catch
            error('Auto download failed. Perhaps your firewall settings will not allow the download. The simplest solution is to download directly from ftp://sidads.colorado.edu/pub/DATASETS/MOA.') 
        end
    end
end

fid = fopen('moa_2004_groundingline_v1.1.txt'); 
    C = textscan(fid,'%f %f');
fclose(fid);

gllat = C{2}; 
gllon = C{1}; 

save moagl2004 gllat gllon 
clear moagl gllat gllon C

%% Download, reformat, and save 2004 coast line: 

if exist('moacl2004.mat','file')~=2
    if exist('moa_2004_coastline_v1.1.txt','file')~=2
        try
            urlwrite('ftp://sidads.colorado.edu/pub/DATASETS/nsidc0280_moa2004/coastlines/moa_2004_coastline_v1.1.txt','moa_2004_coastline_v1.1.txt');         
        catch
            error('Auto download failed. Perhaps your firewall settings will not allow the download. The simplest solution is to download directly from ftp://sidads.colorado.edu/pub/DATASETS/MOA.') 
        end
    end
end

fid = fopen('moa_2004_coastline_v1.1.txt'); 
    C = textscan(fid,'%f %f');
fclose(fid);

cllat = C{2}; 
cllon = C{1}; 

save moacl2004 cllat cllon 

clear moacl cllat cllon C 

disp('MODIS MOA installation complete. ')


%% Download, reformat, and save 2014 grounding line: 

if exist('moagl2014.mat','file')~=2
    if exist('moa_2014_groundingline_v1.1.txt','file')~=2
        try
           bad  urlwrite('ftp://sidads.colorado.edu/pub/DATASETS/nsidc0280_moa2004/coastlines/moa_2004_groundingline_v1.1.txt','moa_2004_groundingline_v1.1.txt'); 
        catch
            error('Auto download failed. Perhaps your firewall settings will not allow the download. The simplest solution is to download directly from ftp://sidads.colorado.edu/pub/DATASETS/MOA.') 
        end
    end
end

fid = fopen('moa2014_grounding_line_v01.txt'); 
    C = textscan(fid,'%f %f');
fclose(fid);

gllat = C{2}; 
gllon = C{1}; 

save moagl2014 gllat gllon 
clear moagl gllat gllon C

%% Download, reformat, and save 2014 coast line: 

if exist('moacl2014.mat','file')~=2
    if exist('moa2014_coastline_v01.txt','file')~=2
        try
            bad urlwrite('ftp://sidads.colorado.edu/pub/DATASETS/nsidc0280_moa2004/coastlines/moa_2004_coastline_v1.1.txt','moa_2004_coastline_v1.1.txt');         
        catch
            error('Auto download failed. Perhaps your firewall settings will not allow the download. The simplest solution is to download directly from ftp://sidads.colorado.edu/pub/DATASETS/MOA.') 
        end
    end
end

fid = fopen('moa2014_coastline_v01.txt'); 
    C = textscan(fid,'%f %f');
fclose(fid);

cllat = C{2}; 
cllon = C{1}; 

save moacl2014 cllat cllon 

clear moacl cllat cllon C 

disp('MODIS MOA installation complete. ')

%% 

% https://daacdata.apps.nsidc.org/pub/DATASETS/nsidc0280_moa2004_v02/coastlines/moa_2004_coastline_v02.0.txt
% https://daacdata.apps.nsidc.org/pub/DATASETS/nsidc0593_moa2009_v02/coastlines/moa_2009_coastline_v02.0.txt
% https://daacdata.apps.nsidc.org/pub/DATASETS/nsidc0280_moa2004_v02/coastlines/moa_2004_groundingline_v02.0.txt
% https://daacdata.apps.nsidc.org/pub/DATASETS/nsidc0593_moa2009_v02/coastlines/moa_2009_groundingline_v02.0.txt
% https://daacdata.apps.nsidc.org/pub/DATASETS/nsidc0280_moa2004_v02/geotiff/moa125_2004_hp1_v02.0.tif.gz
% https://daacdata.apps.nsidc.org/pub/DATASETS/nsidc0593_moa2009_v02/geotiff/moa125_2009_hp1_v02.0.tif.gz
% https://daacdata.apps.nsidc.org/pub/DATASETS/nsidc0280_moa2004_v02/geotiff/moa750_2004_hp1_v02.0.tif.gz
% https://daacdata.apps.nsidc.org/pub/DATASETS/nsidc0593_moa2009_v02/geotiff/moa750_2009_hp1_v02.0.tif.gz

fid = fopen('moa_2004_coastline_v02.0.txt'); 
    C = textscan(fid,'%f %f');
fclose(fid);
cllat = C{2}; 
cllon = C{1}; 
readme = 'data from moa_2004_coastline_v02.0.txt. Saved by modismoa_install.m';
save moacl2004 cllat cllon readme

fid = fopen('moa_2004_groundingline_v02.0.txt'); 
    C = textscan(fid,'%f %f');
fclose(fid);
gllat = C{2}; 
gllon = C{1}; 
readme = 'data from moa_2004_groundingline_v02.0.txt. Saved by modismoa_install.m';
save moagl2004 cllat cllon readme

fid = fopen('moa_2009_coastline_v02.0.txt'); 
    C = textscan(fid,'%f %f');
fclose(fid);
cllat = C{2}; 
cllon = C{1}; 
readme = 'data from moa_2009_coastline_v02.0.txt. Saved by modismoa_install.m';
save moacl2009 cllat cllon readme

fid = fopen('moa_2009_groundingline_v02.0.txt'); 
    C = textscan(fid,'%f %f');
fclose(fid);
gllat = C{2}; 
gllon = C{1}; 
readme = 'data from moa_2009_groundingline_v02.0.txt. Saved by modismoa_install.m';
save moagl2009 cllat cllon readme





