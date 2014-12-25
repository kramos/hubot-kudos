chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'keeper', ->
  user =
    name: 'sinon'
    id: 'U123'
  robot =
    respond: sinon.spy()
    hear: sinon.spy()
    brain:
      on: (_, cb) ->
        cb()
      data: {}
      userForName: (who) ->
        forName =
          name: who
          id: 'U234'
      get: sinon.spy()

  beforeEach ->
    @user = user
    @robot = robot
    @data = @robot.brain.data
    @msg =
      send: sinon.spy()
      reply: sinon.spy()
      envelope:
        user:
          @user
      message:
        user:
          @user

  require('../src/kudos')(robot)

  it 'registers the "kudos" listener', ->
    expect(@robot.hear).to.have.been.calledWith(/kudos to @?(.*)/i)

  it 'registers the "leaderboard" listener', ->
    expect(@robot.respond).to.have.been.calledWith(/leaderboard/i)
