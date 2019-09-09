import pandas as pd
import numpy as np

contRes=pd.read_csv("reslist", delim_whitespace=True,header=None)



resmap=pd.read_csv("resmap",header=None,squeeze=True)

conts=pd.read_csv("arg.cont",header=None,delim_whitespace=True)

##conts.reindex(resmap)

##conts['4']=contRes.iloc[resmap.iloc[conts[0]-1]+1]

conts['4']= resmap


#conts['5']= contRes.iloc[conts['4']-1,:]

conts['5']=contRes.loc[conts['4']-1,:].loc[:,0]

print(conts.head())

#print(contRes.loc[conts['4']-1,:])


