module.exports =
  messages:
    map: (doc) ->
      { type } = doc

      if type is 'message'
        emit(doc.timestamp,
          from: doc.from
          sent_to: doc.sent_to
          message: doc.message
          number: doc.number
          revision: doc._rev
        )
