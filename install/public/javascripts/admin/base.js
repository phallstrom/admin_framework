function alternate_table_rows(table) {
  if ( table == undefined ) {
    table = "table.data"
  }
  $((table + ' tbody tr:nth-child(even)')).removeClass('odd').addClass('even')
  $((table + ' tbody tr:nth-child(odd)')).removeClass('even').addClass('odd')
}

$(document).ready(function() { 

  alternate_table_rows() 

  // Automagically collapse/expand fieldsets in forms to make them easier to manage
  $('form fieldset.collapsable').
    find('legend').
    bind('click', function(e) { $(this).parent().find('div.field, div.fieldset_contents, span.instructions').toggle() }).
    end().
    filter('.collapsed').not(':has(div.fieldWithErrors)').find('div.field, div.fieldset_contents, span.instructions').hide().
    end().
    prepend("<span class='instructions'>Click the label above to expand this section.</span>")

})
