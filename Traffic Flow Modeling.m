% Monte Carlo Simulation for Traffic Flow

% Parameters
road_ln = 1;                   % Length of the highway section (km)
max_veh = 50;                  % Maximum vehicle capacity on the highway
arr_rate = 20;                 % Average vehicle arrivals per minute (Poisson)
mean_spd = 100;                % Mean vehicle speed (km/h)
std_spd = 15;                  % Standard deviation of vehicle speeds (km/h)
n = 1000;                      % Monte Carlo simulations

% Initialize arrays to store results
avg_spd = zeros(1, n);
traffic_flows = zeros(1, n);

for i = 1:n
    % Generate number of vehicles arriving (Poisson)
    num_veh = poissrnd(arr_rate);
    num_veh = min(num_veh, max_veh); % Cap at road capacity

    if num_veh > 0
        % Assign random speeds to vehicles (Normal distribution)
        speeds = normrnd(mean_spd, std_spd, [1, num_veh]);
        speeds = max(speeds, 0); % Ensure no negative speeds

        % Compute average speed and traffic flow
        avg_spd(i) = mean(speeds);
        traffic_flows(i) = num_veh * avg_spd(i) / road_ln;
    else
        avg_spd(i) = 0;
        traffic_flows(i) = 0;
    end
end

% Results
overall_avg_speed = mean(avg_spd);
overall_flow = mean(traffic_flows);

% Display Results
disp(['Monte Carlo - Average Speed: ', num2str(overall_avg_speed), ' km/h']);
disp(['Monte Carlo - Average Flow: ', num2str(overall_flow), ' vehicles/hour']);

% Visualization
figure;

% Speed Distribution
subplot(2, 1, 1);
histogram(avg_spd, 'Normalization', 'probability', 'FaceColor', 'b');
title('Monte Carlo: Speed Distribution');
xlabel('Speed (km/h)');
ylabel('Probability');

% Traffic Flow Distribution
subplot(2, 1, 2);
histogram(traffic_flows, 'Normalization', 'probability', 'FaceColor', 'r');
title('Monte Carlo: Flow Distribution');
xlabel('Flow (vehicles/hour)');
ylabel('Probability');