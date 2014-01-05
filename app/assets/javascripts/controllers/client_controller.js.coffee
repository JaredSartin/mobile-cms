App.ClientController = Ember.ObjectController.extend {}
App.ClientHomepageController = Ember.ObjectController.extend
  pageContent: ( ->
    @get('model.body')
  ).property('model.body')
