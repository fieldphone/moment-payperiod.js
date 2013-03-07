#moment-payperiod.js 

This plugin provides methods to generate date ranges based on standard pay-period definitions.


Examples
--------

### General Usage

Given a `moment` `payperiod` returns three attributes `start`, `stop` and `days`


### Weekly

Increments one week from yearStart. If year start is on a Monday every weekly pay period will start on a monday and end on a sunday.

``` coffeescript
  #yearStart is a moday
  pp = moment("2013-03-04").payperiod('weekly', {yearStart: '2011-01-11'})
  pp.start #returns "2013-03-04"
  pp.stop  #returns "2013-03-10"
  pp.days  #returns [start..stop]
  
  #return payperiod for any date inclusively between start and stop
  pp = moment("2013-03-08").payperiod('weekly', {yearStart: '2011-01-11'})
  pp.start #returns "2013-03-04"
  pp.stop  #returns "2013-03-10"
  pp.days  #returns [start..stop]
  
```

### BiWeekly

Increments two weeks at a time from yearStart. If year start is on a Monday every biweekly pay period will start on a monday and end on a sunday.

``` coffeescript
  #
  pp = moment("2013-03-25").payperiod('biweekly', {yearStart: '2011-01-11'})
  pp.start #returns "2013-03-25"
  pp.stop  #returns "2013-04-07"
  pp.days  #returns [start..stop]
   
```

### Semimonthly

Returns payperiod eater for the 1st through the 15th or from the 16th to the end of month.

#TODO add option to change cutoff day

``` coffeescript
  #
  pp = moment("2013-03-01").payperiod('semimonthly')
  pp.start #returns "2013-03-01"
  pp.stop  #returns "2013-03-15"
   
```

### Monthly

``` coffeescript
  #
  pp = moment("2013-03-25").payperiod('monthly')
  pp.start #returns "2013-03-01"
  pp.stop  #returns "2013-03-31"
  pp.days  #returns array of every day in month
   
```