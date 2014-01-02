App.PagesNewRoute = Ember.Route.extend
  model: -> @store.createRecord('page', app: @modelFor('app'))

  actions:
    save: (page) ->
      page.save().then =>
        # EMBERRRRR! https://github.com/emberjs/data/issues/1308 
        # Sneak our saved/updated machine object into the Location's machine list:  (croz and jared 2013-12-04)
        @modelFor('app').get('pages').pushObject(page)
        @controller.transitionToRoute 'app.dashboard', @modelFor('app')

App.PageEditRoute = Ember.Route.extend
  model: -> @modelFor('page')
  actions:
    save: (page) ->
      page.save().then =>
        @controller.transitionToRoute 'app.dashboard', @modelFor('app')
    delete: (page) ->
      if confirm("Are you sure you want to delete this page?")
        appModel = @modelFor('app')
        appModel.get('pages').then (p) =>
          p.removeObject page
          page.deleteRecord()
          page.save().then =>
            @controller.transitionToRoute 'app.dashboard', appModel
