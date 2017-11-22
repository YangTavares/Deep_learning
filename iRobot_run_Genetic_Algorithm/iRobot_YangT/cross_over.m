function [ cross_over_result ] = cross_over( population_input, fitness_input, path_size )
%CROSS_OVER Summary of this function goes here
%   Detailed explanation goes here
        
    population = population_input;
    fitness = fitness_input;

    valid_cross = 0;
    while valid_cross == 0
        s1 = select_specimen(fitness);
        s2 = s1;
        debug_count = 5;
        %Avoid same paths
        while s2 == s1 && debug_count > 1
            debug_count = debug_count - 1;
            s2 = select_specimen(fitness);
        end
        if debug_count == 0
            %Needs to check if its the last position
            s2 = s1+1;
        end

        div_point = round(rand*(path_size-1) + 1);

        s1x = population{s1}(div_point,1,:);
        s1y = population{s1}(div_point,2,:);
        s2x = population{s2}(div_point+1,1,:);
        s2y = population{s2}(div_point+1,2,:);

        valid_cross = valid_point(s1x,s1y,s2x,s2y);
    end
    cross_over_result = [population{s1}([1:div_point],:) ; population{s2}([div_point+1:path_size+1],:)];

end

