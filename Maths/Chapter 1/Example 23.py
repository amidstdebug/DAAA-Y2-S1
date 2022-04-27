import numpy as np

# Taking a 3 * 3 matrix
A = np.array([[5,-14,2],
              [-10,-5,-10],
              [10,2,-11]])

# Calculating the inverse of the matrix
print(np.dot(A,np.transpose(A)))
