function h = modismoa(varargin)
% MODISMOA plots Moderate Resolution Imaging 
% Spectroradiometer (MODIS) Mosaic of Antarctica (MOA) images, grounding
% lines and coastlines. Plotted data are high-pass 1 from 2004 or 2009. This
% function will be updated soon to include  MOA2014. 
% 
% The National Snow and Ice Data Center (NSIDC) and the University of New Hampshire assembled two digital 
% image maps and two snow-grain-size images of the Antarctic continent and surrounding islands that provide 
% a nearly-perfect cloud-free view of the ice sheet, ice shelves, and land surfaces using two different 
% sets of data:
% 
% * MODIS Mosaic of Antarctica 2003-2004 (MOA2004) Image Map
% * MODIS Mosaic of Antarctica 2008-2009 (MOA2009) Image Map.
% 
% The MOA2004 Image Map consists of two cloud-free digital image maps that show mean surface morphology 
% and a quantitative measure of optical snow grain size on the Antarctic continent and surrounding islands 
% using 260 orbit swaths from the Moderate Resolution Imaging Spectroradiometer (MODIS) instruments on board 
% the NASA EOS Aqua and Terra satellites. The 260 orbit swaths used to create the 2003-2004 MOA Surface 
% Morphology Image Map was acquired 20 November 2003 through 29 February 2004 for the full spring-summer season. 
% Corresponding coastlines and ice sheet grounding lines are also provided.
% 
% This is modismoa version 4 by Chad Greene, Univ. of Texas. 
%
%% Syntax 
% 
%  modismoa
%  modismoa(lat,lon) 
%  modismoa('location') 
%  modismoa(...,mapwidth) 
%  modismoa(...,'year')
%  modismoa(...,'inset','insetLocation')
%  modismoa(...,'resolution',res)
%  modismoa(...,'contrast',ContrastOption)
%  modismoa(...,'clearocean')
%  modismoa('gl') 
%  modismoa('gl','propertyName',propertyValue)
%  modismoa('coast') 
%  modismoa('coast','propertyName',propertyValue)
%  h = modismoa(...)
%
%% Description 
% 
% modismoa plots a polar stereographic 71 image of Antarctica. 
% 
% modismoa(lat,lon) centers a 500-kilometer-wide map at the
% location given by lat, lon.
% 
% modismoa('location') searches the <http://www.scar.org/ SCAR>
% database for the specified 'location' and centers a map at that location. (See the
% scarloc function in the Bedmap2 Toolbox for Matlab). 
%
% modismoa(...,mapwidth) centers a mapwidth-kilometer map at the specified
% location.  Default mapwidth is 500 km. 
% 
% modismoa(...,'year') specifies a year of MODIS MOA image, grounding
% line, or coast line.  The year must be a string (enclosed by apostrophes)
% and can only be '2004' or '2009'. Default year is '2009'.  
% 
% modismoa(...,,'inset','location') places an inset at one of these
% cardinal value locations: 
%
% * 'southeast'   lower right corner (default)
% * 'northwest'   upper left corner
% * 'northeast'   upper right corner
% * 'southwest'   lower left corner
% 
% modismoa(...,'resolution',res) specifies the resolution of the plotted
% data.  Can be 750 m, 125 m, or 'downsampled'.  By default, a map of
% width greater than 2000 km will plot 750 m data downsampled to 3750 m;
% for 400 < mapwidth <= 2000 km, 750 m resolution data are plotted; for
% maps up to 400 kilometers wide, 125 m data are plotted. Plotting 125 m
% data for very large areas might crash your computer. 
%
% modismoa(...,'contrast',ContrastOption) specifies contrast, or the axis
% limits of the color scale when plotting 125 m or non-downsampled 750 m 
% resolution data. Specifying contrast on a large downsampled 750 image
% will have no effect. Following the contrast options described in the
% web-based <http://nsidc.org/data/moa/users_guide.html MOA map users'
% guide>, ContrastOption may be:
% 
% * 'uhc'     (ultra-high contrast [15875 16125])
% * 'vhc'  	(very high contrast [15800 16200])
% * 'hc'  	(high contrast [15500 16500])
% * 'moa'  	(nominal contrast [15000 17000])
% * 'lc'   	(low contrast [12000 20000])
% * 'vlc'  	(very low contrast [9000 23000])
% * 'ulc'   	(ultra-low contrast [1 32000])
% * NumericRange (any two-element range) 
% 
% Setting contrast to a NumericRange is equivalent to following the
% modismoa command with caxis(NumericRange). 
% 
% modismoa(...,'clearocean') sets all zero values to NaN to make the ocean
% clear. Note that this usage may still leave dark edges around the continent.
% If you would like to plot ocean data alongside a modismoa image, consider
% plotting the modismoa image first. 
%
% modismoa('gl') plots the MODIS MOA grounding line. 
%
% modismoa('gl','propertyName',propertyValue) formats the grounding line
% with name-value marker style properties. 
%
% modismoa('cl') plots the MODIS MOA coast line. 
%
% modismoa('cl','propertyName',propertyValue) formats the coast line
% with name-value marker style properties. 
%
% h = modismoa(...) returns the handle h of plotted object(s). 
% 
%% Examples 
% 
% Examples can be found here: 
% http://www.mathworks.com/matlabcentral/fileexchange/47282-modis-mosaic-of-antarctica/content/html/modismoa_demo.html
% 
%% Requirements
% This function requires Matlab's Mapping Toolbox and the Antarctic Mapping Tools package
% which can be found on the Mathworks File Exchange site. 
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
% 
% 
%% Author Info
% This function was written by Chad A. Greene of the Institute for Geophysics
% and The University of Texas at Austin in July of 2014. If you run into
% any problems, let me know at chad@chadagreene.com.  For verification purposes
% I'm also interested in hearing if the modismoa function works.  If it
% works, let me know what operating system you're using and what
% release of Matlab you have. 
% 
% Updated August 2014 as a plugin to the Antarctic Mapping Tools package. 
% 
% See also: antmap, asaid, and measures. 

