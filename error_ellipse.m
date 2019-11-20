function [] = error_ellipse(covariance, color)
%This function computes for a given covariance matrix an error ellipse. The 
%error ellipse represents the region that contains 95% of all samples that 
%can be drawn from the underlying covarying Gaussian distribution. The code
%was inspiried from:
%https://www.visiondummy.com/2014/04/draw-error-ellipse-representing-covariance-matrix/#source_code
%Accesed: 28.10.2019
%
% Arguments:
% -COVARIANCE - double array; covaraince matrix
% -COLOR - double array; color of the displayed scatter plots. 
%     
% Returns:
% figure plot
%
% Dependencies: 
% -NONE
%
% Licence: CC-BY
% 
% Jona Carmon & Yujiang Wang, October 2019 
% Newcastle University, School of Computing, CNNP Lab (www.cnnp-lab.com)



[eigenvec, eigenval ] = eig(covariance);

%get the index of the largest eigenvector
[largest_eigenvec_ind_c, ~] = find(eigenval == max(max(eigenval)));

%get the lagrest eigen vector 
largest_eigenvec = eigenvec(:, largest_eigenvec_ind_c);

%get the largest eigenvalue
largest_eigenval = max(max(eigenval));

%get the smallest eigenvector and eigenvalue
if(largest_eigenvec_ind_c == 1)
    smallest_eigenval = max(eigenval(:,2));
    smallest_eigenvec = eigenvec(:,2);
else
    smallest_eigenval = max(eigenval(:,1));
    smallest_eigenvec = eigenvec(1,:);
end

%calculate the angle between the x-axis and the largest eigenvector
angle = atan2(largest_eigenvec(2), largest_eigenvec(1));

%this angle is between -pi and pi.
%let's shift it such that the angle is between 0 and 2pi
if(angle < 0)
    angle = angle + 2*pi;
end

%get the coordinates of the data mean
%set 0 for our purpose
avg = [0,0];

%get the 95% confidence interval error ellipse
chisquare_val = 2.4477;
theta_grid = linspace(0,2*pi);
phi = angle;
X0=avg(1);
Y0=avg(2);
a=chisquare_val*sqrt(largest_eigenval);
b=chisquare_val*sqrt(smallest_eigenval);

%the ellipse in x and y coordinates 
ellipse_x_r  = a*cos( theta_grid );
ellipse_y_r  = b*sin( theta_grid );

%define a rotation matrix
R = [ cos(phi) sin(phi); -sin(phi) cos(phi) ];

%let's rotate the ellipse to some angle phi
r_ellipse = [ellipse_x_r;ellipse_y_r]' * R;

%draw the error ellipse
plot(r_ellipse(:,1) + X0,r_ellipse(:,2) + Y0,'-','LineWidth',1.8,'Color',color)

end

