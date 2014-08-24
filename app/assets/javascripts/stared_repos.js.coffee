currentIntervalId = null

$(document).ready ->
  if $('#stared_repos-index').exists()
    initalizeTags()
    $(document).on 'ajax:success', 'a.sync-button', (event, data)->
      currentIntervalId = setInterval(updateList, 1000)

    currentIntervalId = setInterval(updateList, 1000)

updateList = ->
  $('.sync-button').enableLoader()
  $.getJSON $('#js-routes-helper').data('stared-repos-path'), (data)->
    $('#stared-repos').html(data.list_html)
    initalizeTags()

    unless data.is_sync_job_running
      $('.sync-button').disableLoader()
      clearInterval(currentIntervalId)
      console.log currentIntervalId

initalizeTags = ->
  sendTagForm = (value)-> $(this).closest('form').submit()

  $('.repo-tags').tagsInput
    autocomplete_url: $('#js-routes-helper').data('tags-autocomplete-path'),
    height: '45px',
    width: '450px',
    onAddTag: sendTagForm,
    onRemoveTag: sendTagForm
