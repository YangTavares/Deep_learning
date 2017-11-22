function [ value ] = valid_point( start_x, start_y, move_x, move_y )
%VALID_POINT Summary of this function goes here
%   Detailed explanation goes here
walls = fopen('test_GA.txt','r');
line = 'clan';
while ~feof(walls)
    line = fgetl(walls);
    spl = strsplit(line);
    if strcmp(spl(1),'wall')
        wx1 = cellfun(@str2num,spl(2));
        wy1 = cellfun(@str2num,spl(3));
        wx2 = cellfun(@str2num,spl(4));
        wy2 = cellfun(@str2num,spl(5));
        %line
        %[start_x,start_y,move_x,move_y]
        %Robot margin from center
        rm = 0.2;
        valid_flag = lines_intersect(start_x,start_y,move_x,move_y,wx1,wy1,wx2,wy2);
        %Avoid the robot of hitting a wall
        valid_flag = valid_flag | lines_intersect(start_x,start_y,move_x,move_y,wx1+rm,wy1,wx2+rm,wy2);
        valid_flag = valid_flag | lines_intersect(start_x,start_y,move_x,move_y,wx1-rm,wy1,wx2-rm,wy2);
        valid_flag = valid_flag | lines_intersect(start_x,start_y,move_x,move_y,wx1,wy1+rm,wx2,wy2+rm);
        valid_flag = valid_flag | lines_intersect(start_x,start_y,move_x,move_y,wx1,wy1-rm,wx2,wy2-rm);
        if valid_flag == 1
            value = 0;
            fclose(walls);
            return
        end
    end
end
fclose(walls);
value = 1;
end

