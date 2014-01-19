App.PagesNewRoute = Ember.Route.extend
  model: -> @store.createRecord('page', app: @modelFor('app'))

  actions:
    save: (page) ->
      page.set('body', $('textarea.app-page-body').val())
      page.save().then =>
        # EMBERRRRR! https://github.com/emberjs/data/issues/1308 
        # Sneak our saved/updated machine object into the Location's machine list:  (croz and jared 2013-12-04)
        @Flash.set('success', "Page created! Don't forget to assign it.")
        @modelFor('app').get('pages').then (ps) =>
          ps.pushObject(page)
          @controller.transitionToRoute 'app.dashboard', @modelFor('app')
      , =>
    cancel: ->
      @controller.transitionToRoute 'app.dashboard', @modelFor('app')

App.PageEditRoute = Ember.Route.extend
  model: -> @modelFor('page')
  actions:
    save: (page) ->
      page.set('body', $('textarea.app-page-body').val())
      page.save().then =>
        @Flash.set('success', "Changes to the page have been saved.")
        @controller.transitionToRoute 'app.dashboard', @modelFor('app')
      , =>
    delete: (page) ->
      if confirm("Are you sure you want to delete this page?")
        appModel = @modelFor('app')
        appModel.get('pages').then (p) =>
          p.removeObject page
          page.deleteRecord()
          page.save().then =>
            @Flash.set('success', "Page has been deleted.")
            @controller.transitionToRoute 'app.dashboard', appModel
          , =>
    cancel: ->
      @controller.transitionToRoute 'app.dashboard', @modelFor('app')
