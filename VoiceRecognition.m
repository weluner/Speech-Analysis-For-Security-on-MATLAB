clear all
close all
clc;


%1st recording, 1 second
recorderSystem = audiorecorder(16000,16,1);
disp("Please record your voice for 1 sec to train the system.");
pause(1)
disp("now")
recordblocking(recorderSystem, 1);

%FFT for 1st recording
systemSound = getaudiodata(recorderSystem);
systemSound = fft(systemSound);

%2nd recording, 1 second
userSound=audiorecorder(16000,16,1);
disp("Please record your voice for 1 sec to access the system.");
pause(1)
disp("now")
recordblocking(userSound, 1);

%FFT for 2nd recording
userSound = getaudiodata(userSound);
userSound = fft(userSound);

%Correlation
correlated = xcorr(systemSound,userSound);

%To make time axis 0 centered
lengthCorr = length(correlated);
time = -((lengthCorr-1)/2):1:((lengthCorr-1)/2);


%An equation about when the xcorr reaches its maximum
maxT = time(find(correlated==max(correlated)))/1000;
disp(maxT);


%Plot to see real and imaginary parts of correlated FFT signals
plot3(time, real(correlated), imag(correlated))

%Plot lables
xlabel("time")
ylabel("real xcorr")
zlabel("imaginary xcorr");
annotation('textbox', [0, 0.5, 0, 0], 'string', maxT)



%Final display functions
if  0.02 >= abs(maxT)
    title("Welcome!");
else
    title("Access denied.");

end
%You can change the tolerance value if needed
