%%%-------------------------------------------------------------------
%%% @author merk
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. May 2018 16:13
%%%-------------------------------------------------------------------
-module(factorial_client).
-author("merk").

%% API
-export([start/0, stop/0, factorial/1, factorialRecorder/2]).

start() ->
  factorial_server:start_link().

stop() ->
  factorial_server:stop().

factorial(Value) ->
  factorial_server:factorial(Value).

factorialRecorder(Value, IoDevice) ->
  factorial_server:factorial(Value, IoDevice).