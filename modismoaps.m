function h = modismoaps(varargin)
% modismoaps initializes a MODIS Mosaic of Antarctica (MOA) image or adds a MODIS 
% MOA to an existing map. This function does NOT require Matlab's Mapping Toolbox. 
% 
%% Syntax
% 
%  modismoaps
%  modismoaps('gl') 
%  modismoaps('gl','PropertyName',PropertyValue) 
%  modismoaps('coast') 
%  modismoaps('coast','PropertyName',PropertyValue) 
%  modismoaps(...,'year',year) 
%  modismoaps(...'km') 
%  modismoaps(...'clearocean',true_or_false) 
%  h = modismoaps(...)
% 
%% Description 
% 
% modismoaps fills a current map with a MODIS MOA image. If a map is not already open, 
% modismoaps initializes a continent-wide map. Resolution is automatically determined 
% by the size of the map--maps larger than approximately 500 km by 500 km are filled
% with 750 m resolution data, but small maps are filled with 125 m data. 
% 
% modismoaps('gl') places a MODIS MOA grounding line. 
% 
% modismoaps('gl','PropertyName',PropertyValue) formats the grounding line with any
% line or marker property accepted by Matlab ('linewitdh','color',etc).  This grounding
% line is the break-in-surface-slope determined from the MODIS imagery. 
% 
% modismoaps('coast') places a MODIS MOA coast line.  
% 
% modismoaps('coast','PropertyName',PropertyValue) formats the coast line.  
% 
% modismoaps(...,,'year',year) plots image, grounding line, or coast data from the year 2004, 2009, or 2014. 
% Default year is 2014. 
% 
% modismoaps(...'km') plots in polar stereographic kilometers rather than meters.  
% 
% modismoaps(...'clearocean',true_or_false) makes open-ocean image data transparent. 
% The results are not very pretty because sea ice remains, but no mask is distributed
% with the MODIS MOA datasets.  If you'd like to do a better job of masking, use the 
% Bedmap2 icemask, or you can load the MOA grounding line data and use inpolygon, but 
% the latter option will be computationally slow. 
% 
% h = modismoaps(...) returns a handle for plotted image or line data. 
% 
%% Example 1: Continent-wide image: 
% 
% modismoaps 
% 
%% Example 2: Small region image: 
% 
% mapzoomps('drygalski ice tongue','mapwidth',[200 100])
% modismoaps
% scalebarps('color','white')
% 
%% Example 3: Overlay a fat blue grounding line and a dashed red coast line: 
% 
% mapzoomps('siple coast','mapwidth',1200,'inset','nw')
% modismoaps
% modismoaps('gl','color','blue','linewidth',3) 
% modismoaps('coast','r--')
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
% Greene, C.A., Gwyther, D.E. and Blankenship, D.D., 2016. Antarctic Mapping Tools for Matlab. 
% Computers & Geosciences.  http://dx.doi.org/10.1016/j.cageo.2016.08.003
% 
%% Author Info
% This function was written by Chad A. Greene, October 2016. 
% The University of Texas Institute for Geophysics (UTIG). 
% http://www.chadagreene.com
% 
% See also scalebarps, graticuleps, and mapzoomps. 

%% Set defaults:

year = 2014;         % 2004 is also supported
datatype = 'image';  % other options are 'gl' or 'coast'
hld = 1;             % hold state of image
plotkm = false;      % plot in polar stereographic meters by default
BrightnessRange = [15000 17000];
clearocean = false; 

%% Parse inputs:

% Data year: (support old way of inputs as strings, but also allow new way as numeric:)
tmp = strcmp(varargin,'2004'); 
if any(tmp)
   year = 2004; 
   varargin = varargin(~tmp); 
end
tmp = strcmp(varargin,'2009'); 
if any(tmp)
   year = 2009; 
   varargin = varargin(~tmp); 
end
tmp = strcmp(varargin,'2014'); 
if any(tmp)
   varargin = varargin(~tmp); 
end

tmp = strcmpi(varargin,'year'); 
if any(tmp)
   year = varargin{find(tmp)+1};
   assert(ismember(year,[2004 2009 2014]),'Error: year must be 2004, 2009, or 2014')
   tmp(find(tmp)+1) = 1; 
   varargin = varargin(~tmp); 
end

switch year 
   case 2004
      imagefilename = 'moa125_2004_hp1_v02.0.tif'; 
   case 2009
      imagefilename = 'moa125_2009_hp1_v02.0.tif'; 
   case 2014
      imagefilename = 'moa125_2014_hp1_v01.tif'; 
   otherwise 
      error('unrecognized year.') 
