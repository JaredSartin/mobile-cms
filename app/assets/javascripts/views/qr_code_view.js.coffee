App.QRCodeView = Ember.View.extend
  classNames: ['qr-printable', 'text-center']
  didInsertElement: ->
    @$('.link-qr-code').qrcode
      text: @get('url')
      size: 512
      render: 'image'

  shortname: ''
  cname: ''

  url: (->
    cname = @get('cname')
    shortname = @get('shortname')
    if cname
      "http://#{cname}/#{shortname}"
    else
      "http://www.publicizr.com/#{shortname}"
  ).property('shortname', 'cname')

  defaultTemplate: Ember.Handlebars.compile('<div class="link-qr-code"></div><a href={{unbound view.url}}>{{view.url}}</a>')
