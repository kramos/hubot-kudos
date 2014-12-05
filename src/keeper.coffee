_ = require('underscore')

class Keeper
  constructor: (@robot) ->
    @scores = {}

    @robot.brain.on 'loaded', =>
      @scores = _.extend @scores, @robot.brain.get('kudos')

  add: (user) ->
    @scores[user] ||= 0
    @scores[user]++
    @robot.brain.set 'kudos', @scores
    @robot.brain.save()

  leaderboard: ->
    leaderboard = for scores, i in @_sortedScores()
      "#{i + 1}: #{scores.user} - #{scores.score}"
    leaderboard.join '\n'

  _sortedScores: ->
    scores = for own user, score of @scores
      { user: user, score: score }
    scores.sort (a,b) ->
      a.score - b.score

  getScores: ->
    @scores


module.exports = Keeper
