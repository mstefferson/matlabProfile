function plotCompsCmprVsCore( compList, funcList, saveFlag )
% lengths
numComps = length( compList );
numFunctions = length( funcList );
% set up figure
figure()
legendCell = cell( 1, 2*numComps );
for ii = 1:numFunctions
  subplot(2,3,ii);
  hold all
  titleStr = [ funcList{ii}];
  % get number of cores you tried
  for jj = 1:numComps
    fileId = [funcList{ii} '*' compList{jj} '*' ];
    filesList = dir(['./outputs/*' fileId]);
    numCores = length( filesList );
    % load and store data
    coreNum = zeros( numCores, 1 );
    dataVsCoreFor = zeros( numCores, 1 );
    dataVsCoreParfor = zeros( numCores, 1 );
    % grab data
    for kk = 1:numCores
      load( ['outputs/' filesList(kk).name] );
      dataVsCoreFor(kk) = out.runTimeFor(end);
      dataVsCoreParfor(kk) = out.runTimeParfor(end);
      coreNum(kk) = out.numWorkers;
    end
    % plot it
    plot( coreNum, dataVsCoreFor, '-', coreNum, dataVsCoreParfor, '--' );
    legendCell{ 2*(jj-1) + 1} = [ 'for ' compList{jj}(1:4) ];
    legendCell{ 2*(jj-1) + 2} = [ 'parfor ' compList{jj}(1:4) ];
  end
  title( titleStr );
  xlabel('Cores'); ylabel('runTime');
  leg = legend(legendCell,'location','best');
  leg.FontSize = 10;
end
% save it
if saveFlag
  saveName = 'comprCores_';
  savefig( gcf, saveName );
end
end

