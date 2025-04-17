using StructuralIdentifiability 

ode = @ODEmodel(
  x1'(t) = theta1*x1(t)^2-theta2*x1(t)^3-theta3*x1(t)*x2(t)+9.99995*x1(t)^2*x2(t)+theta0-thetaA*x2(t)^3+thetaB*x1(t)*x2(t)^2,
  x2'(t) = theta5*x1(t)^2-theta6*x2(t)^2-thetaC*x1(t)^3+thetaD*x1(t)*x2(t),
  y1(t) = x1(t)
)

res = assess_identifiability(ode)

print(res)