end
   
% Data type:
tmp = strcmpi(varargin,'gl'); 
if any(tmp)
   datatype = 'gl'; 
   varargin = varargin(~tmp); 
end
tmp = strcmpi(varargin,'coast'); 
if any(tmp)
   datatype = 'coast'; 
   varargin = varargin(~tmp); 
end


% Plot in ps kilometers?  
tmp = strcmpi(varargin,'km'); 
if any(tmp)
   plotkm = true; 
   varargin = varargin(~tmp); 
end

% Contrast for MOA image: 
tmp = strncmpi(varargin,'contrast',4);
if any(tmp)
   BrightnessRange = varargin{find(tmp)+1}; 
   
   % User-defined brightness range? 
   if isnumeric(BrightnessRange) 
      BrightnessRange = varargin{find(tmp)+1};
      assert(isnumeric(BrightnessRange)==1,'Invalid contrast range. Must be a string (e.g., ''vhc'') or numeric range (e.g. [15800 16200]).')
      assert(numel(BrightnessRange)==2,'Invalid contrast range. Must be a string (e.g., ''vhc'') or numeric range (e.g. [15800 16200]).')

   else    
      % Or use NSIDC's brightness ranges: 
      switch lower(BrightnessRange)
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
   end
        
   tmp(find(tmp)+1) = 1; 
   varargin = varargin(~tmp); 
end

% Make open water pixels transparent? 
tmp = strncmpi(varargin,'clearocean',5);
if any(tmp)
   clearocean = varargin{find(tmp)+1}; 
   assert(islogical(clearocean)==1,'Input error: clearocean option must be true or false.') 
   tmp(find(tmp)+1) = 1; 
   varargin = varargin(~tmp); 
end

% Determine line data (gl or coast) filenames: 
switch datatype 
   case 'gl'
      switch year 
         case 2004
            linedata = 'moagl2004.mat'; 
         case 2009
            linedata = 'moagl2009.mat'; 
         case 2014
            linedata = 'moagl2014.mat'; 
         otherwise
            error 'bad year'  
      end
   case 'coast'
      switch year 
         case 2004
            linedata = 'moacl2004.mat'; 
         case 2009
            linedata = 'moacl2009.mat'; 
         case 2014
            linedata = 'moacl2014.mat'; 
         otherwise
            error 'bad year' 
      end
end
     
%% Get initial conditions of the figure: 

% Aspect ratio and hold state: 
da = daspect; 
da = [1 1 da(3)]; 
hld = ishold; 
hold on

axlim = axis; 

% Is a map already open? 
if isequal(axlim,[0 1 0 1])
   axlim = [-2533090 2769304 -2168930 2266317]; 
else
   if plotkm
      axlim = axlim*1000; 
   end
end

%% Determine which resolution image to use: 

pixels_at_125_res = abs(diff(axlim(1:2)/125)*diff(axlim(3:4)/125)); 

% Use 750 m resolution data if map is larger than 1000x1000 km or equivalent in pixels: 
if pixels_at_125_res>64e6
   
   % Array corresponding to the dimensions of full MODIS dataset:
   x = -3174075:750:2867175; 
   y = (2405950:-750:-2816500)';
   
   % Select filename based on year: 
   switch year
      case 2004 
         imagefilename = 'moa750_2004_hp1_v02.0.tif'; 
      case 2009
         imagefilename = 'moa750_2009_hp1_v02.0.tif'; 
      case 2014
         imagefilename = 'moa750_2014_hp1_v01.tif'; 
   end
else
   x = -3174387.5:125:2867175; 
   y = (2406262.5:-125:-2816100)';
end

%% Load data

switch datatype 
   case 'image'
      assert(exist(imagefilename,'file')==2,'Error: cannot find the image file. Make sure you have run the modismoa_install script and Matlab can find the data.') 
      
      % Find indices corresponding to axis limits: 
      xind = find(x>=axlim(1) & x<=axlim(2)); 
      yind = find(y>=axlim(3) & y<=axlim(4)); 
      
      % Clip the arrays: 
      x = x(xind); 
      y = y(yind); 

      % Load image:  
      moa = imread(imagefilename, 'PixelRegion', {[yind(1) yind(end)],[xind(1) xind(end)]});
      
      % Convert grayscale values to RGB image: 
      RGB = mat2im(moa,gray(256),BrightnessRange); 
      
   case {'gl','coast'}
      assert(exist(linedata,'file')==2,'Error: cannot find the grounding line file. Make sure you have run the modismoa_install script and Matlab can find the data.') 
      load(linedata)
      
      if strcmp(datatype,'coast') 
         [x,y] = ll2ps(cllat,cllon); 
      else
         [x,y] = ll2ps(gllat,gllon);          
      end
      
      % Indices of line data within the quadrangle of the map: 
      ind = inpsquad(x,y,axlim(1:2),axlim(3:4),'inclusive'); 
      
      % Set everything outside the map quadrangle to NaN, which prevents disjointed segments from automatically connecting: 
      x(~ind) = NaN; 
      y(~ind) = NaN; 
            
      % Now for small regions there might be long series of NaNs which previously separated small bits
      % but no longer serve any purpose. So we trim them: 
      trim = ~ind & [0;diff(ind)]==0; 
      x = x(~trim); 
      y = y(~trim); 

