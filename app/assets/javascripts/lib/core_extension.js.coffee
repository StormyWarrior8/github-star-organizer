$.fn.exists = -> @.length > 0

$.fn.enableLoader = ->
  return @ if @.prev('.ajax-loader').exists()
  @.before $(document.createElement('span')).addClass('ajax-loader')
  @.hide()

$.fn.disableLoader = ->
  @.prev('.ajax-loader').remove()
  @.show()
