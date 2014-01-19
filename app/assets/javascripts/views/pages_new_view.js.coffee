App.PagesNewView = Ember.View.extend
  didInsertElement: ->
    $('textarea.app-page-body').wysihtml5()
    $('.datepicker').datepicker()
