moment =
  if require?
    require "moment"
  else
    @moment

class PayPeriod
  
  constructor: (yearStart, type, format) ->
    @format = format || 'YYYY-MM-DD'
    @yearStart = @_initDate(yearStart)
    @type = type || 'weekly'
  
  for: (d) ->
    date = @_initDate(d)
    switch @type
      when 'weekly' then @_weekly(date)
      when 'biweekly' then @_biweekly(date)
      when 'semimonthly' then @_semimonthly(date)
      when 'monthly' then @_monthly(date)
  
  _weekly: (date) ->
    s = @yearStart.clone()
    s.add('w', 1) while @_lte(s, date)
    start = s.clone().subtract('w', 1)
    stop = start.clone().add('d', 6)
    @_formatResult(start, stop)
  
  _biweekly: (date) =>
    s = @yearStart.clone()
    s.add('w', 2) while @_lte(s, date)
    start = s.clone().subtract('w', 2)
    stop   = start.clone().add('d', 13)
    @_formatResult(start, stop)
  
  _semimonthly: (date) ->
    #don't know why date.days() returns incorrect number
    if date.date() < 16
      s = moment([date.year(), date.month()])
      e = moment([date.year(), date.month(), 15])
    else
      s = moment([date.year(), date.month(), 16])
      e = moment([date.year(), date.month()]).add('M', 1).subtract('d', 1)
    @_formatResult(s, e)
  
  _monthly: (date) ->
    s = moment([date.year(), date.month()])
    e = s.clone().add('M', 1).subtract('d', 1)
    @_formatResult(s, e)
  
  _lte: (d1,d2) ->
    d1.unix() <= d2.unix()
  
  _formatResult: (start, stop) ->
    start: start.format( @format )
    stop:   stop.format( @format )
    days:  @_days(start, stop)
  
  _days: (start, stop) ->
    s = start.clone()
    a = []
    while @_lte( s, stop)
      a.push( s.format( @format ) )
      s.add('d', 1)
    a
  
  _initDate: (date) ->
    if moment.isMoment(date) 
      date 
    else 
      moment(date, @format)
  
moment.fn.payperiod = (yearStart, type) ->
  new PayPeriod yearStart, type
