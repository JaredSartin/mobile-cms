App.AppDashboardRoute = Ember.Route.extend
  model: -> @modelFor('app')

App.AppSettingsRoute = Ember.Route.extend
  model: -> @modelFor('app')

  actions:
    save: (app) ->
      app.save().then =>
        @controller.transitionToRoute 'app.dashboard', app
      , =>
    cancel: (app) ->
      console.log "UNDO ALL THE THINGS!"
