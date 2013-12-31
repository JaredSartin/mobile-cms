App.AppDashboardView = Ember.View.extend
  didInsertElement: ->
    @_super()
    @setSortable()

  setSortable: (->
    Ember.run.debounce @, =>
      controller = @get('controller')
      @$('.app-homepage, .app-unassigned-pages, .app-child-pages').sortable(
        connectWith: '.app-pages'
        placeholder: 'page-drag-placeholder'
        dropOnEmpty: true
        stop: (e, ui) =>
          indexes = {}
          indexes.homepage = @_getPages('.app-homepage')
          for pageList in @$('.app-child-pages')
            $pageList = $(pageList)
            parentId = $pageList.parent().data('id')
            indexes[parentId] = @_getPages($pageList)
          controller.changePageOrder ui.item.data('id'), indexes
      )
    , 1
  ).observes('controller.pages.@each')

  _getPages: (sel) ->
    #thinks sel is not a sortable?
    @$(sel).sortable(
      connectWith: '.app-pages'
      placeholder: 'page-drag-placeholder'
      dropOnEmpty: true
    )
    #######
    @$(sel).sortable('toArray', attribute: 'data-id').filter (a) -> a
