% Function that draws a "ball-and-stick" (brain) network plot
% Three angles are plotted: axial, saggital, coronal
%
% NOTE: Parameters for exporting of figures are hard-coded and might need to be adjusted
%
% mat               connectivity matrix (or 0 for a plot without edges)
% coords            coordinates of each nodes in 3D
% node_size         parameter to specify size of nodes (absolute values are used)
% node_size_tune    parameter that tunes the size of nodes
% node_cmap         node colormap
% node_cmap_cent    should node colormap be centered at 0? (1 = yes, 0 = no)
% savefig           if figure is to be saved, provide path (if not, set savefig = 0)
%
% Frantisek Vasa (based on function by Petra E. Vertes)

function draw_network(mat,coords,node_size,node_size_tune,node_cmap,node_cmap_cent,savefig)

warning('off','MATLAB:print:FigureTooLargeForPage') % turn annoying print warning off

% find the coordinates of each edge that needs to be plotted
if any(mat(:))
    n=size(mat,1);
    ind=0;
    for i=1:n
        for j=i:n
            if mat(i,j)~=0
                ind=ind+1;
                X(:,ind)=[coords(i,1);coords(j,1)];
                Y(:,ind)=[coords(i,2);coords(j,2)];
                Z(:,ind)=[coords(i,3);coords(j,3)];
            end
        end
    end
else
    n = size(coords,1);
end

% colormap for node plots
x = node_size; % data to be plotted
if node_cmap_cent
    min_val = -max(abs(x)); max_val = max(abs(x));
else
    min_val = min(x); max_val = max(x);
end
y = floor(((x-min_val)/(max_val-min_val))*(length(node_cmap)-1))+1;

%% axial

figure; set(gcf,'Position', [200, 200, 760, 760]);

% plotting edges one by one
if any(mat(:))
    for i=1:size(X,2)
        plot(X(:,i),Y(:,i),'LineWidth',1,'Color',[0.2 0.2 0.2])
        hold on
    end
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
if any(mat(:))
    for i=1:size(X,2)
        plot(Y(:,i),Z(:,i),'LineWidth',1,'Color',[0.2 0.2 0.2])
        hold on
    end
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
if any(mat(:))
    for i=1:size(X,2)
        plot(X(:,i),Z(:,i),'LineWidth',1,'Color',[0.2 0.2 0.2])
        hold on
    end
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

%% plot colormap

% node
f = figure; set(gcf,'color','w'); ax = axes;
colormap(node_cmap); c = colorbar(ax); ax.Visible = 'off'; c.FontSize = 16;
c.Ticks = [0,0.5,1]; c.TickLabels = round([min_val,(min_val+max_val)/2,max_val],2); 
c_pos = get(c,'position'); set(c,'position',[c_pos(1)/1.85 c_pos(2)+c_pos(4)/6 c_pos(3) c_pos(4)/1.5]) % position arguments are [xposition yposition width height].
f.Units = 'normalized'; f.Position = [c_pos(1)/1.8-3*c_pos(3) c_pos(2)/3 8*c_pos(3) c_pos(4)/1.5];
c.AxisLocationMode = 'manual'; c.AxisLocation = 'in';
if savefig
    pos = get(gcf,'Position');
    set(gcf,'PaperSize',[8*pos(3) 10*pos(4)],'PaperUnits','centimeters');
    print([savefig '_colormap_node'],'-dpdf'); 
end

warning('on','MATLAB:print:FigureTooLargeForPage') % turn warning back on

