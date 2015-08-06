_ = require 'lodash'
$ = require('jquery')(require("node-jsdom").jsdom().parentWindow)
request = require 'request'
Promise = require 'bluebird'
models = require './models'

url = 'http://botzone.org/'

request_options =
    timeout: 5000

fetch = () ->
    return new Promise (fulfill, reject) ->
        request url, request_options, (error, response, body) ->
            if error or response.statusCode != 200
                return reject error
            fulfill body

parse = (html) ->
    trs = $(html).find('table').eq(1).find('tr')
    result = []
    for i in [1 ... trs.length]
        tr = trs.eq i
        tds = tr.find 'td'
        div_scores = tr.find 'div.score.pull-right'
        a_users = tr.find 'a.smallusername'
        a_bots = tr.find 'a.botname.nonpublic'

        continue if a_bots.length != 2 # ignore human

        result.push
            matchid: tds.eq(3).find('a').attr('href').substr('/match/'.length)
            startedAt: tds.eq(0).text()
            game: tds.eq(1).text()
            user0: a_users.eq(0).text()
            user1: a_users.eq(1).text()
            bot0: a_bots.eq(0).text()
            bot1: a_bots.eq(1).text()
            score0: parseInt div_scores.eq(0).text(), 10
            score1: parseInt div_scores.eq(1).text(), 10
        null
    result

insert = (results) ->
    matachids = (res.matchid for res in results)
    models.Match.findAll {where:{matchid:{$in:matachids}}}
    .then (docs) ->
        _.remove results, (rec) ->
            _.any (doc.matchid == rec.matchid for doc in docs)
        models.Match.bulkCreate(results)



run = ->
    fetch()
    .then parse
    .then insert
    .then -> console.log new Date(), 'spider success'
    .error console.error
    .finally run

module.exports = run
