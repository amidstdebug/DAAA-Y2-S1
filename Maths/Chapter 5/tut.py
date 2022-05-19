from sklearn.decomposition import PCA
import pandas as pd
import numpy as np

data = pd.read_csv(r'Tut51Q3.csv',header=None)
data = np.array(data[1],data[1])
print(data)
pca = PCA(n_components=2).fit(data)

pca_coords_centere,d = pca.transform(data)