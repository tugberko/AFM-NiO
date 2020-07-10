#!/usr/bin/python
import math

file=open("data")
file1=open("diffdata","w")
count=0

while True: 
    count+=1
    line = file.readline()  
    if not line:
        break
    line = line.split(" ")
    print(line[0])
    print(line[3])
    if(count==1):
        tmp = line[3]
        continue
    file1.write("%s " % (line[0]))
    F=math.log(abs(-float(line[3])+float(tmp)),10)
    file1.write("%f\n" % (F))
    tmp = line[3]
    print("Line{}: {}".format(count, line))

file.close()
file1.close()
