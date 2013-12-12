App.AdminRoute = Ember.Route.extend
  model: -> @get('currentUser')

App.AdminDashboardRoute = Ember.Route.extend
  model: -> @get('currentUser')
