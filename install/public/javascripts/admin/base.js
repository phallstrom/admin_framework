function alternate_table_rows(table) {
  if ( table == undefined ) {
    table = "table.data"
  }
  $((table + ' tbody tr:nth-child(even)')).removeClass('odd').addClass('even')
  $((table + ' tbody tr:nth-child(odd)')).removeClass('even').addClass('odd')
}

function expand_all_fieldsets() {
  $('fieldset.collapsed').children('div.field, div.fieldset_contents, span.instructions').show().end().find('span.expand').hide()
}

$(document).ready(function() { 

  alternate_table_rows() 

  // Automagically collapse/expand fieldsets in forms to make them easier to manage
  $('form fieldset.collapsable').
    children('legend').
    bind('click', function(e) { $(this).parent().children('div.field, div.fieldset_contents, span.instructions, span.expand').toggle() }).
    end().
    filter('.collapsed').
    prepend("<span class='expand'>Click the label above to expand this section.</span>").
    not(':has(div.fieldWithErrors)').children('div.field, div.fieldset_contents, span.instructions').hide()

  if ( window.location.pathname.match(/\/new$/) ) {
    expand_all_fieldsets()
  }

})

