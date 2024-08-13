function irf = impulse_response(h)
  t = 0:0.01:1;
  u = ones(size(t));
  y = h(t) .* u;
  irf = y;
end