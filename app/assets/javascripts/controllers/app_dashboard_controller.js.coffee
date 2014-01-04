App.AppDashboardController = Ember.ObjectController.extend
  changePageOrder: (changedId, indexes) ->
    cids = "#{changedId}"
    app = @get 'model'
    unassigned = indexes.unassigned
    if cids in indexes.homepage
      @store.find('page', cids).then (p) ->
        app.set('homepage', p)
        app.save()
    delete indexes.homepage
    delete indexes.unassigned
    @_removeFromChildren(unassigned)
    for pageId, children of indexes
      @_updateChildren(pageId, children)

  _updateChildren: (pageId, children) ->
    @store.find('page', pageId).then (p) =>
      hasIds = p.get('children').getEach('id')

      # Only want the ones that are not in the pages children
      newChildren = children.reject((id) -> id in hasIds)

      @_addToChildren(p, newChildren) if newChildren.length > 0
      @_changeChildrenOrder(p, children)

  _addToChildren: (page, newChildrenIds) ->
    for newChildId in newChildrenIds
      @store.find('page', newChildId).then (child) =>
        child.set('parent', page)
        child.save()

  _removeFromChildren: (staleChildrenIds) ->
    for staleChildId in staleChildrenIds
      @store.find('page', staleChildId).then (child) =>
        child.set('parent', undefined)
        child.save()

  _changeChildrenOrder: (page, children) ->
    page.get('children').then (cs) =>
      needReorder = false
      cs.forEach (item, index) =>
        needReorder = true unless item.get('id') == children[index]

      if needReorder
        children.forEach (item, index) =>
          item = cs.findBy('id', item)
          item.set('order', index).save() if item

  unassignedPages: (->
    hid = @get('homepage.id')
    @get('pages').toArray().reject (p) =>
      p.get('id') == hid
  ).property('pages.@each', 'homepage.id')
