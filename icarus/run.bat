iverilog -Wall -s MD_Run -o md.run ../*.v memstubs.v run.v
vvp md.run