%% File checks: 

assert(exist('antmap.m','file')==2,'Cannot find some essential tools from the Antarctic Mapping Tools package. Is the toolbox somewhere that Matlab cannot find it?') 

%% Check inputs: 

% set default plot type:
plotImage = true; 
plotGL = false; 
plotCL = false; 
inset = false; 
resolution = 'downsampled'; 
clearOcean = false; 
plotyear = 2009; 
BrightnessRange = [15000 17000]; 


% Set year: 
tmp = strcmpi(varargin,'2009')|strcmpi(varargin,'moa2009');
if any(tmp)
    plotyear = 2009; 
    varargin = varargin(~tmp); 
end

tmp = strcmpi(varargin,'2004')|strcmpi(varargin,'moa2004');
if any(tmp)
    plotyear = 2004; 
    varargin = varargin(~tmp); 
end


% Brighness or contrast:
tmp = strncmpi(varargin,'bright',6)|strcmpi(varargin,'contrast')|strcmpi(varargin,'caxis')|...
    strcmpi(varargin,'clim');
if any(tmp)
    if ~isnumeric(varargin{find(tmp)+1})
        switch varargin{find(tmp)+1}
            case {'moa_uhc','uhc','uh','ultra high'} 
                BrightnessRange = [15875 16125]; 

            case {'moa_vhc','vhc','vh','very high'}
                BrightnessRange = [15800 16200]; 

            case {'moa_hc','hc','h','high'}
                BrightnessRange = [15500 16500]; 

            case {'moa','default'}
                BrightnessRange = [15000 17000];

            case {'moa_lc','lc','l','low'}
                BrightnessRange = [12000 20000];

            case {'moa_vlc','vlc','vl','very low'}
                BrightnessRange = [9000 23000];

            case {'moa_ulc','ulc','ul','ultra low'} 
                BrightnessRange = [1 32000];
                
            case {'white','w'}
                BrightnessRange = [1 17000]; % white-ish

            otherwise
                error('Invalid contrast range. Must be a string (e.g., ''vhc'') or numeric range (e.g. [15800 16200]).')
        end
        
    else
        BrightnessRange = varargin{find(tmp)+1};
        assert(isnumeric(BrightnessRange)==1,'Invalid contrast range. Must be a string (e.g., ''vhc'') or numeric range (e.g. [15800 16200]).')
        assert(numel(BrightnessRange)==2,'Invalid contrast range. Must be a string (e.g., ''vhc'') or numeric range (e.g. [15800 16200]).')

        
    end
    tmp(find(tmp)+1) = 1; 
    varargin = varargin(~tmp); 
