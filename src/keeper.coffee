_ = require('underscore')

class Keeper
  constructor: (@robot) ->
    @scores = {
      scores: {}
    }

    robot.brain.on 'loaded', @_brainLoaded

  add: (user) ->
    @scores.scores[user] ||= 0
    @scores.scores[user]++
    @robot.brain.set 'kudos', @scores
    console.log @robot.brain
    @robot.brain.save()

  leaderboard: ->
    leaderboard = for scores, i in @_sortedScores()
      "#{i + 1}: #{scores.user} - #{scores.score}"
    leaderboard.join '\n'

  _brainLoaded: =>
    @robot.logger.info @robot.brain.get('kudos')
    @scores = _.extend @scores, @robot.brain.get('kudos')

  _sortedScores: ->
    scores = for own user, score of @scores.scores
      { user: user, score: score }
    scores.sort (a,b) ->
      a.score - b.score

  getScores: ->
    @scores


module.exports = Keeper
