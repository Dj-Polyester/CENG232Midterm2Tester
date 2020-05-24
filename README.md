# CENG232Midterm2Tester
A tester for CENG232 Midterm 2 of the second semester 2020.
This is the latest recommended version. If you have any opinions open an issue (or you can dm me), 
if you want to contribute, send a pr.

# Remark (For top module only)
**1) Copy the commented lines**

I could not manage to access the variables inside the `top` (*All variables of modules used inside*) module, therefore before using the testbench for the `top` module, you are advised to *manually copy paste* the commented lines for the testbench to work.
**2) Modify the KEYCHANGE_VALUE**

Furthermore, please modify the **KEYCHANGE_VALUE** in the `rtcClkDivider` module. For the testbench I recommend 0.5 (Recommended minimum value for the midterm), but you can set whatever you want. 5 is a huge value that you may not see the changes of the display.

**3)Beware of the periods**

In some testbenches, you realize that `#period;` written once. Indeed, `#period` is half-a-period. 