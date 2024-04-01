#!/bin/sh

kicad-cli pcb export svg --exclude-drawing-sheet -m -o ./Docs/Generated/PCB_Front.svg -l F.Cu,F.Fab,F.Silkscreen,F.Courtyard "./PCB Design/Vending_Machine.kicad_pcb"
kicad-cli pcb export svg --exclude-drawing-sheet -m -o ./Docs/Generated/PCB_Back.svg  -l B.Cu,B.Fab,B.Silkscreen,B.Courtyard "./PCB Design/Vending_Machine.kicad_pcb"