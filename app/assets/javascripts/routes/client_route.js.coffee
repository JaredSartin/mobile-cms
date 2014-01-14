App.ClientRoute = Ember.Route.extend
  model: (params) ->
    @store.find('app', shortname: params.app_shortname)

  afterModel: (apps, transition) ->
    if apps.content.length == 0
      @transitionTo 'client.notFound'

  setupController: (controller, model) ->
    appModel = model.content[0]
    controller.set('model', appModel)

App.ClientHomepageRoute = Ember.Route.extend
  model: -> @modelFor('client').content[0].get('homepage')

  setupController: (controller, model) ->
    controller.set('model', model)
