_ = require('underscore')

module.exports =
  send: (doc, req) ->
    unless doc
      { body, uuid } = req
      doc =
        _id: uuid
        timestamp: new Date().getTime()
        type: 'message'
      _.extend(doc, JSON.parse(body))

    [ doc, 'OK' ]
