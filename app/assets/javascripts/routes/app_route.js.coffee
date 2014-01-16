App.AppDashboardRoute = Ember.Route.extend
  model: -> @modelFor('app')

App.AppSettingsRoute = Ember.Route.extend
  model: -> @modelFor('app')

  actions:
    save: (app) ->
      app.save().then =>
        @Flash.set('success', 'Settings have been saved!')
        @controller.transitionToRoute 'app.dashboard', app
      , =>
    cancel: ->
      @controller.transitionToRoute 'app.dashboard', @modelFor('app')
