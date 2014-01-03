App.Router.reopen
  location: 'history'

App.Router.map ()->
  # We hope to have an app set here!
  @resource('app', path: '/', ->
    @route('page', path: '/page/:page_id')
  )
  @resource('admin', ->
    @route('dashboard', path: '/')
    @resource('app', path: '/app/:app_id', ->
      @route('dashboard', path: '/')
      @route('settings')
      @resource('pages', ->
        @route('new')
      )
      @resource('page', path: '/page/:page_id', ->
        @route('show', path: '/')
        @route('edit')
      )
      @resource('pages', ->
        @route('new')
      )
    )
  )
