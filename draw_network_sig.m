% Function that draws a "ball-and-stick" (brain) network plot
% "significant" nodes have alpha = 1 (no transparency), "non-significant" nodes have alpha = 0.X
% Three angles are plotted: axial, saggital, coronal
%
% NOTE: Parameters for exporting of figures are hard-coded and might need to be adjusted
%
% mat               connectivity matrix (or 0 for a plot without edges)
% coords            coordinates of each nodes in 3D
% node_size         parameter to specify size of nodes (absolute values are used)
% node_size_tune    parameter that tunes the size of nodes
% node_sig          is node "significant"? 1 = yes, 0 = no
% node_cmap         node colormap
% node_cmap_cent    should node colormap be centered at 0? (1 = yes, 0 = no)
% savefig           if figure is to be saved, provide path (if not, set savefig = 0)
%
% Frantisek Vasa (based on function by Petra E. Vertes)

% On scaling of node size in the "scatter" function (used below and needed to make nodes transparent), 
% to match node size generated by draw_network.m and draw_network_edgecol.m functions, which use the faster "plot" function:
% (from https://uk.mathworks.com/matlabcentral/answers/454164-marker-size-difference-between-plot-and-scatter-function)
% "Per the documentation, scatter marker size property is marker proportional to area while the line marker property is proportional to [radius].  
% The default values are 36 and 6 points, respectively, so they are the same visually by default.  
% Use squared value of radius for line marker as area for scatter and they'll stay the same."

function draw_network_sig(mat,coords,node_size,node_size_tune,node_sig,node_cmap,node_cmap_cent,savefig)

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

% transparency for (non)significant nodes
node_alpha = node_sig*1+(~node_sig)*0.2;

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
    %plot(coords(i,1),coords(i,2),'o','MarkerSize',ceil(3+abs(node_size(i))*node_size_tune),'MarkerEdgeColor','k','MarkerFaceColor',node_cmap(y(i),:));
    if node_sig(i); edge_col = 'k'; else edge_col = [0.75 0.75 0.75]; end
    scatter(coords(i,1),coords(i,2),(ceil(3+abs(node_size(i))*node_size_tune))^2,'MarkerEdgeColor',edge_col,'MarkerFaceColor',node_cmap(y(i),:),'MarkerFaceAlpha',node_alpha(i));
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
    %plot(coords(i,2),coords(i,3),'o','MarkerSize',ceil(3+abs(node_size(i))*node_size_tune),'MarkerEdgeColor','k','MarkerFaceColor',node_cmap(y(i),:));
    if node_sig(i); edge_col = 'k'; else edge_col = [0.75 0.75 0.75]; end
    scatter(coords(i,2),coords(i,3),(ceil(3+abs(node_size(i))*node_size_tune))^2,'MarkerEdgeColor',edge_col,'MarkerFaceColor',node_cmap(y(i),:),'MarkerFaceAlpha',node_alpha(i));
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
    %plot(coords(i,1),coords(i,3),'o','MarkerSize',ceil(3+abs(node_size(i))*node_size_tune),'MarkerEdgeColor','k','MarkerFaceColor',node_cmap(y(i),:));
    if node_sig(i); edge_col = 'k'; else edge_col = [0.75 0.75 0.75]; end
    scatter(coords(i,1),coords(i,3),(ceil(3+abs(node_size(i))*node_size_tune))^2,'MarkerEdgeColor',edge_col,'MarkerFaceColor',node_cmap(y(i),:),'MarkerFaceAlpha',node_alpha(i));
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

