% Author: Richard Su
% Analyze the reconstructed image

function analyze(Image, p)

global ImageSize;

% Image Analysis
% p is generated image
% Image is the reconstructed image
% Image Analysis
% p is original phantom image
% Image is the reconstructed image
ImageSubt = Image - p;
StdDev = sqrt(sum(sum(ImageSubt^2))/(ImageSize^2)); % Standard deviation pixel by pixel comparison of phantom to reconstruction
display(['Standard deviation of whole phantom to whole reconstruction is ', num2str(StdDev)]);
figure;
imagesc(ImageSubt);
title('Resultant image from subtracting the phantom from the reconstructed CT simulation');
rAline = 225; % <GUI>
cAline = 210; % <GUI>
% Just taking a slice through the rows or x
figure;
plot(p(rAline,:)); 
hold on;
plot(Image(rAline,:),'r');
title(['Row Aline ', num2str(rAline)]);
legend('Phantom','Reconstruction');
% Just taking a slice through the columns or y
figure;
plot(p(:,cAline)); 
hold on;
plot(Image(:,cAline),'r');
title(['Column Aline ', num2str(cAline)]);
legend('Phantom','Reconstruction');

end