function profilePlot( nVec, runTimeFor, runTimeParfor, funcStr, ...
  numWorkers, numIterations )
  titlelstr1 = [ funcStr ' Run time' ];
  titlelstr2 = [ ' numWorker: ' num2str( numWorkers ) ...
    ' numLoops:' num2str(numIterations) ];
  figure()
  subplot(1,2,1)
  plot( nVec, runTimeFor, nVec, runTimeParfor );
  title( titlelstr1 )
  xlabel('nVec'); ylabel('time');
  legend( 'trad for', 'parfor', 'location','best' )
  subplot(1,2,2)
  loglog( nVec, runTimeFor, nVec, runTimeParfor );
  title( titlelstr2 )
  xlabel('nVec'); ylabel('time');
end
