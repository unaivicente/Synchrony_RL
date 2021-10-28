EEG = pop_loadset('filename','03262019_1659_S1_R.set','filepath','/Volumes/GoogleDrive/My Drive/Doctorado Social Neuroscience/Exp 1 - Social Conformity/Results/EEG Data/');


S=dir('lines*dyadmatrix*.csv');

namelist = struct('name', {S(:).name});

for h=1:length(namelist)
temp = erase(namelist(h).name,".csv")
namelist(h).name = temp
end;

%colors
COL = [1,1,2,2,2,2,2,3,3,3,3,4,4,4,5,5,5,5,6,6,6,6,6,7,8];
COL2 = ["#3B9AB2"; "#5DAABC"; "#88BAAE"; "#CAC656"; "#E8C31E"; "#E2B306"; "#E86F00"; "#F21A00"];


for dat=1:length(S)

DATAFR = readtable(S(dat).name);

CON2=table2array(DATAFR(:,1:2));

k=1;
for i=1:30;
    if (i~=28 && i~=2 && i~=30 && i~=13 && i~=17) ;
        X(k)=-EEG.chanlocs(i).Y;
        Y(k)=EEG.chanlocs(i).X;
        k=k+1;
    end;
end

figure('Renderer', 'painters', 'Position', [10 10 1000 500]);
hold on;

%S=dir('*.set');

for i=1:size(CON2,1);

LC = COL(CON2(i))
l=line([X(CON2(i,1)) X(CON2(i,2))+250],[Y(CON2(i,1)) Y(CON2(i,2))],'LineWidth',2,'Color',COL2(LC));l.Color(4)=0.7;
%l=line([X(CON2(i,1)) X(CON2(i,2))+250],[Y(CON2(i,1)) Y(CON2(i,2))],'LineWidth',2,'Color',"#3B9AB2");l.Color(4)=0.7;

end;

%head 1 inner layer
r=91;x=0;y=0;
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
plot(xunit, yunit,'Color','k','LineWidth',2);


%head 2 inner layer
r=91;x=250;y=0;
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
plot(xunit, yunit,'Color','k','LineWidth',2);


%'#f9edcc'
plot(X,Y,'o','LineWidth',2,'Color','k','MarkerFaceColor','k');
plot(X+250,Y,'o','LineWidth',2,'Color','k','MarkerFaceColor','k');
axis off;

name = namelist(dat).name;
name = sprintf('%s.pdf', name);

orient(gcf,'landscape')
print(gcf, name, '-bestfit','-dpdf')

end;

close all
