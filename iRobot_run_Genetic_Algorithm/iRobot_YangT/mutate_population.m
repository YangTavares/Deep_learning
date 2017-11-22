function [ mutated_population ] = mutate_population( population,population_size,path_size,mutation_chance )
%MUTATE_POPULATION Summary of this function goes here
%   Detailed explanation goes here
    next_gen = population;
    for j = 1:population_size
        for i = 1:path_size
            r_num = rand;
            valid_before = 0;
            valid_after = 0;
            if r_num < mutation_chance
                while valid_before == 0 || valid_after == 0
                    mutation_x = rand*8 -4;
                    mutation_y = rand*8 -4;
                    %Searches for last position
                    %First position doesnt change
                    if i < path_size
                        valid_before = valid_point(next_gen{1}(i,1,:), next_gen{1}(i,2,:),mutation_x,mutation_y);
                        valid_after = valid_point(mutation_x,mutation_y,next_gen{1}(i+2,1,:), next_gen{1}(i+2,2,:));
                        if valid_before == 1 && valid_after == 1
                            next_gen{1}(i+1,:) = [mutation_x mutation_y];
                        end
                    else
                        valid_before = valid_point(next_gen{1}(i,1,:), next_gen{1}(i,2,:),mutation_x,mutation_y);
                        if valid_before == 1
                            next_gen{1}(i+1,:) = [mutation_x mutation_y];
                        end
                        %To make possible the exit of the while loop
                        valid_after = 1;
                    end
                end
            end
        end
    end
    mutated_population = next_gen;
end

