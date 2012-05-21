module.exports = [
  {
    from: ''
    to: 'index.html'
  }
  {
    from: '/css/*'
    to: 'static/css/*'
  }
  {
    from: '/js/*'
    to: 'static/js/*'
  }
  {
    from: '/messages'
    to: '_view/messages'
    method: 'GET'
    query:
      descending: 'true'
  }
  {
    from: '/messages'
    to: '_update/send'
    method: 'POST'
  }
  {
    from: '/messages/:id/:rev'
    to: '../../:id'
    method: 'DELETE'
    query:
      rev: ':rev'
  }
]
