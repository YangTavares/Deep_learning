

population_size = 100;
path_size = 10;
%Start point coordinates
start_x = 3;
start_y = 3;
%End point
desired_x = -3;
desired_y = -3;
%survive rate for next generation
keep_alive = 90;
%Number of generations
epoch = 10;
%Mutation chance for each node
mutation_chance = 0.0005; %For each point in the path
%creates population
population = generate_population(start_x,start_y,population_size,path_size);
%Evaluates population fitness
fitness = get_fitness(desired_x,desired_y,population_size,path_size,population);

%Starts the evolution 8)
%organizes best fitness specimen
[out,id_ranking]=sort(fitness);
%Just to initialize variable
next_gen = population;

for j = 1:epoch

    %Selection and reproduction
    %Elite selection
    for i = 1:keep_alive
        next_gen{i} = population{id_ranking(i)}; 
    end
    for i = (keep_alive+1):population_size
        next_gen{i} = cross_over(population,fitness,path_size);
    end
    %Mutation
    next_gen = mutate_population(next_gen,population_size,path_size,mutation_chance);
    
    fitness = get_fitness(desired_x,desired_y,population_size,path_size,next_gen);
    mean(fitness)
    [out,id_ranking]=sort(fitness);
    population = next_gen;
end
save('demo','population','fitness');

