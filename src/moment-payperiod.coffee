if require?
  moment = require('moment')
else
  moment = this.moment

class PayPeriod
  
  constructor: (date, type, options) ->
    @date = @_initDate(date)
    @options = options || {}
    @format  = @options.format || 'YYYY-MM-DD'
    @epoch   = @_initDate(@options.epoch)
    @type    = type || 'weekly'
    
    switch @type
      when 'weekly'      then @_numberOfDays(7)
      when 'biweekly'    then @_numberOfDays(14)
      when 'semimonthly' then @_semimonthly()
      when 'monthly'     then @_monthly()
  
  next: ->
    date = moment(@stop, @format).add('d', 1)
    new PayPeriod( date, @type, @options )
  
  previous: ->
    date = moment(@start, @format).subtract('d', 1)
    new PayPeriod( date, @type, @options )
  
  _numberOfDays: (days) ->
    diff  = Math.floor( @date.diff(@epoch, 'days') / days ) * days
    start = @epoch.clone().add('d', diff)
    stop  = start.clone().add('d', (days - 1))
    @_formatResult(start, stop)
  
  _semimonthly: ->
    date = @date
    #don't know why date.days() returns incorrect number
    if date.date() < 16
      s = moment([date.year(), date.month()])
      e = moment([date.year(), date.month(), 15])
    else
      s = moment([date.year(), date.month(), 16])
      e = moment([date.year(), date.month()]).add('M', 1).subtract('d', 1)
    @_formatResult(s, e)
  
  _monthly: ->
    date = @date
    s = moment([date.year(), date.month()])
    e = s.clone().add('M', 1).subtract('d', 1)
    @_formatResult(s, e)
  
  _lte: (d1,d2) ->
    d1.unix() <= d2.unix()
  
  _formatResult: (start, stop) ->
    @start = start.format(@format)
    @stop  = stop.format(@format)
    @days  = @_days(start, stop)
  
  _days: (start, stop) ->
    s = start.clone()
    a = []
    while @_lte( s, stop)
      a.push( s.format(@format) )
      s.add('d', 1)
    a
  
  _initDate: (date) ->
    date ||= moment
    if moment.isMoment(date)
      date
    else
      moment(date, @format)
  
moment.fn.payperiod = (type, options) ->
  new PayPeriod( @, type, options )
