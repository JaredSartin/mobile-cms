App.PageEditView = Ember.View.extend
  didInsertElement: ->
    window.foo = @
    $('textarea.app-page-body').wysihtml5(color: true)
    $('.datepicker').datepicker()
