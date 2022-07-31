<?php

//random code generator
function engine_random_code($unique = 1,$count = 10): string
{
    $length = $count - strlen($unique) ;
    $start =1;
    $end = 9;
    for($i=1;$i<$length;$i++){
        $start.=0;
        $end.=9;
    }
    return $unique.rand($start,$end);
}
