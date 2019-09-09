#!/home/prasadb/miniconda3/bin/python3

##import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.cm as mycm
from sys import argv 
from os import getcwd

fstring=str(str(getcwd())+'/'+str(argv[1]))

regnames=['ach','asl','dloop','tloop','varloop']


coldict={v:k for k,v in enumerate(regnames)  }


arr = np.loadtxt(str(fstring+'regQ'),delimiter=' ')
arr = arr[:,0:]

fig,axes = plt.subplots(len(regnames),len(regnames),sharex='col',sharey='row')

for yl in coldict.keys():
    yaxis=str(yl)
    for xl in coldict.keys():

        xaxis=str(xl)

        xarray=arr[:,coldict[xaxis]]
        yarray=arr[:,coldict[yaxis]]
        #print(xaxis +' '+ yaxis+' '+str(max(xarray)) +' '+str(max(yarray)))
        xbins=np.arange(0,max(xarray)+2,2)
        ybins=np.arange(0,max(yarray)+2,2)
        
        mat,xedges,yedges=np.histogram2d(xarray,yarray,bins=np.array([xbins,ybins]))
        #print(str(np.shape(mat)))
        hlogplot = -1*np.log(mat)
        hlogplot[hlogplot==np.inf]=np.nan

        current_cmap= mycm.get_cmap()
        current_cmap.set_bad(color='white')

        
        axes[coldict[yaxis],coldict[xaxis]].set_xlabel(xaxis)
        axes[coldict[yaxis],coldict[xaxis]].set_ylabel(yaxis)
        axes[coldict[yaxis],coldict[xaxis]].set_xticks(xedges)
        axes[coldict[yaxis],coldict[xaxis]].set_yticks(yedges)

        
        im=axes[coldict[yaxis],coldict[xaxis]].imshow(hlogplot.transpose(),aspect='auto',vmin=-8.0,vmax=0.0)
        plt.colorbar(im,ax=axes[coldict[yaxis],coldict[xaxis]])
    #axes[coldict[yaxis],coldict[xaxis]].set_xlabel(xaxis)
    #axes[coldict[yaxis],coldict[xaxis]].set_ylabel(yaxis)
    #print(xaxis +' '+ yaxis+' '+str(max(xarray)) +' '+str(max(yarray)))

    #print(str(np.shape(mat)))

fig.tight_layout(pad=-0.5)
fig.subplots_adjust(top=0.9,wspace=0.1)
fig.suptitle('No ions temp='+str(argv[1]),fontsize=12)
#mng=plt.get_current_fig_manager()
#mng.window.showMaximized()
fig.set_figheight(9.0)
fig.set_figwidth(16.0)

fig.savefig(str(fstring+'histmat.png'),dpi=300,format='png')
fig.savefig(str(fstring+'histmat.pdf'),dpi=300,format='pdf')
fig.savefig(str(fstring+'histmat.svg'),dpi=300,format='svg')
plt.clf()

#plt.show()
