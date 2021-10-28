

S=dir('nodes*dyadmatrix*.csv');

namelist = struct('name', {S(:).name});

for h=1:length(namelist)
temp = erase(namelist(h).name,".csv")
namelist(h).name = temp
end




for dat=1:length(S);

DATAFR = readtable(S(dat).name);

CON=table2array(DATAFR(:,1:2));
M=table2array(DATAFR(:,2)),
mx=max(M);

for j=1:25
J(j) = CON(j,2);
end

figure('Renderer', 'opengl', 'Position', [10 10 600 400]);topoplot(J,'cleanchan.ced','electrodes','labelpoint','headcolor','none');
set(gcf,'color','none')
colormap(zissou)
colorbar
caxis([0 mx])
axis off

name = namelist(dat).name
name = sprintf('%s.pdf', name)

orient(gcf,'landscape')
print(gcf, name, '-bestfit','-dpdf')

end

close all