onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+RiscV_BD -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.RiscV_BD xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {RiscV_BD.udo}

run -all

endsim

quit -force
