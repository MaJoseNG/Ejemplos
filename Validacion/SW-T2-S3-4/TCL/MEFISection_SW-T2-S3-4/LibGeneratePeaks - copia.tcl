#set divided 15
#set divisor 4
#
#set resto [expr $divided % $divisor]
#
#puts "El resto de la division $divided entre $divisor es: $resto"

foreach Dmax {0.375 0.75 1.125 1.5 2.25 3 4.5 6 7.5 9 10.5 12 13.5 15 18} {

    set Dincr 0.15
#set Dmax 0.375
    set resto [expr fmod($Dmax, $Dincr)]
    puts "El resto de la division $Dmax entre $Dincr es: $resto"
    #set resto [format "%.*f" 4 $resto]
    puts "El resto de la division es: $resto"
    set n 0

    while {$resto > 1e-4} {
        set Dincr [expr $Dincr/2]
        set resto [expr fmod($Dmax, $Dincr)]
        puts "El resto de la division $Dmax entre $Dincr es: $resto"
        set n [expr $n+1]
            };   

    puts "n = $n"
#if {$resto != 0} {
#    set Dincr [expr $Dincr/2]
#}

    puts "Incremento de desplazamiento : Dincr = $Dincr"

    set NstepsPeak [expr $Dmax/$Dincr]

    puts "Nro de pasos: $NstepsPeak"
}