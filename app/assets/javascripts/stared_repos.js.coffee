###class @StaredRepoController
  constructor: ->
    @currentInterval = null
    @initalizeTags()
    @bindInterval()
    $(document).on 'ajax:success', 'a.sync-button', (event, data)=> @bindInterval()

  initalizeTags: =>
    sendTagForm = (value)-> $(@).closest('form').submit()

    $('.repo-tags').tagsInput
      autocomplete_url: @routeTo('tags-autocomplete-path'),
      height: '45px',
      width: '450px',
      onAddTag: sendTagForm,
      onRemoveTag: sendTagForm

  updateList: =>
    $.getJSON @routeTo('stared-repos-path'), (data)=>
      $('#stared-repos').html(data.list_html)
      @initalizeTags()
      $('.sync-button').toggleLoader(data.is_sync_job_running)
      clearInterval(@currentInterval) unless data.is_sync_job_running

  bindInterval: => @currentInterval = setInterval(@updateList, 1000)
  routeTo: (path)-> $('#js-routes-helper').data(path)###
