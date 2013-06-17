
rem Clean up the results directory
rmdir /S /Q results
mkdir results

echo 'Synthesizing example design with XST';
xst -ifn xst.scr
copy /B emac_single_example_design.ngc .\results\

echo 'Copying files from constraints directory to results directory'
copy /B ..\example_design\emac_single_example_design.ucf results\

cd results

echo 'Running ngdbuild'
ngdbuild -uc emac_single_example_design.ucf emac_single_example_design.ngc emac_single_example_design.ngd

echo 'Running map'
map -ol high -timing emac_single_example_design -o mapped.ncd

echo 'Running par'
par -ol high mapped.ncd routed.ncd mapped.pcf

echo 'Running trce'
trce -e 10 routed -o routed mapped.pcf

echo 'Running design through bitgen'
bitgen -w routed routed mapped.pcf

echo 'Running netgen to create gate level Verilog model'
netgen -ofmt verilog -sim -dir . -pcf mapped.pcf -tm emac_single_example_design -w -sdf_anno false routed.ncd routed.v
