iverilog -Wall -s MD_Run -o md.run ../*.v run.v
vvp md.run