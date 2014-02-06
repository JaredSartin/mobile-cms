App.AppDashboardView = Ember.View.extend
  didInsertElement: ->
    @_super()
    App.Sortable.init(@$('.app-homepage, .app-unassigned-pages'), @get('controller'))

  willDestroyElement: ->
    @$('.app-homepage, .app-unassigned-pages, .app-child-pages').sortable(
      connectWith: '.app-pages'
      placeholder: 'page-drag-placeholder'
      dropOnEmpty: true
    )
    @$('.app-homepage, .app-unassigned-pages, .app-child-pages').sortable('destroy')
