App.ClientRoute = Ember.Route.extend
  model: (params) ->
    @store.find('app', shortname: params.app_shortname)

  setupController: (controller, model) ->
    controller.set('model', model.content[0])
