"use strict"

fs = require("fs")
path = require("path")
Sequelize = require("sequelize")
config = require(__dirname + '/../config').database
sequelize = new Sequelize(config.database, config.username, config.password, config.options)
db = {}

fs.readdirSync(__dirname)
    .filter (file) -> (file.indexOf(".") != 0) && (file != "index.js") && (file.indexOf('.coffee') == -1)
    .forEach (file) ->
        model = sequelize.import(path.join(__dirname, file))
        db[model.name] = model


Object.keys(db).forEach((modelName) ->
    db[modelName].associate(db) if ("associate" in db[modelName])
)

db.sequelize = sequelize
db.Sequelize = Sequelize

module.exports = db
