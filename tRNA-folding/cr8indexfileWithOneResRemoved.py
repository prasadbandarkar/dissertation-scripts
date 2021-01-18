import re
import sys

#print(sys.argv)

topfilename=sys.argv[1]
atom2Residue={}



with open(topfilename,'r') as top:
    for line in top:
        #line=next(top)
        line=line.strip()
        if re.search(r'^\[\s*atoms\s*\]',line):
            line=next(top).strip()
            while line :
                if re.search(r'^;',line):
                    line=next(top).strip()
                    continue
                atomLine=line.strip().split()
                atom2Residue[int(atomLine[0])]=int(atomLine[2])
                line=next(top).strip()



#residues= [ resNo for atom,resNo in atom2Residue.items() ]
#print(f"Total Residues = {max(residues)}")
#atoms=[ atom for atom,resNo in atom2Residue.items()]
#print(f"Total atoms={max(atoms)}")

residue2Atom={}
atoms=[]
residues=[]
for atom,resNo in atom2Residue.items():
    atoms.append(atom) #List of Atoms
    residues.append(resNo) #List of Residues, Not unique
    if resNo in residue2Atom.keys():
        residue2Atom[resNo].append(atom)
    else:
        residue2Atom[resNo]=[atom]

with open(f"{topfilename}.ndx",'w') as ndxfile:
    ndxfile.write("[ system ]\n")
    ndxfile.writelines( f"{i+1}\n" for i in range(max(atoms))  )
    #ndxfile.write("\n")

    for res in range(max(residues)):
        ndxfile.write(f"\n[ {res+1} ]\n")
        ndxfile.writelines( f"{i}\n" for i in residue2Atom[res+1] )
