taike = ->

taike.decorators = {}
bool-deco = (prop)-> taike.decorators[prop] = (import (prop):true)
<[ primary required unique autoincrement ]> .for-each bool-deco

module.exports = taike