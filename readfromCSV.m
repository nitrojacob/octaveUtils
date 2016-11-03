%Parses 'filename' as a CSV file, and returns numerical data, the row headers
%and the column headers.
%
%  nSkipRow : # rows to be skipped before start of numerical data.
%  nSkipCol : # cols to be skipped before start of numerical data.
%  headerCol: not full working yet. If >0 value supplied, the headerCol
%             is assumed to be 1; else an empty cell array is returned
%  headerRow: if >0, used to find the row in which header is present
%             else assumes col header is absent and reutrns empty cell array
function [rawData, rowHeader, colHeader]=readfromCSV(filename, nSkipRow, nSkipCol, headerRow, headerCol)
  %Read Data
  %---------
  rawData = dlmread(filename, ',', nSkipRow, nSkipCol);   %Indexed from zero hence +1 not needed
  [nRows, nCols] = size(rawData);
  
  %Read Headers
  %------------
  allLines = textread(filename, "%s", nRows+nSkipRow, "delimiter", "\n");

  if(headerRow > 0)
    augmentedColHeader = regexp(allLines{headerRow}, '([^,]*)',"match");
    nHeaderCols = length(augmentedColHeader);
    if(nHeaderCols != nCols)
      disp('[readfromCSV] WARNING: Column header not matching table size');
    end
    colHeader = augmentedColHeader(1:min(nCols, nHeaderCols));
  else
    colHeader = cell(0,0);
  end
  
  if(headerCol > 0)
    for idx = 1:nRows
      candidateRowHeader = regexp(allLines{idx+nSkipRow}, '^[^,]+',"match");
      if(isempty(candidateRowHeader))
        disp('[readfromCSV] WARNING: Row Header not matching table size');
      else
        rowHeader(idx, 1) = candidateRowHeader;
      end
    endfor
  else
    rowHeader = cell(0,0);
  end
end
