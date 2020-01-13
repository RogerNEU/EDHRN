#!/bin/csh -f


echo Processing YZ dimensions
xyz2pipe -in ./rec_FID.dat                                  \
| nmrPipe  -fn TP -auto                             \
#| nmrPipe  -fn LP -fb -pred 20                     \
| nmrPipe  -fn SP -off 0.48 -end 0.95 -pow 2 -c 0.5 \
| nmrPipe  -fn ZF -auto		                        \
| nmrPipe  -fn FT                                   \
| nmrPipe  -fn PS -hdr                              \
| nmrPipe  -fn PS -p0 0.0 -p1 -0.0 -di              \
| nmrPipe  -fn TP  -auto                            \
| nmrPipe  -fn ZTP                                  \
#| nmrPipe  -fn LP -fb -pred 64                     \
| nmrPipe  -fn SP -off 0.48 -end 0.95 -pow 2 -c 0.5 \
| nmrPipe  -fn ZF -auto			                    \
| nmrPipe  -fn FT                                   \
| nmrPipe  -fn PS -hdr                              \
| nmrPipe  -fn PS -p0  0.0 -p1 0 -di                \
| nmrPipe  -fn ZTP                                  \
| pipe2xyz -out rec.ft -x -verb -ov
proj3D.tcl -in ./rec.ft -abs

exit
    
