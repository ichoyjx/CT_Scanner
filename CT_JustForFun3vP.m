% Richard Su
% COSC 6370 Fundamentals of Medical Imaging
% Fall 2013
% Code (no GUI) for image acquisition and reconstruction
% <GUI> labels areas for input for GUI
% Phantom is the head data phantom() > Shepp-Logan Phantom (modified version so it is easier to see)

function Image = CT_JustForFun3vP(phantom_img, NT, Anginc, Probe)

%Parameters of Scanning/Acquisition which will then be used for Reconstruction
I0 = 1; % starting intensity of x-ray <GUI>
%%%%% I0 isn't used right now
%NT = 5; % number of transducers <GUI>
%Anginc = 5; % angular increment <GUI>
theta = 1:Anginc:180; % number of angular positions (degrees) <GUI>
Distance = 50; % Distance from axis of rotation (mm) <GUI>
%%%%% Distance/Offset from transducer to axis of rotation isn't used right now


PhantomPixelSize = 0.3; % dimensions of the phantom image (mm) <GUI>
%PhantomSize = 420; % dimensions of the phantom in pixels <GUI>

%Type of transducer (LINEAR)
%Probe = 1; % specify the type of probe: 0 is linear and 1 is arc <GUI>
if Probe == 0
    Length = 5; % length of probe (mm) <GUI>
    if NT > 1
%         xpitch = Length/(NT-1);
        xpitch = round(Length/(NT-1)*(1/PhantomPixelSize)); %in pixels
        ypitch = 0;
    else
        xpitch = 0; ypitch = 0;
    end
%Type of transducer (ARC)
elseif Probe == 1
    Radius = 210; % radius/focus of the arc probe (mm) <GUI>
    Arc = 25; % total arc angle of probe (degrees) <GUI>
    if NT > 1
        angpitch = Arc/(NT-1);
%         xpitch = 2*cosd(angpitch/2)*Radius;
%         ypitch = 2*sind(angpitch/2)*Radius;
        xpitch = round(2*cosd(angpitch/2)*Radius*(1/PhantomPixelSize)); %in pixels
        ypitch = round(2*sind(angpitch/2)*Radius*(1/PhantomPixelSize)); %in pixels
    else
       angpitch = 0; xpitch = 0; ypitch = 0;
    end 
end
if xpitch > ypitch
    maxpitch = xpitch;
else
    maxpitch = ypitch;
