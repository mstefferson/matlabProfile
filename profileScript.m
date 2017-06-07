function profileScript( comp, numWorkers, plotTimes  )
% hard code things to test
nVec = [8 16 32 64 138 256 512 1024];
% function to test: 1) sum 2) max 3) multiply 4) eig 5) fft
numIterations = 1000000;
% make outputs if it doesn't exist
if ~exist('outputs','dir'); mkdir( 'outputs'); end
for ii = 1:5
  functionId = ii;
  [out] = profileParfor( nVec, functionId, numWorkers, numIterations, plotTimes );
  saveStr = [ 'profile_' out.funcStr '_' comp '_nWork' num2str(out.numWorkers) ...
   '_numIt' num2str(numIterations,'%g') '_coresAvail' num2str(out.maxLogicalCores) ...
   '_threadsAvial' num2str(out.maxThreads) ];
  save( saveStr, 'out' )
  movefile( [saveStr '.mat'] , 'outputs/' );
end
end
