#log files
LOGFILEBCD = b16toBCD.log
LOGFILERTC = rtcClkDivider.log
LOGFILEFSM = buttonFsm.log
LOGFILETIME = timekeeper.log
LOGFILEHASH = hasher.log
LOGFILETOP = top.log
#executable names
BCD = bcd
RTCLK = rtclk
FSM = fsm
TIME = time
HASH = hash
TOP = top
#Please write the file name you want to compile (without extension)
COMPILE ?= top
#exec (true-false)
EXEC = true

all: deletelog clean $(COMPILE) exec

#COMPILE
buttonFsm:
	iverilog buttonFsm.v buttonFsm_tb.v -o $(FSM)

b16toBCD:
	iverilog b16toBCD.v b16toBCD_tb.v -o $(BCD)

rtcClkDivider:
	iverilog rtcClkDivider.v rtcClkDivider_tb.v -o $(RTCLK)

timekeeper:
	iverilog timekeeper.v timekeeper_tb.v -o $(TIME)

hasher:
	iverilog hasher.v hasher_tb.v -o $(HASH)

top:
	iverilog b16toBCD.v rtcClkDivider.v buttonFsm.v timekeeper.v hasher.v top.v top_tb.v -o $(TOP)

var%:
	echo $@

#EXEC
exec:
ifeq ($(COMPILE), b16toBCD)
	./$(BCD)
else ifeq ($(COMPILE), buttonFsm)
	./$(FSM)
else ifeq ($(COMPILE), rtcClkDivider)
	./$(RTCLK)
else ifeq ($(COMPILE), timekeeper)
	./$(TIME)
else ifeq ($(COMPILE), hasher)
	./$(HASH)
else ifeq ($(COMPILE), top)
	./$(TOP)
else 
	echo "Cannot find make $(COMPILE)"
endif

#CLEAN
clean: 
	rm -f $(RTCLK)
	rm -f $(BCD)
	rm -f $(FSM)
	rm -f $(TIME)
	rm -f $(HASH)
	rm -f $(TOP)
	clear
#DELETE LOG FILES
deletelog:
	@if test -e $(LOGFILEBCD); then rm -i $(LOGFILEBCD);fi
	@if test -e $(LOGFILERTC); then rm -i $(LOGFILERTC);fi
	@if test -e $(LOGFILEFSM); then rm -i $(LOGFILEFSM);fi
	@if test -e $(LOGFILETIME); then rm -i $(LOGFILETIME);fi
	@if test -e $(LOGFILEHASH); then rm -i $(LOGFILEHASH);fi
	@if test -e $(LOGFILETOP); then rm -i $(LOGFILETOP);fi
