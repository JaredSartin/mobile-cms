App.ClientController = Ember.ObjectController.extend
  isStandalone: (->
    navigator.standalone or (screen.height-document.documentElement.clientHeight<40)
  ).property()

App.ClientHomepageController = Ember.ObjectController.extend
  pageContent: ( ->
    @get('model.body')
  ).property('model.body')
