App.AppDashboardController = Ember.ObjectController.extend
  changePageOrder: (changedId, indexes) ->
    cids = "#{changedId}"
    app = @get 'model'
    unassigned = indexes.unassigned
    homepage = indexes.homepage
    delete indexes.homepage
    delete indexes.unassigned
    proms = []
    app.get('pages').forEach (p) =>
      prom = []
      pId = p.get('id')
      prom.push(p.set('parent', undefined)) if pId in unassigned
      for pageId, children of indexes
        if pId in children
          parent = app.get('pages').findBy('id', pageId)
          prom.push p.set('parent', parent)
          prom.push p.set('order', children.indexOf(pId))

      proms.push Ember.RSVP.all(prom).then =>
        p.save()

    Ember.RSVP.all(proms).then =>
      if cids in homepage
        @store.find('page', cids).then (p) ->
          app.set('homepage', p).save()

  unassignedPages: (->
    hid = @get('homepage.id')
    @get('pages').toArray().reject (p) =>
      p.get('id') == hid
  ).property('pages.@each', 'homepage.id')
