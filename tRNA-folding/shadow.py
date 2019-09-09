#!/usr/bin/python
import numpy as np
from math import floor as floor

ipfilename=raw_input('Enter the PDB filename: ') or 'tmp.pdb'
strradius=raw_input('Enter the radius of the molecule:') or 50.0
namesuffix=raw_input('Enter the suffix for the output file:') or 'out'

opfilename='MaxCsection'+namesuffix+'.xvg'
radius=float(strradius)

xll=50.0-radius
xul=50.0+radius
yll=xll
yul=xul

zll=100.0-100.0
zul=100.0+100.0

xbinsize=5.0
xbins=int((xul-xll)/xbinsize)
ybinsize=5.0
ybins=int((yul-yll)/ybinsize)
zbinsize=5.0
zbins=int((zul-zll)/zbinsize)



##xindex=range(xll,xul,xbinsize)
##yindex=range(yll,yul,ybinsize)
##zindex=range(zll,zul,zbinsize)


##mesh=np.zeros(len(xindex),len(yindex),len(zindex))

##for i in range(0,len(xindex)):
##	for j in range(0,len(yindex)):
##		for k in range(0,len(zindex)):
##			mesh(i,j,k)=

##curmesh=np.zeros((len(xindex),len(yindex),len(zindex)), dtype=bool)
##curmesh=np.zeros((xbins,ybins,zbins),dtype=bool)
output=open(opfilename,'w')
curtime=0.0;
curmesh=np.zeros((xbins,ybins,zbins))
zarea=np.zeros(zbins)
with open(ipfilename,'r') as f:
	for line in f:
		line.rstrip('\n')
		if line[0:5] == 'TITLE':
			curtime=float(line[26:])
		if line[0:4] == 'ATOM':
			xcur=float(line[30:38])
			ycur=float(line[38:46])
			zcur=float(line[46:54])
			xindex=int(floor((xcur-xll)/xbinsize))
			yindex=int(floor((ycur-yll)/ybinsize))
			zindex=int(floor((zcur-zll)/zbinsize))
			##curmesh[xindex,yindex,zindex]= (TRUE or curmesh[xindex,yindex,zindex])
			if curmesh[xindex,yindex,zindex]!=1:
				curmesh[xindex,yindex,zindex]=1
		if line[0:3] == 'TER':
			#print curmesh
			for i in range(0,len(zarea)):
				zarea[i]=np.sum(curmesh[...,...,i])
				##output.write("%i " % (zarea[i]))##Remove this
			##output.write("\n")
			#output.write(curtime,' ',np.amax(zarea),'\n')
			output.write("%f %f\n" % (curtime, np.amax(zarea) ))
			##curmesh=np.zeros((xbins,ybins,zbins))
			curmesh[...,...,...]=0
			zarea=np.zeros(zbins)

output.close()
			
