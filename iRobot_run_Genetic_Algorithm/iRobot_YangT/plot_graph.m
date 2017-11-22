Frontcords = zeros(1,3);
Leftcords = zeros(1,3);
Rightcords = zeros(1,3);
figure;
hold on;
for right=[0 0.1 0.2 0.4 0.8 1.6 3]
    for front=[0 0.1 0.2 0.4 0.8 1.6 3] 
        for left=[0 0.1 0.2 0.4 0.8 1.6 3]
            [status,term_out] = system(['swipl -s plscript.pl ',num2str(left),' ',num2str(front),' ',num2str(right)])
            wheels_speeds =  str2num(term_out);
            if abs(wheels_speeds(2)-wheels_speeds(1))< 0.05
                Frontcords = [Frontcords;right front left];
            elseif wheels_speeds(2) > wheels_speeds(1)
                Leftcords = [Leftcords;right front left];
            else
                Rightcords = [Rightcords;right front left];
            end
        end
    end
end
stem3(Frontcords(:,1),Frontcords(:,2),Frontcords(:,3),'filled','Color','g');
stem3(Leftcords(:,1),Leftcords(:,2),Leftcords(:,3),'filled','Color','r');
stem3(Rightcords(:,1),Rightcords(:,2),Rightcords(:,3),'filled','Color','b');
xlabel('Left')                                                      
ylabel('Front') 
zlabel('Right') 
legend('Foward', 'Left', 'Right')
hold off;