end


% Get inset settings: 
tmp = strcmpi(varargin,'inset'); 
if any(tmp) 
    try
        insetLocation = varargin{find(tmp)+1}; 
        tmp(find(tmp)+1) = 1; 

    catch 
        insetLocation = 'southeast'; 
    end
    inset = true; 
    varargin = varargin(~tmp); 
end


% Is clear ocean declared? 
tmp = strcmpi(varargin,'clearocean') ;
if any(tmp) 
    clearOcean = true; 
    varargin = varargin(~tmp); 
end


% What variable are we mapping? 
if ~isempty(varargin) && ~isnumeric(varargin{1})
    switch lower(varargin{1})
        case {'g','gl','ground','grounding line'} 
            plotImage = false; 
            plotGL = true; 
            mapwidth = 6000; 
            varargin = varargin(2:end); 
                
        case {'c','cl','coast','coastline','coast line'}
            plotImage = false; 
            plotCL = true; 
            mapwidth = 6000; 
            varargin=varargin(2:end); 
    end
end
    

% Default mapwidth: 
if nargin==0
    mapwidth = 6000; % assume a big map if there are no input arguments. 
end


% Get centerpoint: 
if plotImage
    if nargin>0
        if isnumeric(varargin{1}) 
            lati = varargin{1}; 
            lati = -abs(lati); % ensures southern hemisphere 
            loni = varargin{2}; 
            assert(isscalar(lati),'Input latitude must be a scalar.') 
            assert(isscalar(loni),'Input longitude must be a scalar.')
            try
                mapwidth = varargin{3}; 
            end
        end

        if ischar(varargin{1})
            [lati,loni]=scarloc(varargin{1}); 
            if isempty(lati)
                error('modismoa cannot find the location you requested.') 
                return
            end
            if length(varargin)>1
                if isnumeric(varargin{2}) 
                    mapwidth = varargin{2}; 
                end
            end
        end
    end

    if ~exist('mapwidth','var') 
        mapwidth = 500;  % sets default if not declared. 
    end
end

%% Set resolution: 

if mapwidth >400 && mapwidth <=2000
    resolution = '750'; 
end
if mapwidth <= 400
    resolution = '125'; 
end

% change resolution if user declares it: 
tmp = strncmpi(varargin,'res',3);
if any(tmp)
    resolution = varargin{find(tmp)+1}; 
    tmp(find(tmp)+1) = 1; 
    varargin = varargin(~tmp); 
end
    

%% Initialize map: 

try % Is a map already initialized? If not, initialize one: 
    mapinitialized = strcmpi(getm(gca,'MapProjection'),'stereo');
catch 
    antmap; 
    set(gca,'visible','off');
end

hold on; 

%% Get the right data:  

