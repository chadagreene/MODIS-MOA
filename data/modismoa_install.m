% THIS IS LEGACY SCRIPT. 
% IT'S NO LONGER NEEDED. And I don't think it even works. 
% But in case you're interested how the grounding lines and coastlines
% were turned into .mat files, that stuff's at the bottom. 
% 
% -Chad A. Greene. 

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
save moagl2004 gllat gllon readme

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
save moagl2009 gllat gllon readme





