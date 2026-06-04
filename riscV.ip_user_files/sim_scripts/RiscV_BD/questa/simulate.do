onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib RiscV_BD_opt

do {wave.do}

view wave
view structure
view signals

do {RiscV_BD.udo}

run -all

quit -force
