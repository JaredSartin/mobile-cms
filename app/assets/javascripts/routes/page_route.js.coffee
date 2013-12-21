App.PagesNewRoute = Ember.Route.extend
  model: -> @store.createRecord('page', app: @modelFor('app'))

  actions:
    save: (page) ->
      page.save().then =>
        # EMBERRRRR! https://github.com/emberjs/data/issues/1308 
        # Sneak our saved/updated machine object into the Location's machine list:  (croz and jared 2013-12-04)
        @modelFor('app').get('pages').pushObject(page)
        @controller.transitionToRoute 'app.dashboard', @modelFor('app')

