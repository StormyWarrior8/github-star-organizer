$(document).ready ->
  sendTagForm = (value)-> $(this).closest('form').submit()

  $('.repo-tags').tagsInput
    autocomplete_url: $('#js-routes-helper').data('tags-autocomplete-path'),
    height: '45px',
    width: '450px',
    onAddTag: sendTagForm,
    onRemoveTag: sendTagForm
