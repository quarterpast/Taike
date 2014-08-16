require! {
  taike: './index'
  'expect.js'
}

export 'Taike':
  'should have bare keys as datatypes':
    'number should be decimal': ->
      expect taike a:Number .to.eql a:data-type:\decimal
    'integer should be int': ->
      expect taike a:\integer .to.eql a:data-type:\int
    'boolean should be bit': ->
      expect taike a:Boolean .to.eql a:data-type:\bit
    'string':
      'without qualification should be text': ->
        expect taike a:String .to.eql a: data-type:'text'
      'with a size should be varchar(length)': ->
        expect taike a:{size:50 type:String} .to.eql a:data-type:'varchar(50)'

  'spec objects':
    'column sets column name': ->
      expect taike a:column:\prop .to.eql prop:property:\a
    'type sets data type': ->
      expect taike a:type:String .to.eql a:data-type:'text'
    'required sets not null': ->
      expect taike a:{+required, type:String} .to.eql a:data-type:'text not null'
    'unique sets unique': ->
      expect taike a:{+unique, type:\integer} .to.eql a:data-type:'int unique'
    'primary sets primary key': ->
      expect taike a:{+primary, type:\integer} .to.eql a:data-type:'int primary key'
    'autoincrement sets autoincrement': ->
      expect taike a:{+autoincrement, type:\integer} .to.eql a:data-type:'int autoincrement'

  'decorators':
    'primary': ->
      taike.decorators.primary r = {}
      expect r .to.have.property \primary true
    'column': ->
      taike.decorators.column \col r = {}
      expect r .to.have.property \column \col
    'required': ->
      taike.decorators.required r = {}
      expect r .to.have.property \required true
    'unique': ->
      taike.decorators.unique r = {}
      expect r .to.have.property \unique true
    'autoincrement': ->
      taike.decorators.autoincrement r = {}
      expect r .to.have.property \autoincrement true
    'id is primary and autoincrement': ->
      taike.decorators.id r = {}
      expect r .to.have.property \primary true
      expect r .to.have.property \autoincrement true
    'size': ->
      taike.decorators.size 255 r = {}
      expect r .to.have.property \size 255
