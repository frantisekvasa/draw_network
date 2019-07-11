% Function that draws a "ball-and-stick" (brain) network plot
% Edges are colored and their size scaled
% Three angles are plotted: axial, saggital, coronal
%
% NOTE: Parameters for exporting of figures are hard-coded and might need to be adjusted
%
% mat               connectivity matrix
% coords            coordinates of each nodes in 3D
% node_size         parameter to specify size of nodes (absolute values are used)
% node_size_tune    parameter that tunes the size of nodes
% node_cmap         node colormap
% node_cmap_cent    should node colormap be centered at 0? (1 = yes, 0 = no)
% edge_cmap         edge colormap
% edge_cmap_cent    should edge colormap be centered at 0? (1 = yes, 0 = no)
% edge_size_tune    parameter that tunes the size of edges (based on mat)
% savefig           if figure is to be saved, provide path (if not, set savefig = 0)
%
% Frantisek Vasa (based on function by Petra E. Vertes)

function draw_network_edgecol(mat,coords,node_size,node_size_tune,node_cmap,node_cmap_cent,edge_cmap,edge_cmap_cent,edge_size_tune,savefig)

warning('off','MATLAB:print:FigureTooLargeForPage') % turn annoying print warning off

% find the start and end coordinates of each edge that needs to be plotted
row = [];
col = [];
data = [];
n = size(mat,1);
ind = 0;
for i=1:n
    for j=i:n
        if mat(i,j)~=0
            ind=ind+1;
            row(ind) = i; % track locations
            col(ind) = j;
            data(ind) = mat(i,j);
            X(:,ind)=[coords(i,1);coords(j,1)];
            Y(:,ind)=[coords(i,2);coords(j,2)];
            Z(:,ind)=[coords(i,3);coords(j,3)];
        end
    end
end

% colormap for node plots
x = node_size; % data to be plotted
if node_cmap_cent
    min_val = -max(abs(x)); max_val = max(abs(x));
else
    min_val = min(x); max_val = max(x);
end
y = floor(((x-min_val)/(max_val-min_val))*(length(node_cmap)-1))+1;

% colormap for edge plots
x = data; % data to be plotted
if edge_cmap_cent
    min_val = -max(abs(x)); max_val = max(abs(x));
else
    min_val = min(x); max_val = max(x);
end
ye = floor(((x-min_val)/(max_val-min_val))*(length(edge_cmap)-1))+1;

%% axial

figure; set(gcf,'Position', [200, 200, 760, 760]);

% plotting edges one by one
for i=1:size(X,2) 
plot(X(:,i),Y(:,i),'LineWidth',abs(mat(row(i),col(i)))^edge_size_tune,'Color',edge_cmap(ye(i),:))
hold on
end

% plotting nodes one by one
hold on
for i=1:n 
     plot(coords(i,1),coords(i,2),'o','MarkerSize',ceil(3+abs(node_size(i))*node_size_tune),'MarkerEdgeColor','k','MarkerFaceColor',node_cmap(y(i),:));
end
axis off
set(gcf,'color','w');
pos = get(gcf,'Position'); set(gcf,'Position', [pos(1) pos(2) 0.75*pos(3) pos(4)]);

if savefig
    pos = get(gcf,'Position');
    set(gcf,'PaperSize',[pos(3) pos(4)]/80,'PaperUnits','centimeters');
    print([savefig '_axial'],'-dpdf'); 
end

%% saggital

figure; set(gcf,'Position', [200, 200, 760, 620]);

% plotting edges one by one
for i=1:size(X,2) 
plot(Y(:,i),Z(:,i),'LineWidth',abs(mat(row(i),col(i)))^edge_size_tune,'Color',edge_cmap(ye(i),:))
hold on
end

% plotting nodes one by one
hold on
for i=1:n 
     plot(coords(i,2),coords(i,3),'o','MarkerSize',ceil(3+abs(node_size(i))*node_size_tune),'MarkerEdgeColor','k','MarkerFaceColor',node_cmap(y(i),:));
end
axis off
set(gcf,'color','w');
pos = get(gcf,'Position'); set(gcf,'Position', [pos(1) pos(2) pos(3) 0.75*pos(4)]);

if savefig
    pos = get(gcf,'Position');
    set(gcf,'PaperSize',[pos(3) pos(4)]/80,'PaperUnits','centimeters');
    print([savefig '_saggital'],'-dpdf'); 
end

%% coronal

figure; set(gcf,'Position', [200, 200, 760, 620]);

% plotting edges one by one
for i=1:size(X,2) 
plot(X(:,i),Z(:,i),'LineWidth',abs(mat(row(i),col(i)))^edge_size_tune,'Color',edge_cmap(ye(i),:))
hold on
end

% plotting nodes one by one
hold on
for i=1:n 
     plot(coords(i,1),coords(i,3),'o','MarkerSize',ceil(3+abs(node_size(i))*node_size_tune),'MarkerEdgeColor','k','MarkerFaceColor',node_cmap(y(i),:));
end
axis off
set(gcf,'color','w');

if savefig
    pos = get(gcf,'Position');
    set(gcf,'PaperSize',[pos(3) pos(4)]/80,'PaperUnits','centimeters');
    print([savefig '_coronal'],'-dpdf'); 
end

warning('on','MATLAB:print:FigureTooLargeForPage') % turn warning back on

