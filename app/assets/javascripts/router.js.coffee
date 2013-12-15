App.Router.reopen
  location: 'history'

App.Router.map ()->
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
    )
  )
