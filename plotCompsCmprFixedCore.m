function plotCompsCmprFixedCore( compList, funcList, saveFlag )
% lengths
numComps = length( compList );
numFunctions = length( funcList );
% allocate
dataVsCoreFor = zeros( numComps, 1 );
% set up figure
figure()
% shorten name for bar graph
tempName = cell(numComps,1);
for ii = 1:numComps
  tempName{ii} = compList{ii}(1:4);
end
c = categorical( tempName );
numWorkers = 1;
for ii = 1:numFunctions
  subplot(2,3,ii);
  titleStr = funcList{ii};
  % get number of cores you tried
  for jj = 1:numComps
    % load and store data
    fileId = [funcList{ii} '*' compList{jj} ...
      '*nWork' num2str( numWorkers,'%.2d' ) '*' ];
    file = dir(['./outputs/*' fileId]);
    load( ['outputs/' file.name] );
    dataVsCoreFor(jj) = out.runTimeFor(end);
  end
  % plot it
  bar( c, dataVsCoreFor );
  title( titleStr );
  ylabel('runTime');
end
% save it
if saveFlag
  saveName = 'comprCompsSingCore_' ;
  savefig( gcf, saveName );
end
end