if plotImage==true 
    switch lower(resolution)
        case {'downsampled','low','lo'}
            load moa750_r1_hp1_downsampled.mat
            BrightnessRange = [0 255]; 
    

        case {'750','750m','750 m',750,'medium','med'}
            imrad = round(mapwidth*.7); % half-width of resulting image in pixels

            % Subset full data set based on desired centerpoint given by lati,loni:
            % This requires switching to map x and y to interpolate: 

            % Get x and y points of desired lat/lon centerpoint: 
            [xi,yi] = ll2ps(lati,loni,'EarthRadius',6378137.0,'Eccentricity',0.081819190843);

            % Create an array corresponding to the dimensions of full dataset:
            x = -3174075:750:2867175; 
            y = (2405950:-750:-2816500)';

            % Find index of point close to desired center in full dataset: 
            xind = interp1(x,1:length(x),xi,'nearest'); 
            yind = interp1(y,1:length(y),yi,'nearest'); 

            % Create a range of x and y based on center point: 
            colmin = max([1 xind-imrad]); 
            colmax = min([length(x) xind+imrad]); 
            rowmin = max([1 yind-imrad]); 
            rowmax = min([length(y) yind+imrad]); 

            % Create a gridded range of x and y and corresponding gridded range of lat/lon:
            xr = repmat(x(colmin:colmax),[length(rowmin:rowmax),1]);
            yr = repmat(y(rowmin:rowmax),[1,length(colmin:colmax)]); 
            [lat,lon] =  ps2ll(xr,yr,'EarthRadius',6378137.0,'Eccentricity',0.081819190843);

            % Read a subset of the full tif file: 
            switch plotyear
                case {2004,'2004'}
                    moa = double(imread('moa750_2004_hp1_v1.1.tif', 'PixelRegion', {[rowmin rowmax],[colmin colmax]}));
                    
                case {2009,'2009'}
                    moa = double(imread('moa750_2009_hp1_v1.1.tif', 'PixelRegion', {[rowmin rowmax],[colmin colmax]}));
                    
                case {2014,'2014'}
                    error('2014 MOA data not yet supported.') 
                    
                otherwise
                    error('MODIS MOA images are only available for 2004 and 2009.')
            end
            
            % set clear ocean preference: 
            if clearOcean
                lat(moa==0)=NaN; 
                lon(moa==0)=NaN;
                moa(moa==0)=NaN; 
            end
    
        case {'125','125m','125 m',125,'high','hi'}
            imrad = round(mapwidth*4); % half-width of resulting image in pixels

            % Subset full data set based on desired centerpoint given by lati,loni:
            % This requires switching to map x and y to interpolate: 

            % Get x and y points of desired lat/lon centerpoint: 
            [xi,yi] =  ll2ps(lati,loni,'EarthRadius',6378137.0,'Eccentricity',0.081819190843);

            % Create an array corresponding to the dimensions of full dataset:
            x = -3174387.5:125:2867175; 
            y = (2406262.5:-125:-2816100)';

            % Find index of point close to desired center in full dataset: 
            xind = interp1(x,1:length(x),xi,'nearest'); 
            yind = interp1(y,1:length(y),yi,'nearest'); 

            % Create a range of x and y based on center point: 
            colmin = max([1 xind-imrad]); 
            colmax = min([length(x) xind+imrad]); 
            rowmin = max([1 yind-imrad]); 
            rowmax = min([length(y) yind+imrad]); 

            % Create a gridded range of x and y and corresponding gridded range of lat/lon:
            xr = repmat(x(colmin:colmax),[length(rowmin:rowmax),1]);
            yr = repmat(y(rowmin:rowmax),[1,length(colmin:colmax)]); 
            [lat,lon] =  ps2ll(xr,yr,'EarthRadius',6378137.0,'Eccentricity',0.081819190843);

            % Read a subset of the full tif file: 
            switch plotyear
                case {2004,'2004'}
                    moa = double(imread('moa125_2004_hp1_v1.1.tif', 'PixelRegion', {[rowmin rowmax],[colmin colmax]}));
                    
                case {2009,'2009'}
                    moa = double(imread('moa125_2009_hp1_v1.1.tif', 'PixelRegion', {[rowmin rowmax],[colmin colmax]}));
                    
                case {2014,'2014'}
                    error('2014 MOA data not yet supported.') 
                    
                otherwise
                    error('MODIS MOA images are only available for 2004 and 2009.')
            end
            
            % set clear ocean preference: 
            if clearOcean
                lat(moa==0)=NaN; 
                lon(moa==0)=NaN;
                moa(moa==0)=NaN; 
            end
    
        otherwise
            error('Resolution must be ''125 m'', ''750 m'', or ''downsampled''.')
    
    end
    
    % Plot data: 
    h = geoshow(lat,lon,moa,'displaytype','texturemap');
    colormap(gray(256)); 
    caxis(BrightnessRange)

    % Zoom to lat/lon: 
    if exist('lati','var'); 
        if inset
            mapzoom(lati,loni,mapwidth,'inset',insetLocation)
        else
            mapzoom(lati,loni,mapwidth); 
        end
    end
