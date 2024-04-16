function [x_trim] = remove(x, i)
    x_trim = x;
    x_trim(i) = [];
end