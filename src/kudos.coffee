# Description:
#   Give kudos to someone
#
# Dependencies:
#   "underscore": "^1.7.0"
#
# Configuration:
#   None
#
# Commands:
#   kudos to <user> - gives the specified user a kudo
#   hubot leaderboard - displays the current kudos leaderboard
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   daegren

Keeper = require('./keeper')

module.exports = (robot) ->
  keeper = new Keeper(robot)

  robot.hear /kudos to @?([\w .\-]+)$/i, (msg) ->
    name = msg.match[1].trim()

    users = robot.brain.usersForFuzzyName(name)
    if users.length is 1
      user = users[0]
      keeper.add user.name
      msg.send "#{user.name} is awesome!"
    else if users.length is 0
      msg.send "I don't know who #{name} is :("


  robot.respond /leaderboard/i, (msg) ->
    msg.send keeper.leaderboard()

  robot.hear /show brain/i, (msg) ->
    console.log robot.brain

  robot.hear /show scores/i, (msg) ->
    robot.logger.info keeper.getScores()
