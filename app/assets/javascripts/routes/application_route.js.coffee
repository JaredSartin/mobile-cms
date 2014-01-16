App.ApplicationRoute = Ember.Route.extend
  actions:
    willTransition: (transition) ->
      if @store.hasDirtyRecords()
        discard = confirm("You have changes pending, do you want to discard them and leave the page?")
        if discard
          @store.resetDirtyRecords()
          true
        else
          transition.abort()