end
if NT > 1
    maxoffset = (round((maxpitch *(NT-1)))); % maximum offset in pixels
    %maxoffset = (round((maxpitch *(NT-1))); % maximum offset in mm
else
    maxoffset = 0; % just one transducer so no offsetting of the image needed
end

%Creating the phantoms as seen by the scanner
% Brain Phantom (cartesian system)
% PhantomPixelSize = 0.3; % dimensions of the phantom image (mm) <GUI>
% PhantomSize = 420; % dimensions of the phantom in pixels <GUI>
% p = phantom('Modified Shepp-Logan',PhantomSize);

% Brian modified here
global ImageSize;
global PhantomSize;
PhantomSize = 420; %1028; % dimensions of the phantom in pixels <GUI>
p = phantom_img;%phantom('Modified Shepp-Logan',PhantomSize);
% Brian modified end

% p = phantom(PhantomSize); % more appropriate head phantom
% imshow(p); %Shepp-Logan modified brain phantom > easier to visualize
% Will assume anything outside the specified phantom is background
g = zeros(PhantomSize+maxoffset); 

% figure;
% subplot(1,2,1);
% imagesc(p); % Reconstructed Image
% title('Phantom Image/Data');

%Idealized case without any noise
% Basic code for just a single transducer
    % [r,xp] = radon(p,theta); %Central channel
    % imshow(R,[],'Xdata',theta,'Ydata',xp,'InitialMagnification','fit')
    % xlabel('\theta (degrees)')
    % ylabel('x''')
    % t1=iradon(r,theta);
    % i2 = iradon(r,theta,'linear','none');
    % subplot(1,3,1), imshow(P), title('Original')
    % subplot(1,3,2), imshow(I1), title('Filtered backprojection')
    % subplot(1,3,3), imshow(I2,[]), title('Unfiltered backprojection')
    % g(round(ypitch+1):round(ypitch)+PhantomSize,round(xpitch+1):round(xpitch)+PhantomSize) = p;
    % Creating total size of phantom offset for transducer positions
    % Those outside of input image are considered 0's
    % x-axis is associated to the columns (r,c) for Matlab
    % y-axis is associated to the rows (r,c) for Matlab
    
%Works ok for flat linear probes but inaccurate for arc probe since doing
%calculations based on the cartesian coordinate system
%ImageSize = 1028;
%Image = zeros(ImageSize); % Currently assuming a square/symmetric image
% Should separate phantom from data collection > STILL NEED TO WORK ON THIS
ImageSize = PhantomSize;
Image = zeros(ImageSize); %Phantom and data collection are the same resolution
if Probe == 0
    g(round(ypitch+1):round(ypitch)+PhantomSize,round(xpitch+1):round(xpitch)+ImageSize) = p;
    for t=1:NT
        xStart = round((t)*xpitch*(PhantomPixelSize));
        yStart = round((t)*ypitch*(PhantomPixelSize));
        % xStart and yStart cannot be 0 so +1 added to beginning
        % Ending pixel does not need the +1 as it is a 1:_
        pTemp = g(yStart+1:yStart+PhantomSize,xStart+1:xStart+PhantomSize);
        %%%%% CHECK OFFSET IS POSITIONALLY CORRECT
        [r,xp] = radon(pTemp,theta);
        % pTemp is the phantom as seen by that transducer
        % Currently done in Cartesian and for 2D slices, for linear and arc probes
        %%%%% SHOULD SEPARATE PHANTOM FROM DATA COLLECTION > DECIMATE OR INTERPOLATE
        t1=iradon(r,theta);
        mid = round(length(t1)/2);
        Image = Image + t1(mid-(ImageSize/2)+1:mid+(ImageSize/2),mid-(ImageSize/2)+1:mid+(ImageSize/2));
        %NEW tTemp = zeros(length(g));
        %NEW Image = Image(yStart+1:yStart+PhantomSize,xStart+1:PhantomSize) + t1(mid-(ImageSize/2):mid+(ImageSize/2)-1,mid-(ImageSize/2)+t:mid+(ImageSize/2)-1);
        %%%%% CHECK ADDITION IS POSITIONALLY CORRECT > Seems to be off....
    end
    %Making it work for arc probe by rotating the phantom image
elseif Probe == 1
    Angle = angpitch;
    Center = Radius;
    Direction = [0,1,0];
    g = p;
    for t=1:NT
        pTemp = imrotate(g,(t-1)*Angle,'nearest');
        %%%%% CHECK OFFSET IS POSITIONALLY CORRECT
        [r,xp] = radon(pTemp,theta);
        % This essentially simulates data acquistion for one angle and a single transducer
        % pTemp is the phantom as seen by that transducer
        % Currently done in Cartesian and for 2D slices, for linear and arc probes
        %%%%% SHOULD SEPARATE PHANTOM FROM DATA COLLECTION > DECIMATE OR INTERPOLATE
        t1=iradon(r,theta);
        t1 = imrotate(t1,-(t-1)*Angle,'nearest');
        mid = round(length(t1)/2);
        Image = Image + t1(mid-(ImageSize/2)+1:mid+(ImageSize/2),mid-(ImageSize/2)+1:mid+(ImageSize/2));
        % This essentially simulates data reconstruction for one angle
        % and a single transducer
        %%%%% CHECK ADDITION IS POSITIONALLY CORRECT
    end
end
Image = Image/NT;

% subplot(1,2,2);
% imagesc(Image); % Reconstructed Image
% title('Reconstructed Image');

%%%%% CAN ADD OFFSETS > Image center is not the axis of rotation
%%%%% For now will skip with presumption that the image center is always the axis of rotation
%%%%% Should mean that image degrades near the edges of the image as opposed to center

end
