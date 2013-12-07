App.AdminRoute = Ember.Route.extend
  model: -> @controllerFor('application').get('currentUser')
