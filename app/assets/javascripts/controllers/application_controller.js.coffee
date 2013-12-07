App.ApplicationController = Ember.ObjectController.extend
  _currentUser: undefined
  currentUser: ( ->
    cu = @get('_currentUser')
    if cu
      @refreshSignIn()
    else
      @getSignIn()
    cu
  ).property('_currentUser')
  getSignIn: ->
    @store.find('user', 'current').then (usr) ->
      @set('_currentUser', usr)
  refreshSignIn: ->
    @set('_currentUser', null)
    @getSignIn()
