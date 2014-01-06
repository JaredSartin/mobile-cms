App.PageEditView = Ember.View.extend
  didInsertElement: ->
    $('textarea.app-page-body').wysihtml5()
      # events:
      #   'change:composer': =>
      #     console.log "YA!!"
      # $('textarea.app-page-body').val()
      # Ember.run.debounce @, =>
      #   console.log 'SAVE'
      # , 100
