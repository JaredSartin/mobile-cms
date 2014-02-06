App.PageListingView = Ember.View.extend
  tagName: "li"
  classNames: "app-page page-preview"
  classNameBindings: ['appPageId']
  attributeBindings: ['data-id']
  "data-id": ( ->
    @get('page.id')
  ).property('page.id')

  templateName: 'page/_dashboard_list'

  didInsertElement: ->
    @_super()
    App.Sortable.init(@$('.app-child-pages'), @get('controller'))

  appPageId: ( ->
    "app-page-#{@get('page.id')}"
  ).property('page.id')