end

if plotGL 
    switch plotyear
        case {2004,'2004'}
            load moagl2004

        case {2009,'2009'}
            load moagl2009

        case {2014,'2014'} 
            error('2014 MOA data not yet supported.') 

        otherwise
            error('MODIS MOA images are only available for 2004 and 2009.')
    end
    
    h = plotm(gllat,gllon,'k.'); 
    if ~cellfun(@isempty,varargin)
        set(h,varargin{:})
    end
end 

if plotCL 
    switch plotyear
        case {2004,'2004'}
            load moacl2004

        case {2009,'2009'}
            load moacl2009

        case {2014,'2014'} 
            error('2014 MOA data not yet supported.') 

        otherwise
            error('MODIS MOA images are only available for 2004 and 2009.')
    end
    
    h = plotm(cllat,cllon,'k.'); 
    if ~cellfun(@isempty,varargin)
        set(h,varargin{:})
    end
end 

%% freezeColors 

freezeColors % This may be deleted if you do not want to freeze colors.  

%% Delete object handle if not requested by user: 

if nargout==0
    clear h
end


end


%% freezeColors 
function freezeColors(varargin)
% freezeColors  Lock colors of plot, enabling multiple colormaps per figure. (v2.3)
%
%   Problem: There is only one colormap per figure. This function provides
%       an easy solution when plots using different colomaps are desired 
%       in the same figure.
%
%   freezeColors freezes the colors of graphics objects in the current axis so 
%       that subsequent changes to the colormap (or caxis) will not change the
%       colors of these objects. freezeColors works on any graphics object 
%       with CData in indexed-color mode: surfaces, images, scattergroups, 
%       bargroups, patches, etc. It works by converting CData to true-color rgb
%       based on the colormap active at the time freezeColors is called.
%
%   The original indexed color data is saved, and can be restored using
%       unfreezeColors, making the plot once again subject to the colormap and
%       caxis.
%
%
%   Usage:
%       freezeColors        applies to all objects in current axis (gca),
%       freezeColors(axh)   same, but works on axis axh.
%
%   Example:
%       subplot(2,1,1); imagesc(X); colormap hot; freezeColors
%       subplot(2,1,2); imagesc(Y); colormap hsv; freezeColors etc...
%
%       Note: colorbars must also be frozen. Due to Matlab 'improvements' this can
%				no longer be done with freezeColors. Instead, please
%				use the function CBFREEZE by Carlos Adrian Vargas Aguilera
%				that can be downloaded from the MATLAB File Exchange
%				(http://www.mathworks.com/matlabcentral/fileexchange/24371)
%
%       h=colorbar; cbfreeze(h), or simply cbfreeze(colorbar)
%
%       For additional examples, see test/test_main.m
%
%   Side effect on render mode: freezeColors does not work with the painters
%       renderer, because Matlab doesn't support rgb color data in
%       painters mode. If the current renderer is painters, freezeColors
%       changes it to zbuffer. This may have unexpected effects on other aspects
%	      of your plots.
%
%       See also unfreezeColors, freezeColors_pub.html, cbfreeze.
%
%
%   John Iversen (iversen@nsi.edu) 3/23/05
%

%   Changes:
%   JRI (iversen@nsi.edu) 4/19/06   Correctly handles scaled integer cdata
%   JRI 9/1/06   should now handle all objects with cdata: images, surfaces, 
%                scatterplots. (v 2.1)
%   JRI 11/11/06 Preserves NaN colors. Hidden option (v 2.2, not uploaded)
%   JRI 3/17/07  Preserve caxis after freezing--maintains colorbar scale (v 2.3)
%   JRI 4/12/07  Check for painters mode as Matlab doesn't support rgb in it.
%   JRI 4/9/08   Fix preserving caxis for objects within hggroups (e.g. contourf)
%   JRI 4/7/10   Change documentation for colorbars

% Hidden option for NaN colors:
%   Missing data are often represented by NaN in the indexed color
%   data, which renders transparently. This transparency will be preserved
%   when freezing colors. If instead you wish such gaps to be filled with 
%   a real color, add 'nancolor',[r g b] to the end of the arguments. E.g. 
%   freezeColors('nancolor',[r g b]) or freezeColors(axh,'nancolor',[r g b]),
%   where [r g b] is a color vector. This works on images & pcolor, but not on
%   surfaces.
%   Thanks to Fabiano Busdraghi and Jody Klymak for the suggestions. Bugfixes 
%   attributed in the code.

% Free for all uses, but please retain the following:
%   Original Author:
%   John Iversen, 2005-10
%   john_iversen@post.harvard.edu

appdatacode = 'JRI__freezeColorsData';

[h, nancolor] = checkArgs(varargin);

%gather all children with scaled or indexed CData
cdatah = getCDataHandles(h);

%current colormap
cmap = colormap;
nColors = size(cmap,1);
cax = caxis;

% convert object color indexes into colormap to true-color data using 
%  current colormap
for hh = cdatah',
    g = get(hh);
    
    %preserve parent axis clim
    parentAx = getParentAxes(hh);
    originalClim = get(parentAx, 'clim');    
   
    %   Note: Special handling of patches: For some reason, setting
    %   cdata on patches created by bar() yields an error,
    %   so instead we'll set facevertexcdata instead for patches.
    if ~strcmp(g.Type,'patch'),
        cdata = g.CData;
    else
        cdata = g.FaceVertexCData; 
    end
    
    %get cdata mapping (most objects (except scattergroup) have it)
    if isfield(g,'CDataMapping'),
        scalemode = g.CDataMapping;
    else
        scalemode = 'scaled';
    end
    
    %save original indexed data for use with unfreezeColors
    siz = size(cdata);
    setappdata(hh, appdatacode, {cdata scalemode});

    %convert cdata to indexes into colormap
    if strcmp(scalemode,'scaled'),
        %4/19/06 JRI, Accommodate scaled display of integer cdata:
        %       in MATLAB, uint * double = uint, so must coerce cdata to double
        %       Thanks to O Yamashita for pointing this need out
        idx = ceil( (double(cdata) - cax(1)) / (cax(2)-cax(1)) * nColors);
    else %direct mapping
        idx = cdata;
        %10/8/09 in case direct data is non-int (e.g. image;freezeColors)
        % (Floor mimics how matlab converts data into colormap index.)
        % Thanks to D Armyr for the catch
        idx = floor(idx);
    end
    
    %clamp to [1, nColors]
    idx(idx<1) = 1;
    idx(idx>nColors) = nColors;

    %handle nans in idx
    nanmask = isnan(idx);
    idx(nanmask)=1; %temporarily replace w/ a valid colormap index

    %make true-color data--using current colormap
    realcolor = zeros(siz);
    for i = 1:3,
        c = cmap(idx,i);
        c = reshape(c,siz);
        c(nanmask) = nancolor(i); %restore Nan (or nancolor if specified)
        realcolor(:,:,i) = c;
    end
    
    %apply new true-color color data
    
    %true-color is not supported in painters renderer, so switch out of that
    if strcmp(get(gcf,'renderer'), 'painters'),
        set(gcf,'renderer','zbuffer');
    end
    
    %replace original CData with true-color data
    if ~strcmp(g.Type,'patch'),
        set(hh,'CData',realcolor);
    else
        set(hh,'faceVertexCData',permute(realcolor,[1 3 2]))
    end
    
    %restore clim (so colorbar will show correct limits)
    if ~isempty(parentAx),
        set(parentAx,'clim',originalClim)
    end
    
end %loop on indexed-color objects

end

% ============================================================================ %
% Local functions

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% getCDataHandles -- get handles of all descendents with indexed CData
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function hout = getCDataHandles(h)
% getCDataHandles  Find all objects with indexed CData

%recursively descend object tree, finding objects with indexed CData
% An exception: don't include children of objects that themselves have CData:
%   for example, scattergroups are non-standard hggroups, with CData. Changing
%   such a group's CData automatically changes the CData of its children, 
%   (as well as the children's handles), so there's no need to act on them.

error(nargchk(1,1,nargin,'struct'))

hout = [];
if isempty(h),return;end

ch = get(h,'children');
for hh = ch'
    g = get(hh);
    if isfield(g,'CData'),     %does object have CData?
        %is it indexed/scaled?
        if ~isempty(g.CData) && isnumeric(g.CData) && size(g.CData,3)==1, 
            hout = [hout; hh]; %#ok<AGROW> %yes, add to list
        end
    else %no CData, see if object has any interesting children
            hout = [hout; getCDataHandles(hh)]; %#ok<AGROW>
    end
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% getParentAxes -- return handle of axes object to which a given object belongs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function hAx = getParentAxes(h)
% getParentAxes  Return enclosing axes of a given object (could be self)

error(nargchk(1,1,nargin,'struct'))
%object itself may be an axis
if strcmp(get(h,'type'),'axes'),
    hAx = h;
    return
end

parent = get(h,'parent');
if (strcmp(get(parent,'type'), 'axes')),
    hAx = parent;
else
    hAx = getParentAxes(parent);
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% checkArgs -- Validate input arguments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [h, nancolor] = checkArgs(args)
% checkArgs  Validate input arguments to freezeColors

nargs = length(args);
error(nargchk(0,3,nargs,'struct'))

%grab handle from first argument if we have an odd number of arguments
if mod(nargs,2),
    h = args{1};
    if ~ishandle(h),
        error('JRI:freezeColors:checkArgs:invalidHandle',...
            'The first argument must be a valid graphics handle (to an axis)')
    end
    % 4/2010 check if object to be frozen is a colorbar
    if strcmp(get(h,'Tag'),'Colorbar'),
      if ~exist('cbfreeze.m'),
        warning('JRI:freezeColors:checkArgs:cannotFreezeColorbar',...
            ['You seem to be attempting to freeze a colorbar. This no longer'...
            'works. Please read the help for freezeColors for the solution.'])
      else
        cbfreeze(h);
        return
      end
    end
    args{1} = [];
    nargs = nargs-1;
else
    h = gca;
end

%set nancolor if that option was specified
nancolor = [nan nan nan];
if nargs == 2,
    if strcmpi(args{end-1},'nancolor'),
        nancolor = args{end};
        if ~all(size(nancolor)==[1 3]),
            error('JRI:freezeColors:checkArgs:badColorArgument',...
                'nancolor must be [r g b] vector');
        end
        nancolor(nancolor>1) = 1; nancolor(nancolor<0) = 0;
    else
        error('JRI:freezeColors:checkArgs:unrecognizedOption',...
            'Unrecognized option (%s). Only ''nancolor'' is valid.',args{end-1})
    end
end
end

