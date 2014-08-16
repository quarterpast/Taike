require! {
  taike: './index'
  'expect.js'
}

export 'Taike':
  'should have bare keys as datatypes':
    'number should be decimal': ->
      expect taike a:Number .to.eql a:datatype:\decimal
    'integer should be int': ->
      expect taike a:\integer .to.eql a:datatype:\int
    'boolean should be bit': ->
      expect taike a:Boolean .to.eql a:datatype:\bit
    'string':
      'without qualification should be varchar': ->
        expect taike a:String .to.eql a: datatype:'varchar(255)'

  'spec objects':
    'name sets column name': ->
      expect taike a:name:\prop .to.eql a:property:\prop
    'type sets data type': ->
      expect taike a:type:String .to.eql a:datatype:'varchar(255)'
    'required sets not null': ->
      expect taike a:{+required, type:String} .to.eql a:datatype:'varchar(255) not null'
