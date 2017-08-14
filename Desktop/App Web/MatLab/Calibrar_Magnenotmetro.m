% Graficar los datos del magnetometro con y sin calibración
datamag=datamag1; %Nombre de matriz del último archivo, asignar vectoresa a partir de matriz 
magx=datamag(:,1);
magy=datamag(:,2);
magz=datamag(:,3);
m=size(datamag); % número de interaciones igual tamañno de muestrasa
n=m(1);
magx_reading=zeros(n,1); %crear variable que guarde los datos corregidos sin iron error
magy_reading=zeros(n,1);
magz_reading=zeros(n,1);
maxx=max(magx); %calcular minimos y máximos 
minx=min(magx);
maxy=max(magy);
miny=min(magy);
maxz=max(magz);
minz=min(magy);

figure(1)
%plot
for i=1:n
hold on 
plot(magx(i),magy(i),'or',magx(i),magz(i),'+b',magy(i),magz(i),'*m');
magx_reading(i)=magx(i)-(maxx+minx)/2; % Every time you take a reading from your magnetometers, you should subtract this offset from each axis.
magy_reading(i)=magy(i)-(maxy+miny)/2;
magz_reading(i)=magz(i)-(maxz+minz)/2;
end 
legend('Mxy','Mxz','Myz')
title('Datos sin Calibrar')
axis([-900 500 -800 600])

% These minimum and maximum vectors are the same as the ones being used to correct for hard iron errors.
mag_scale=zeros(1,3); vmin=zeros(1,3); avg=zeros(1,3);
mag_scale(1)=(-minx+maxx)/2;
mag_scale(2)=(-miny+maxy)/2;
mag_scale(3)=(-minz+maxz)/2;
vmin(1)=minx-(minx+maxx)/2;
vmin(2)=miny-(miny+maxy)/2;
vmin(3)=minz-(minz+maxz)/2;



avg_rad = (mag_scale(1)+mag_scale(2)+mag_scale(3))/3;
x_scale = avg_rad/mag_scale(1);
y_scale = avg_rad/mag_scale(2);
z_scale = avg_rad/mag_scale(3);

magx_reading = magx_reading * x_scale;
magy_reading = magy_reading * y_scale; 
magz_reading = magz_reading * z_scale; 

figure(2)
for i=1:n
hold on 
plot(magx_reading(i),magy_reading(i),'or',magx_reading(i),magz_reading(i),'+b',magy_reading(i),magz_reading(i),'*m');
end 
legend('Mxy','Mxz','Myz')
title('Datos Calibrados')
axis([-900 500 -800 600])
