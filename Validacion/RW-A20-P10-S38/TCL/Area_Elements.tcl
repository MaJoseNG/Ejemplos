set m_fibers 8;
set db [expr 228.6*$mm];    # Wall boundary length discretization
set dw [expr 127.133*$mm];  # Wall web length discretization
set tw [expr 152.4*$mm];    # Wall thickness
set tb [expr 304.8*$mm];    # Loading tranfer beam thickness

#element MEFI 1 1 2 4 3 $m_fibers -thick $tw $tw $tw $tw $tw $tw $tw $tw -width $db $dw $dw $dw $dw $dw $dw $db -mat 7 6 6 6 6 6 6 7;
#element MEFI 2 3 4 6 5 $m_fibers -thick $tw $tw $tw $tw $tw $tw $tw $tw -width $db $dw $dw $dw $dw $dw $dw $db -mat 7 6 6 6 6 6 6 7;
#element MEFI 3 5 6 8 7 $m_fibers -thick $tw $tw $tw $tw $tw $tw $tw $tw -width $db $dw $dw $dw $dw $dw $dw $db -mat 7 6 6 6 6 6 6 7;
#element MEFI 4 7 8 10 9 $m_fibers -thick $tw $tw $tw $tw $tw $tw $tw $tw -width $db $dw $dw $dw $dw $dw $dw $db -mat 7 6 6 6 6 6 6 7;
#element MEFI 5 9 10 12 11 $m_fibers -thick $tw $tw $tw $tw $tw $tw $tw $tw -width $db $dw $dw $dw $dw $dw $dw $db -mat 7 6 6 6 6 6 6 7;
#element MEFI 6 11 12 14 13 $m_fibers -thick $tw $tw $tw $tw $tw $tw $tw $tw -width $db $dw $dw $dw $dw $dw $dw $db -mat 7 6 6 6 6 6 6 7;
#element MEFI 7 13 14 16 15 $m_fibers -thick $tw $tw $tw $tw $tw $tw $tw $tw -width $db $dw $dw $dw $dw $dw $dw $db -mat 7 6 6 6 6 6 6 7;
#element MEFI 8 15 16 18 17 $m_fibers -thick $tb $tb $tb $tb $tb $tb $tb $tb -width $db $dw $dw $dw $dw $dw $dw $db -mat 7 6 6 6 6 6 6 7;
#element MEFI 9 17 18 20 19 $m_fibers -thick $tb $tb $tb $tb $tb $tb $tb $tb -width $db $dw $dw $dw $dw $dw $dw $db -mat 7 6 6 6 6 6 6 7;

# ========================================= USO DE MEFISection ========================================================
element MEFISection 1 1 2 4 3 $m_fibers -width $db $dw $dw $dw $dw $dw $dw $db -section 11 10 10 10 10 10 10 11;
element MEFISection 2 3 4 6 5 $m_fibers -width $db $dw $dw $dw $dw $dw $dw $db -section 11 10 10 10 10 10 10 11;
element MEFISection 3 5 6 8 7 $m_fibers -width $db $dw $dw $dw $dw $dw $dw $db -section 11 10 10 10 10 10 10 11;
element MEFISection 4 7 8 10 9 $m_fibers -width $db $dw $dw $dw $dw $dw $dw $db -section 11 10 10 10 10 10 10 11;
element MEFISection 5 9 10 12 11 $m_fibers -width $db $dw $dw $dw $dw $dw $dw $db -section 11 10 10 10 10 10 10 11;
element MEFISection 6 11 12 14 13 $m_fibers -width $db $dw $dw $dw $dw $dw $dw $db -section 11 10 10 10 10 10 10 11;
element MEFISection 7 13 14 16 15 $m_fibers -width $db $dw $dw $dw $dw $dw $dw $db -section 11 10 10 10 10 10 10 11;
element MEFISection 8 15 16 18 17 $m_fibers -width $db $dw $dw $dw $dw $dw $dw $db -section 13 12 12 12 12 12 12 13;
element MEFISection 9 17 18 20 19 $m_fibers -width $db $dw $dw $dw $dw $dw $dw $db -section 13 12 12 12 12 12 12 13;
# ======================================== FIN MEFISECTION ============================================================