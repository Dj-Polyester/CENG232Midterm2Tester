# CENG232Midterm2Tester
A tester for CENG232 Midterm 2 of the second semester 2020.
This is the latest recommended version. If you have any opinions open an issue (or you can dm me), 
if you want to contribute, send a pr.

Test it *fast*
```
chmod +x test
./test
```
Or you can use makefile. Just type `make`.

## Remarks

**1) Copy the commented lines**

I could not manage to access the variables inside the `top` (*All variables of modules used inside*) module, therefore before using the testbench for the `top` module, you are advised to *manually copy paste* the commented lines for the testbench to work.

**2) Modify the KEYCHANGE_VALUE**

Furthermore, please modify the **KEYCHANGE_VALUE** in the `rtcClkDivider` module. For the testbench I recommend ~~0.5~~ *0.001* or less (Smaller than the recommended minimum value for the midterm 0.5, but makes changes observable), but you can set whatever you want. 5 is a huge value that you may not see the changes of the display.

**3)Beware of the periods**

In some testbenches, you notice that `#period;` written once. Indeed, `#period` is half-a-period. 

**UPDATE**

25/05/2020: 
*buttonFsm_tb is updated. It simulates bouncing.
*top.log is updated, timekeeper updates every N seconds
*top_tb.v is updated. Unnecessary variable button_out is out

