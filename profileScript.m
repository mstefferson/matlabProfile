nVec = [8 16 32 64 138 256 512 1024];
comp = 'propagandhi';
% function to test: 1) sum 2) max 3) multiply 4) eig 5) fft
functionId = 1;
numWorkers = 8;
numIterations = 1000000;
plotTimes = 1;
for ii = 1:5
  functionId = ii;
  [out] = profileParfor( nVec, functionId, numWorkers, numIterations, plotTimes );
  saveStr = [ 'profile_' out.funcStr '_' comp '_nWork' num2str(out.numWorkers) ...
   '_numIt' num2str(numIterations,'%g') '_coresAvail' num2str(out.maxLogicalCores) ...
   '_threadsAvial' num2str(out.maxThreads) ];
  save( saveStr, 'out' )
  movefile( [saveStr '.mat'] , 'outputs/' );
end
