
Comp1 = guitar_seg + bass_seg;
Comp2 = guitar_seg + bass_seg + battement_seg;

% Weighted composition
alpha = 0.5; beta = 0.3; delta = 0.7;
Comp3 = alpha*guitar_seg + beta*bass_seg + delta*battement_seg;

% Listen to the results
sound(Comp1, fs); pause(6);
sound(Comp2, fs); pause(6);
sound(Comp3, fs);
