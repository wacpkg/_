#!/usr/bin/env coffee

> ./lua
  ./cls
  ./conn

import * as KEY from './pkg/key'

$ = cls conn,lua

< R = conn

< default R

do =>
  for [k,v] from Object.entries KEY
    {func} = v
    if func
      delete v.func
      $ v,func
  return

export * from './pkg/key'
