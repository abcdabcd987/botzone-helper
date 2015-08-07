express = require 'express'
Promise = require 'bluebird'

models = require '../models'
config = require '../config'
router = express.Router()

router.get '/', (req, res, next) ->
    res.redirect '/matches/'

router.get '/matches/', (req, res, next) ->
    page = parseInt(req.query.page, 10) || 0

    count = models.Match.count()
    docs = models.Match.findAll {order:[['id', 'DESC']], limit:config.matches_per_page, offset: page*config.matches_per_page}
    Promise.all [docs, count]
    .then ([docs, count]) ->
        res.render 'matches',
            matches: docs
            cnt_match: count
            query:
                page: page


module.exports = router
