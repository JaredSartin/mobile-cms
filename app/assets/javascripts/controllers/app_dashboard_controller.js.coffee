App.AppDashboardController = Ember.ObjectController.extend
  changePageOrder: (changedId, indexes) ->
    cids = "#{changedId}"
    app = @get 'model'
    if cids in indexes.homepage
      @store.find('page', cids).then (p) ->
        app.set('homepage', p)
        app.save()
    delete indexes.homepage
    for page_id, children of indexes
      @_updateChildren(page_id, children)

  _updateChildren: (page_id, children) ->
    @store.find('page', page_id).then (p) =>
      hasIds = p.get('children').getEach('id')
      newChildren = children.reject((id) -> id in hasIds)
      staleChildren = hasIds.reject((id) -> id in children)
      @_removeChildren(p, staleChildren) if staleChildren.length > 0
      @_addChildren(p, newChildren) if newChildren.length > 0

  _addChildren: (page, newChildrenIds) ->
    for newChildId in newChildrenIds
      @store.find('page', newChildId).then (child) =>
        page.get('children').then (p) ->
          p.pushObject(child)
          p.save()

  _removeChildren: (page, staleChildrenIds) ->
    console.log "REMOVE CHILDREN"

  unassignedPages: (->
    @store.filter 'page', (p) =>
      (p.get("id") != @get('homepage.id')) and (!p.get('parent'))
  ).property('pages', 'homepage.id')
