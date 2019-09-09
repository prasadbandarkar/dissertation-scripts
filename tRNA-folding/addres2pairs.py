atomsfile=input("Enter the atoms section of the top file: ")

resdict={}

with open(atomsfile,'r') as atFh:
    for line in atFh:
        line=line.strip().split()
        resdict[line[0]]=line[2]

pairsfilename=input("Enter the pairs section of the top file:")

opfilename=input("Enter the name of the output file:")

with open(pairsfilename,'r') as pairsFh, \
    open (opfilename,'w') as opFh:
    for line in pairsFh:
        linesp=line.strip().split()
        opFh.write(line.strip() +' '+ str(resdict[linesp[0]]) + ' ' +str(resdict[linesp[1]] + '\n')  )
