set nFiber 5;
set db 65.0;                       # [mm] Ancho de fibra del elemento de borde
set dw 206.66667;                   # [mm] Ancho de fibra del elemento central

#element MEFISection  $eleTag  $iNode  $jNode  $kNode  $lNode  $m -width {Widths} -section {Section_tags} 
element MEFISection 1 1 2 5 4      $nFiber -width $db $db $dw $dw $dw -section 30 30 31 31 31; #izq
element MEFISection 2 2 3 6 5      $nFiber -width $dw $dw $dw $db $db -section 31 31 31 30 30; #der
element MEFISection 3 4 5 8 7      $nFiber -width $db $db $dw $dw $dw -section 30 30 31 31 31; #izq
element MEFISection 4 5 6 9 8      $nFiber -width $dw $dw $dw $db $db -section 31 31 31 30 30; #der
element MEFISection 5 7 8 11 10    $nFiber -width $db $db $dw $dw $dw -section 30 30 31 31 31; #izq
element MEFISection 6 8 9 12 11    $nFiber -width $dw $dw $dw $db $db -section 31 31 31 30 30; #der
element MEFISection 7 10 11 14 13  $nFiber -width $db $db $dw $dw $dw -section 30 30 31 31 31; #izq
element MEFISection 8 11 12 15 14  $nFiber -width $dw $dw $dw $db $db -section 31 31 31 30 30; #der
element MEFISection 9 13 14 17 16  $nFiber -width $db $db $dw $dw $dw -section 30 30 31 31 31; #izq
element MEFISection 10 14 15 18 17 $nFiber -width $dw $dw $dw $db $db -section 31 31 31 30 30; #der
element MEFISection 11 16 17 20 19 $nFiber -width $db $db $dw $dw $dw -section 32 32 33 33 33; #izq
element MEFISection 12 17 18 21 20 $nFiber -width $dw $dw $dw $db $db -section 33 33 33 32 32; #der
element MEFISection 13 19 20 23 22 $nFiber -width $db $db $dw $dw $dw -section 32 32 33 33 33; #izq
element MEFISection 14 20 21 24 23 $nFiber -width $dw $dw $dw $db $db -section 33 33 33 32 32; #der