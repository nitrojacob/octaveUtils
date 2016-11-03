%Swiss Army Knife of data normalisation.
% method can be from {'max', 'mean', 'xcorr', 'absmax'}
function [result] = sak_normalise(rawData, method = 'max')
  [nRows, nCols] = size(rawData);
  switch method
    case 'max'
      offset      = zeros(1, nCols);
      scaleFactor = max(abs(rawData), [], 1);
    case 'mean'
      offset      = zeros(1, nCols);
      scaleFactor = mean(abs(rawData), 1);
    case 'xcorr'
      offset      = mean(rawData, 1);
      scaleFactor = max(rawData, [], 1) - min(rawData, [], 1);
    otherwise
      offset      = zeros(1, nCols);
      scaleFactor = max(abs(rawData), [], 1);
  end
  result = (rawData .- repmat(offset, nRows, 1)) ./ repmat(scaleFactor, nRows, 1);
end
