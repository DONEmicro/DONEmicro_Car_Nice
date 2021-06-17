clear
clc
close all

carL=5;
lane_length = 6000; %��������,m
lane_number = 2; %��������
v_max = 33; %�����,m/s
time_max = 100; %����ʱ��.s
time_span = 0.1; %ͼƬ�������,s
p_slowdown = 0.2; %�����������
gama = 0.8; %٤���������̸����ٶ��������ٶȵı�ֵ����������������ͼ�����أ�
max_car_number = lane_length*lane_number/carL; %��������
max_platoon = 10; %������
car1_rate = 0.5;

car_rate_temp = [ 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 ]; %�����ܶ�
AV_rate_temp = [ 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 ]; %������

for e = 1:length(car_rate_temp)
    
    car_rate = car_rate_temp(e); %�����ܶ�
    total_car = floor(car_rate*max_car_number); %��ǰ�ܶ��³�������
    total_car_line1 = floor(total_car*car1_rate); %��ǰ�ܶ��³���һ��������
    total_car_line2 = total_car - total_car_line1; %��ǰ�ܶ��³�������������
    
    for y = 1:length(AV_rate_temp)
        
        AV_rate = AV_rate_temp(y); %AV������
        line1_AV = round(total_car_line1*AV_rate); %����1��AV������
        line2_AV = round(total_car_line2*AV_rate); %����2��AV������
        line1_HV = total_car_line1-line1_AV; %����1��HV������
        line2_HV = total_car_line2-line2_AV; %����2��HV������
        line1_temp = randerr(1,max_car_number,total_car_line1);%����1��������ɳ���λ�ã��г��ĵط���1
        line2_temp = randerr(1,max_car_number,total_car_line2);%����2��������ɳ���λ�ã��г��ĵط���1
        line1_car_location = (find(line1_temp==1)*5);%����1��ÿ�������ĳ�ͷλ��
        line2_car_location = (find(line2_temp==1)*5);%����2��ÿ�������ĳ�ͷλ��
        line1_car_type = randerr(1,total_car_line1,line1_HV);%�ڳ���1�����г��������ѡλ�ã���ֵ1 ��HV����AVΪ0
        line2_car_type = randerr(1,total_car_line2,line2_HV);%�ڳ���2�����г��������ѡλ�ã���ֵ1 ��HV����AVΪ0
        
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
                
%%%���ɳ���һ��ʼ��Ϣ%%%


%%%���ɳ�������ʼ��Ϣ%%%






    end
end




