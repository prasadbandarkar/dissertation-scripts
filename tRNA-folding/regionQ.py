
regfilename=input("Enter the region list file: ")

with open(regfilename) as freg:
    line=freg.readline()
    line=line.strip().split(sep=' ')
    regA=frozenset(int(i) for i in line)
    line=freg.readline()
    line=line.strip().split(sep=' ')
    regB=frozenset(int(i) for i in line)

mapfilename=input("Enter the atom to residue contact list file: ")

maplist=[]
#mapdict={}
mapset=set()

with open(mapfilename) as mpf:
    for line in mpf:
        temp=line.strip().split(sep=' ')
        temp=[int(i) for i in temp ]
        #print(temp[2],temp[3])
        maplist.append(temp)
        if (  ( (temp[2] in regA ) and ( temp[3] in regB ) ) or
             ( (temp[2] in regB ) and ( temp[3] in regA ) )  ):
            #mapdict[(temp[0],temp[1])]=(temp[2],temp[3])
            mapset.add((temp[0],temp[1]))

#print(len(mapset))
maxQ=float(len(mapset))

AAQfilename=input("Enter the .AA.Q filename: ")
AAQifilename=input("Enter the .AA.Qi filename: ")
opregfile=input("Enter the output file name: ")

with open(AAQfilename,'r') as fhAAQ, \
     open(AAQifilename,'r') as fhAAQi, \
     open(opregfile,'w') as fhop :
    for lineAAQ in fhAAQ:
        lineAAQ=int(lineAAQ.strip())
        count=0
        for i in range(lineAAQ):
            lAAQi=int(next(fhAAQi))
            if (maplist[lAAQi-1][0],maplist[lAAQi-1][1]) in mapset:
                count+=1
        fhop.write(str(count/maxQ)+' '+str(count)+'\n')

