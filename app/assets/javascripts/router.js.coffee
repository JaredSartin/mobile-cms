App.Router.reopen
  location: 'history'

App.Router.map ()->
  @resource('admin', ->
    @route('dashboard', path: '/')
  )
