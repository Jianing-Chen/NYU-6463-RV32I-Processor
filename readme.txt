Group 4: 
 
Siyuan Huang
Jianing Chen
Shihao Wang

To run the processor, you need to load instruction.mem with binaries of all instruction you need and fill every other line with 0s, if you need some preloaded data memory, load it in DMEM_1 and gave a proper tag and valid bit in DMEM_2. 
Then start the simulation, and setup a clock, set the rst with 0 to reset it. After a period (20 ns), set rst into 1 to start the processor. 

One of the complex program is RC5 encoder. It uses skeys that need to be preloaded into data memory and set the array in the instuction. 
After running the encoder, the result is inside the regfile. 
The second complex program is bit reverser, it reverse the sequency of the bit and output. 

In the folder, the RISC_V.srcs contains all the files, inside this folder, the testbenches are inside sim_1 and clock constaints is inside constrs_1, the main files are located inside sim_1. 
nyu_processor is the link connects datapath and controller. Under the datapath, the rest of the components are under datapath file. 
