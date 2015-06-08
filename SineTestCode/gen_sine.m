%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% gen_sine.m
%
% Generate a 1kHz sine wave with
% 48 points (for 48kHz sample rate)
% with different amplitudes
%
% Use sine wave so that we start
% at 0, and don't send a step function
% to the speaker
%
% Copyright (c) 2015 RF William Hollender, whollender@gmail.com
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

freq = 1e3;
num_samp = 48;
samp_rate = 48e3;

bit_depth = 24;

log_amp = -1;

lin_amp = 10^(log_amp/20);

t = 0:(num_samp-1);

t = t/samp_rate;

x = lin_amp * sin(2*pi*freq*t);

scale_factor = 2^(bit_depth - 1) - 1;

output_samples = round(scale_factor*x);

filename = 'sine_samples.h';
outp_file = fopen(filename,'wt');


% Print header info
fprintf(outp_file,'/************************************************************************\n');
fprintf(outp_file,'* sine_samples.h                                                         \n');
fprintf(outp_file,'*                                                                        \n');
fprintf(outp_file,'* Header file containing samples for sine wave output. Generated by      \n');
fprintf(outp_file,'* MATLAB/Octave script gen_sine.m                                        \n');
fprintf(outp_file,'*     -- William Hollender                                               \n');
fprintf(outp_file,'************************************************************************/\n');
fprintf(outp_file,'\n\n');
fprintf(outp_file,'#define SIG_LENGTH %d\n', num_samp);
fprintf(outp_file,'const int32_t out_buf[SIG_LENGTH] = {'); 



% Output the actual samples
for i=1:num_samp
    fprintf(outp_file,'%d',output_samples(i));
    if(i < length(output_samples))
        fprintf(outp_file,',');
    endif
    if(mod(i,16) == 0)
        fprintf(outp_file,'\n                               ');
    endif
endfor
fprintf(outp_file,'};\n\n');


fclose(outp_file);
