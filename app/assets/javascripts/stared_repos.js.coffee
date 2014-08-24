$(document).ready ->
  sendTagForm = (value)-> $(this).closest('form').submit()

  $('.repo-tags').tagsInput
    autocomplete_url: $('#stared-repos').data('autocomplete-url'),
    height: '45px',
    width: '450px',
    onAddTag: sendTagForm,
    onRemoveTag: sendTagForm
