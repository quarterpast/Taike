# Taike

Schema generator for [node-sql](https://github.com/brianc/node-sql).

```
npm install taike
```

## Example
Taike lets you write schemas like:

```javascript
var schema = require('taike');
var τ = schema.decorators;
var sql = require('sql');

var Post = sql.define('posts', {
  columns: schema({
    id:      τ.id('integer'),
    title:   τ.size(255, String),
    content: String
  })
});
```

## API
coming soon, for now see the [tests](/test.ls)

## Licence
MIT
