function plotCompsCmprVsNvec( compList, funcList, saveFlag )
% lengths
numComps = length( compList );
numFunctions = length( funcList );
% plot all the routines for every computer separately
for ii = 1:numComps
  % set up figure
  figure()
  % get number of cores you tried
  for jj = 1:numFunctions
    fileId = [funcList{jj} '*' compList{ii} '*' ];
    fileList = dir(['./outputs/*' fileId]);
    num2plot = length( fileList );
    subplot(2,3,jj);
    hold all
    titleStr = [ compList{ii} ' ' funcList{jj}];
    legendCell = cell( 1, 2*num2plot );
    colorArray = viridis(num2plot);
    for kk = 1:num2plot
      load( ['outputs/' fileList(kk).name] );
      p = plot( out.nVec, out.runTimeFor, '-', ...
        out.nVec, out.runTimeParfor, '--'  );
      p(1).Color = colorArray(kk,:);
      p(2).Color = colorArray(kk,:);
      legendCell{ 2*(kk-1) + 1} = [ 'for W = ' num2str( out.numWorkers ) ];
      legendCell{ 2*(kk-1) + 2} = [ 'parfor W = ' num2str( out.numWorkers ) ];
    end
    ax = gca;
    ax.XLim = [0 max( out.nVec )];
    title( titleStr );
    xlabel('N'); ylabel('runTime');
    leg = legend(legendCell,'location','best');
    leg.FontSize = 10;
  end
  % save it
  if saveFlag
    saveName = [ 'comprNvec_' compList{ii} ];
    savefig( gcf, saveName );
  end
end
end

