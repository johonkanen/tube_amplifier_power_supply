--------------------------------------------------
package test_generic_pkg is
    generic(type                 g_countertype ;
            g_initval :           g_countertype ;
            function "+" (left : g_countertype; right : integer) return g_countertype);

    subtype countertype is g_countertype;
    constant init_counter : g_countertype := g_initval;

end package test_generic_pkg;

--------------------------------------------------
