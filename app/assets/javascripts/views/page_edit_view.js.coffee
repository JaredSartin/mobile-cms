App.PageEditView = Ember.View.extend
  didInsertElement: ->
    window.foo = @
    $('textarea.app-page-body').wysihtml5()
    $('.datepicker').datepicker()
