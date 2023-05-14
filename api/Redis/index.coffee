#!/usr/bin/env coffee

> ./lua
  ./cls
  @w5/redis/R.js:_R

import * as KEY from './pkg/key'

export R=_R
$ = cls R,lua

# 绑定redis键的前缀
do =>
  for [k,v] from Object.entries KEY
    {func} = v
    if func
      delete v.func
      $ v,func
  return

export * from './pkg/key'

< default R
