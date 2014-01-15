App.PageEditView = Ember.View.extend
  didInsertElement: ->
    $('textarea.app-page-body').wysihtml5()
