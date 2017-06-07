%% matlab profiling on local
% function to test: 1) sum 2) max 3) multiply 4) eig 5) fft
function [out] = ...
  profileParfor( nVec, functionId, numWorkers, numIterations, plotTimes )
% some parameter stuff
numN = length(nVec);
runTimeFor = zeros( numN, 1 );
runTimeParfor =  zeros( numN, 1 );
functionCell = {'sum','max','mult','eig','fft'};
funcStr = functionCell{functionId};
% start pool
maxLogicalCores = feature('numcores');
maxThreads = feature('numthreads');
poolObj = gcp('nocreate');
if isempty(poolObj)
  poolObj = parpool( min(numWorkers,maxLogicalCores) );
elseif poolObj.NumWorkers ~= min(numWorkers, maxLogicalCores)
    delete(poolObj);
    poolObj = parpool( min(numWorkers,maxLogicalCores) );
end
% get workers
numWorkers = poolObj.NumWorkers;
% loop over n
for nn = 1:numN
  A = rand( nVec(nn) );
  tic
  for ii = numIterations
    functionMaster(functionId,A);
  end
  tRun = toc;
  runTimeFor(nn) = tRun;
  tic
  parfor ii = numIterations
    functionMaster(functionId,A);
  end
  tRun = toc;
  runTimeFor(nn) = tRun;
  runTimeParfor(nn) = toc;
end
% plotting
if plotTimes
  profilePlot( nVec, runTimeFor, runTimeParfor, funcStr, ...
    numWorkers, numIterations )
end
% store
out.nVec = nVec;
out.numWorkers = numWorkers;
out.funcStr = funcStr;
out.maxLogicalCores = maxLogicalCores ;
out.maxThreads = maxThreads;
out.runTimeFor = runTimeFor;
out.runTimeParfor = runTimeParfor;
%
end % profileParfor

function B = functionMaster(functionId, A)
%
if functionId == 1
  B = A + A;
elseif functionId == 2
  B = max(A(:));
elseif functionId == 3
  B = A * A;
elseif functionId == 4
  B = eig(A);
elseif functionId == 5
  B = fftn(A);
else
  error('Invalid function ID');
end
%
end
