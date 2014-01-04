App.AppDashboardController = Ember.ObjectController.extend
  changePageOrder: (changedId, indexes) ->
    cids = "#{changedId}"
    app = @get 'model'
    unassigned = indexes.unassigned
    if cids in indexes.homepage
      @store.find('page', cids).then (p) ->
        app.set('homepage', p).save()
    delete indexes.homepage
    delete indexes.unassigned
    app.get('pages').forEach (p) =>
      prom = []
      pId = p.get('id')
      prom.push(p.set('parent', undefined)) if pId in unassigned
      for pageId, children of indexes
        if pId in children
          parent = app.get('pages').findBy('id', pageId)
          prom.push p.set('parent', parent)
          prom.push p.set('order', children.indexOf(pId))

      Ember.RSVP.all(prom).then =>
        p.save()

  unassignedPages: (->
    hid = @get('homepage.id')
    @get('pages').toArray().reject (p) =>
      p.get('id') == hid
  ).property('pages.@each', 'homepage.id')
