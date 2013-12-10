App.AdminRoute = Ember.Route.extend
  model: -> @get('currentUser')
