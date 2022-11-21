clear all;
c0 = physconst('LightSpeed');
lengthstr = 10; %[um] length of waveguide
widthWG = 1; %[um] width WG
hightWG = 1; %[um] hight WG
sim1 = LumericalConnection('version', 'v222'); % initialization of simulation
sim1.AddRect( ... % add rectangl (it will be WG)
    'x span', 10, 'y span', 1, 'z span', 1, ... % set size of WG
    'x', 0, 'y', 0, 'z', 0, ... % set position of WG
    'material', 'Si (Silicon) - Palik'); % set material from standart base
sim1.AddVarFDTD('x span', 10, 'y span', 10, 'z span', 10, ...  % add solver
    'x', 0, 'y', 0, 'z', 0); 
comand = {'select("varFDTD");', ...  % example how to send random scrypt (select solver and set time)
    ['set("simulation time", ' num2str(lengthstr*1e-6/c0 * 4 ) ')']};% example how to send random scrypt
sim1.SendComand(comand{:});% example how to send random scrypt (send scrypt)
sim1.AddSource('x', -4, 'y', 0, ... % add source
    'y span', 3, 'wavelength start', 1.5e-6, 'wavelength stop', 1.6e-6);
sim1.AddPower('name', 'm1','monitor type', 5, ... % add power monitor with name m1
    'x', 4, 'y', 0, 'y span', 3);
sim1.AddPower('name', 'm2', 'monitor type', 7, ... % add power monitor with name m2
    'x', 0, 'y', 0,'z', 0, 'y span', 3,'x span', 8);
sim1.Save('Example.lms') % save file
sim1.Run(); % run simulation
T = sim1.GetTransmitance('m1'); % get transmittance from monitor m1
E = sim1.GetEField('m2'); % get electrical field from monitor m2
sim1.AppClose(); % close app
%%%%%%%%%%%% plot data %%%%%%%%%%%%%%%%%%
tiledlayout(2,1)
% Transmittance
nexttile
plot(T(:,2),T(:,1));
xlabel('lambda, um');
ylabel('T');
title('Plot 1')
% Electrical field
nexttile
[X, Y] = meshgrid(E.X, E.Y);
mesh(X', Y', real(E.E(:,:,1,2,2)));
xlabel('X, um');
ylabel('Y, um');
zlabel('Re(Ey)');
title('Plot 2');