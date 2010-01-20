/*
 * jQuery implementation
 *
 */
/*
  function alternate_table_rows(table) {
    if ( table == undefined ) {
      table = "table.data"
    }
    $((table + ' tbody tr:nth-child(even)')).removeClass('odd').addClass('even')
    $((table + ' tbody tr:nth-child(odd)')).removeClass('even').addClass('odd')
  }

  $(document).ready(function() { alternate_table_rows() });
*/

/* 
 * Prototype implementation
 */
function alternate_table_rows() {
  $('table.data tbody tr:nth-child(even)').each( 
    function(e) { 
      e.removeClassName('odd')
      e.addClassName('even');
    }
  );

  $('table.data tbody tr:nth-child(odd)').each( 
    function(e) { 
      e.removeClassName('even')
      e.addClassName('odd');
    }
  );
}

Event.observe(window, 'load', alternate_table_rows);
