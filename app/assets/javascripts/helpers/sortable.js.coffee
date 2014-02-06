App.Sortable =
  init: ($el, controller) ->
    _getPages = (sel) ->
      $(sel).sortable(
        connectWith: '.app-pages'
        placeholder: 'page-drag-placeholder'
        dropOnEmpty: true
      )
      $(sel).sortable('toArray', attribute: 'data-id').filter (a) -> a

    $el.sortable(
      connectWith: '.app-pages'
      placeholder: 'page-drag-placeholder'
      dropOnEmpty: true
      opacity: 0.5
      tolerance: "pointer"
      start: (e, ui) =>
        ui.item.show()
      stop: (e, ui) =>
        indexes = {}
        indexes.homepage = _getPages('.app-homepage')
        indexes.unassigned = _getPages('.app-unassigned-pages')
        for pageList in $('.app-child-pages')
          $pageList = $(pageList)
          parentId = $pageList.parent().data('id')
          indexes[parentId] = _getPages($pageList)
        sort_id = ui.item.data('id')
        $('.app-pages').sortable('cancel')
        controller.changePageOrder sort_id, indexes
    )
