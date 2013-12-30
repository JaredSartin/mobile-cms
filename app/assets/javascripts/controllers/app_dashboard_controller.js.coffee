App.AppDashboardController = Ember.ObjectController.extend
  changePageOrder: (changedId, indexes) ->
    cids = "#{changedId}"
    app = @get 'model'
    if cids in indexes.homepage
      @store.find('page', cids).then (p) ->
        app.set('homepage', p)
        app.save()

  unassignedPages: (->
    @store.filter 'page', (p) =>
      p.get("id") != @get('homepage.id')
  ).property('pages', 'homepage.id')
