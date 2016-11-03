%Computes the index of specified string in the specified cell array of strings
%  idx:Int = indexof(name: string, nameList: cellArray)
%     Returns a single integer indicating row where name is found in nameList
%  idx:[Int] = indexof(name: cellArray, nameList: cellArray)
%     Returns a row vector where each element indicates the row in nameList
%     where correspondng element of name{} was found.

function idx = indexof(name, nameList)
  if(strcmp(typeinfo(name), 'cell') == 1)
    [nRow, nCol] = size(name);
    idx = zeros(1, nRow);
    for row = 1:nRow
      %idx(row) = find(strncmp(name{row, 1}, nameList, length(name{row, 1})));
      idx(row) = find(strcmp(name{row, 1}, nameList));
    endfor
  else
    idx = find(strncmp(name, nameList, length(name)));
  end
endfunction
