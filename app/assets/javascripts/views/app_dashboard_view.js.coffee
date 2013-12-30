App.AppDashboardView = Ember.View.extend
  didInsertElement: ->
    @_super()
    @setSortable()

  setSortable: (->
    Ember.run.scheduleOnce 'afterRender', @, =>
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
  ).observes('controller.pages.@each')

  _getPages: (sel) ->
    @$(sel).sortable('toArray', attribute: 'data-id').filter (a) -> a
