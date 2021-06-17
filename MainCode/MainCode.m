clear
clc
close all

carL=5;
lane_length = 6000; %车道长度,m
lane_number = 2; %车道数量
v_max = 33; %最大车速,m/s
time_max = 100; %仿真时间.s
time_span = 0.1; %图片输出步长,s
p_slowdown = 0.2; %随机慢化概率
gama = 0.8; %伽马，车辆容忍跟驰速度与期望速度的比值；车辆产生换道意图的因素；
max_car_number = lane_length*lane_number/carL; %车辆总数
max_platoon = 10; %最大队列
car1_rate = 0.5;

car_rate_temp = [ 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 ]; %车辆密度
AV_rate_temp = [ 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 ]; %汇入率

for e = 1:length(car_rate_temp)
    
    car_rate = car_rate_temp(e); %车辆密度
    total_car = floor(car_rate*max_car_number); %当前密度下车辆总数
    total_car_line1 = floor(total_car*car1_rate); %当前密度下车道一车辆总数
    total_car_line2 = total_car - total_car_line1; %当前密度下车道二车辆总数
    
    for y = 1:length(AV_rate_temp)
        
        AV_rate = AV_rate_temp(y); %AV汇入率
        line1_AV = round(total_car_line1*AV_rate); %车道1上AV车辆数
        line2_AV = round(total_car_line2*AV_rate); %车道2上AV车辆数
        line1_HV = total_car_line1-line1_AV; %车道1上HV车辆数
        line2_HV = total_car_line2-line2_AV; %车道2上HV车辆数
        line1_temp = randerr(1,max_car_number,total_car_line1);%车道1上随机生成车辆位置，有车的地方是1
        line2_temp = randerr(1,max_car_number,total_car_line2);%车道2上随机生成车辆位置，有车的地方是1
        line1_car_location = (find(line1_temp==1)*5);%车道1上每辆车辆的车头位置
        line2_car_location = (find(line2_temp==1)*5);%车道2上每辆车辆的车头位置
        line1_car_type = randerr(1,total_car_line1,line1_HV);%在车道1的所有车中随机挑选位置，赋值1 给HV，则AV为0
        line2_car_type = randerr(1,total_car_line2,line2_HV);%在车道2的所有车中随机挑选位置，赋值1 给HV，则AV为0
        
        for id = 1:length(line1_temp)
            if line1_car_type == 1
                
                carone.t(id) = 1;
                carone.s(id) = line1_car_location(id);
                carone.v(id) = randi(0,v_max);
                
            elseif line1_car_type == 0
                
                carone.t(id) = 2;
                carone.s(id) = line1_car_location(id);
                carone.v(id) = randi(0,v_max);
            end
        end
        for id = 1:length(line2_temp)
            if line2_car_type == 1
                carone.t(id) = 1;
                carone.s(id) = line2_car_location(id);
                carone.v(id) = randi(0,v_max);
                
            elseif line1_car_type == 0
                
                carone.t(id) = 2;
                carone.s(id) = line2_car_location(id);
                carone.v(id) = randi(0,v_max);
            end
        end
                
%%%生成车道一初始信息%%%


%%%生成车道二初始信息%%%






    end
end




