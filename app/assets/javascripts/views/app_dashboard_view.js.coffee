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
          $('.app-pages').removeClass("draggable-target")
          indexes = {}
          indexes.homepage = @_getPages('.app-homepage')
          indexes.unassigned = @_getPages('.app-unassigned-pages')
          for pageList in @$('.app-child-pages')
            $pageList = $(pageList)
            parentId = $pageList.parent().data('id')
            indexes[parentId] = @_getPages($pageList)
          controller.changePageOrder ui.item.data('id'), indexes
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