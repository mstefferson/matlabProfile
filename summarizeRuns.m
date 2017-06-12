function summarizeRuns(saveFlag)
if nargin == 0
  saveFlag = 0;
end
% cells
compList = {'propagandhi','nofx', 'summit'};
funcList = {'sum','max','mult','eig','fft','find'};
% compare comprs vs N
plotCompsCmprVsNvec( compList, funcList, saveFlag )
% compare comprs vs cores
plotCompsCmprVsCore( compList, funcList, saveFlag )
% compare comprs
plotCompsCmprFixedCore( compList, funcList, saveFlag )
if saveFlag
  if ~exist('figs','dir'); mkdir('figs'); end
  movefile('*.fig', 'figs')
end
end

