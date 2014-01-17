Ember.Application.initializer
  name: 'currentUser'
  initialize: (container, application) ->
    user_id = $('meta[name=current-user-id]').attr('content')
    if user_id
      store = container.lookup('store:main')
      user = store.find('user', user_id)
      container.register('user:current', user, instantiate: false)
      container.injection('route', 'currentUser', 'user:current')
      container.injection('controller', 'currentUser', 'user:current')