end

%% Plot data 

if plotkm 
   x = x/1000; 
   y = y/1000; 
end

switch datatype
   case 'image'
      h = image(x,y,RGB); 
      axis xy
            
      if clearocean
         set(h,'alphadata',moa>0)
      end
      
      % Push image to bottom of the stack: 
      uistack(h,'bottom') 
      
   case {'gl','coast'}
      h = plot(x,y,varargin{:}); 
      
end

%% Clean up: 

axis xy 
daspect(da)

if plotkm
   axis(axlim/1000)
else
   axis(axlim)
end

if ~hld
   hold off
end

if nargout==0
   clear h
end
end


function im=mat2im(mat,cmap,limits)
% mat2im - convert to rgb image
%
% function im=mat2im(mat,cmap,maxVal)
%
% PURPOSE
% Uses vectorized code to convert matrix "mat" to an m-by-n-by-3
% image matrix which can be handled by the Mathworks image-processing
% functions. The the image is created using a specified color-map
% and, optionally, a specified maximum value. Note that it discards
% negative values!
%
% INPUTS
% mat     - an m-by-n matrix  
% cmap    - an m-by-3 color-map matrix. e.g. hot(100). If the colormap has 
%           few rows (e.g. less than 20 or so) then the image will appear 
%           contour-like.
% limits  - by default the image is normalised to it's max and min values
%           so as to use the full dynamic range of the
%           colormap. Alternatively, it may be normalised to between
%           limits(1) and limits(2). Nan values in limits are ignored. So
%           to clip the max alone you would do, for example, [nan, 2]
%          
%
% OUTPUTS
% im - an m-by-n-by-3 image matrix  
%
%
% Example 1 - combine multiple color maps on one figure 
% clf, colormap jet, r=rand(40);
% subplot(1,3,1),imagesc(r), axis equal off , title('jet')
% subplot(1,3,2),imshow(mat2im(r,hot(100))) , title('hot')
% subplot(1,3,3),imshow(mat2im(r,summer(100))), title('summer')
% colormap winter %changes colormap in only the first panel
%
% Example 2 - clipping
% p=peaks(128); J=jet(100);
% subplot(2,2,1), imshow(mat2im(p,J)); title('Unclipped')
% subplot(2,2,2), imshow(mat2im(p,J,[0,nan])); title('Remove pixels <0')
% subplot(2,2,3), imshow(mat2im(p,J,[nan,0])); title('Remove pixels >0')
% subplot(2,2,4), imshow(mat2im(p,J,[-1,3])); title('Plot narrow pixel range')
%
% Rob Campbell - April 2009
%
% See Also: ind2rgb, imadjust


%Check input arguments

if ~isa(mat, 'double')
    mat = double(mat)+1;    % Switch to one based indexing
end

if ~isnumeric(cmap)
    error('cmap must be a colormap, such as jet(100)')
end


%Clip if desired
L=length(cmap);
if nargin==3 && length(limits)==1
    warning('limits should be vector of length of 2. Assuming a max value was specified.')
    limits=[nan,limits];
end

if nargin==3
    minVal=limits(1);
    if isnan(minVal), minVal=min(mat(:)); end    
    mat(mat<minVal)=minVal;
    
    maxVal=limits(2);
    if isnan(maxVal), maxVal=max(mat(:)); end
    mat(mat>maxVal)=maxVal;        
else
minVal=min(mat(:));
maxVal=max(mat(:));
end


%Normalise 
mat=mat-minVal;
mat=(mat/(maxVal-minVal))*(L-1);
mat=mat+1;


%convert to indecies 
mat=round(mat); 


%Vectorised way of making the image matrix 
im=reshape(cmap(mat(:),:),[size(mat),3]);
end