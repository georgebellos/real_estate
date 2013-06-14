#= require application

Konacha.mochaOptions.ignoreLeaks = true

beforeEach ->
  @page = $("#konacha")
