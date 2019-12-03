%  author: Yuxiong Zou
%  Visualization of superquadratic particles for LIGGGHTS-3.8.0
function plot_superquadratic_particles(file,num_point_surf,color_coding);
%  Where the 'file' defines the dump file path of liggghts, 
%  the 'num_point_surf' means the number of points on particle's surface,
%  and the 'color_coding' defines modifier assigning colors to particles.


readfile = fopen(file,'r+');
for i = 1:9;
    tline = fgetl(readfile);
end
table_name = strsplit(tline,' ');
color_index = find(strcmp(table_name,color_coding) == 1 ) - 2;
position_index = find(strcmp(table_name,'x') == 1 ) - 2;
shape_index = find(strcmp(table_name,'shapex') == 1 ) - 2;
quat_index = find(strcmp(table_name,'quat1') == 1 ) - 2;
blockiness_index = find(strcmp(table_name,'blockiness1') == 1 ) - 2;
ffid = textread(file,'','headerlines',9);
for i = 1:length(ffid);
    position = ffid(i,position_index :(position_index+2));
    color = ffid(i,color_index);
    shape = ffid(i,shape_index :(shape_index+2));
    quat = ffid(i,quat_index :(quat_index+3));
    blockiness = ffid(i,blockiness_index :(blockiness_index+1));
    [yaw,pitch,roll] = quat2angle(quat);
    [x y z] = superquadric(position, shape ,blockiness ,num_point_surf);
    C = zeros(num_point_surf,num_point_surf) + color;
    h = surf(x,y,z,C);
    rotate(h,[1,0,0],yaw*180/pi,position);
    rotate(h,[0,1,0],pitch*180/pi,position);
    rotate(h,[0,0,1],roll*180/pi,position);
    hold on
end
view([150,50]),shading interp
light,lighting phong
axis equal
material dull
set(gca,'Projection','perspective')
end