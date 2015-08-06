"use strict"

module.exports = (sequelize,  DataTypes) ->
    Match = sequelize.define "Match",
        matchid:   type: DataTypes.STRING,  allowNull: false
        startedAt: type: DataTypes.DATE,    allowNull: false
        game:      type: DataTypes.STRING,  allowNull: false
        user0:     type: DataTypes.STRING,  allowNull: false
        user1:     type: DataTypes.STRING,  allowNull: false
        bot0:      type: DataTypes.STRING,  allowNull: false
        bot1:      type: DataTypes.STRING,  allowNull: false
        score0:    type: DataTypes.INTEGER, allowNull: false
        score1:    type: DataTypes.INTEGER, allowNull: false
    ,
        classMethods:
            associate: (models) ->
