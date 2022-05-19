import numpy as np

C = np.array([(3,1.6,1.2),(1.6,12.4,9.9),(1.2,9.9,14.4)])
V = np.array([(-0.095,-0.669,-0.737),(-0.421,-0.644,0.639)]).transpose()
final = C.dot(V)
print(final)