RGB=imread('shape1.png');
% figure
% imshow(RGB),
% title('Original Image');


GRAY = rgb2gray(RGB);
% figure,
% imshow(GRAY),
% title('Gray Image');


threshold = graythresh(GRAY);
BW = im2bw(GRAY, threshold);
% figure,
% imshow(BW),
% title('Binary Image');


BW = ~ BW;
% figure,
% imshow(BW),
% title('Inverted Binary Image');


[V,L] = bwboundaries(BW, 'noholes');


STATS = regionprops(L, 'all'); 


figure,
imshow(RGB),
title('Results');
hold on
for i = 1 : length(STATS)
    v(i)=(STATS(i).Extent);
  v(i)=com(v(i));
  centroid = STATS(i).Centroid;
  switch v(i)
      case 0.7854
          plot(centroid(2),centroid(2),'wO');
      case 0.5
          plot(centroid(1),centroid(2),'wX');
      case 1
          plot(centroid(1),centroid(2),'wS');
  end
end