if typeof module != "undefined"
  moment = require "moment"
  should = require "should"
  PayPeriod = require("../lib/moment-payperiod")
  assert = require("assert")
else
  moment = window.moment
  should = window.should
  PayPeriod = window.PayPeriod

describe "weekly", ->

  days = ['2008-01-31','2008-02-01','2008-02-02','2008-02-03','2008-02-04','2008-02-05','2008-02-06','2008-02-07','2008-02-08','2008-02-09','2008-02-10','2008-02-11']

  it "should return payperiod that starts on a monday and ends on a sunday", ->
    pp = moment("2013-02-25").payperiod("weekly", {yearStart: "2009-01-05"})
    pp.start.should.eql "2013-02-25"
    pp.stop.should.eql "2013-03-03"
    pp.days.length.should.eql 7


describe "biweekly", ->
  yearStart = moment("2008-01-01")
  
  days = ['2008-01-31','2008-02-01','2008-02-02','2008-02-03','2008-02-04','2008-02-05','2008-02-06','2008-02-07','2008-02-08','2008-02-09','2008-02-10','2008-02-11']
  
  it "should return payperiod if date is the first day of payperiod", ->
    pp = moment("2008-01-29").payperiod('biweekly', {yearStart: "2008-01-01"})
    pp.start.should.eql "2008-01-29"
    pp.stop.should.eql "2008-02-11"
    pp.days.length.should.eql 14
    pp.days.should.include(days...)
   
  it "should return payperiod if date is in the middle of payperiod", ->
    pp = moment("2008-02-5").payperiod('biweekly', {yearStart: "2008-01-01"})
    pp.start.should.eql "2008-01-29"
    pp.stop.should.eql "2008-02-11"
    pp.days.length.should.eql 14
    pp.days.should.include(days...)
  
  it "should return payperiod if date is in the last day of payperiod", ->
    pp = moment("2008-02-11").payperiod('biweekly', {yearStart: "2008-01-01"})
    pp.start.should.eql "2008-01-29"
    pp.stop.should.eql "2008-02-11"
    pp.days.length.should.eql 14
    pp.days.should.include(days...)

describe "semimonthly", ->
  yearStart = moment("2008-01-01")
  firstDays = ['2008-02-01','2008-02-02','2008-02-03','2008-02-04','2008-02-05','2008-02-06','2008-02-07','2008-02-08','2008-02-09','2008-02-10','2008-02-11','2008-01-12','2008-02-13','2008-02-14','2008-02-15']

  it "should return first payperiod of month if date is the first day of month", ->
    pp = moment("2008-02-01").payperiod('semimonthly')
    pp.start.should.eql "2008-02-01"
    pp.stop.should.eql "2008-02-15"
    pp.days.length.should.eql 15
    pp.days.should.include(firstDays...)

  it "should return second payperiod of month if date is gte the 16th", ->
    pp = moment("2013-04-18").payperiod('semimonthly')
    pp.start.should.eql "2013-04-16"
    pp.stop.should.eql "2013-04-30"
    pp.days.length.should.eql 15
    #pp.days.should.include(days...)
  # 
  it "should return second payperiod of month if date is equal to the last of month", ->
    pp = moment("2013-04-30").payperiod('semimonthly')
    pp.start.should.eql "2013-04-16"
    pp.stop.should.eql "2013-04-30"
    pp.days.length.should.eql 15
    #pp.days.should.include(days...)


describe "monthly", ->
  yearStart = moment("2008-01-01")
  days = ['2013-01-02','2013-01-03','2013-01-04','2013-01-05','2013-01-06','2013-01-07','2013-01-08','2013-01-09','2013-01-10','2013-01-11','2013-01-12','2013-01-13','2013-01-14','2013-01-15','2013-01-16','2013-01-17','2013-01-18','2013-01-19','2013-01-20','2013-01-21','2013-01-22','2013-01-23','2013-01-24','2013-01-25','2013-01-26','2013-01-27','2013-01-28','2013-01-29','2013-01-30','2013-01-31']
  
  it "should return payperiod if date is the first day of payperiod", ->
    pp = moment("2013-01-01").payperiod('monthly')
    pp.start.should.eql "2013-01-01"
    pp.stop.should.eql "2013-01-31"
    pp.days.length.should.eql 31
    pp.days.should.include(days...)
  
  it "should return payperiod if date is in the middle of payperiod", ->
    pp = moment("2013-01-18").payperiod('monthly')
    pp.start.should.eql "2013-01-01"
    pp.stop.should.eql "2013-01-31"
    pp.days.length.should.eql 31
    pp.days.should.include(days...)
    
  it "should return payperiod if date is the last day of payperiod", ->
    pp = moment("2013-01-31").payperiod('monthly')
    pp.start.should.eql "2013-01-01"
    pp.stop.should.eql "2013-01-31"
    pp.days.length.should.eql 31
    pp.days.should.include(days...)
    
    