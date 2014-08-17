# Taike [![Build Status](https://travis-ci.org/quarterto/Taike.svg)](https://travis-ci.org/quarterto/Taike)

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
### Properties
A property is an object key with a specification value. A spec can be a raw [type](#Types), or as object containing any of:

#### `type`
The data type.
#### `size`
A String column is either `text` or, if `size` is present, `varchar(size)`.
#### `primary`, `required`, `unique`, `autoincrement`
If `true`, modify the column type as appropriate. If `primary` is present, `required` and `unique` are ignored.
#### `column`
Change the column name, if you want it to have a different name to the property.

### Types
For now, Taike only supports basic String, Number and Boolean columns. Foreign keys will arrive in a future version.

### Decorators
Building spec objects can be tedious. Taike provides composable decorators for attaching spec properties. The following properties are available under `taike.decorators`: `primary`, `required`, `unique`, `autoincrement`, `column` and `size`.

## Licence
MIT
