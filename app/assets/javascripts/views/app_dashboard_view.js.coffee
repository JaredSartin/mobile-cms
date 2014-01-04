App.AppDashboardView = Ember.View.extend
  didInsertElement: ->
    @_super()
    @setSortable()

  willDestroyElement: ->
    @$('.app-homepage, .app-unassigned-pages, .app-child-pages').sortable('destroy')

  setSortable: (->
    Ember.run.debounce @, =>
      controller = @get('controller')
      @$('.app-homepage, .app-unassigned-pages, .app-child-pages').sortable(
        connectWith: '.app-pages'
        placeholder: 'page-drag-placeholder'
        dropOnEmpty: true
        helper: "clone"
        start: (e, ui) =>
          ui.item.show()
        stop: (e, ui) =>
          indexes = {}
          indexes.homepage = @_getPages('.app-homepage')
          indexes.unassigned = @_getPages('.app-unassigned-pages')
          for pageList in @$('.app-child-pages')
            $pageList = $(pageList)
            parentId = $pageList.parent().data('id')
            indexes[parentId] = @_getPages($pageList)
          sort_id = ui.item.data('id')
          $('.app-pages').sortable('cancel')
          controller.changePageOrder sort_id, indexes
      )
    , 100
  ).observes('controller.pages.@each')

  _getPages: (sel) ->
    #thinks sel is not a sortable?
    @$('.app-homepage, .app-unassigned-pages, .app-child-pages').sortable(
      connectWith: '.app-pages'
      placeholder: 'page-drag-placeholder'
      dropOnEmpty: true
    )
    #######
    @$(sel).sortable('toArray', attribute: 'data-id').filter (a) -> a
