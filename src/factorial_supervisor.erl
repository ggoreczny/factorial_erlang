%%%-------------------------------------------------------------------
%%% @author merk
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. May 2018 17:17
%%%-------------------------------------------------------------------
-module(factorial_supervisor).
-author("merk").

-behavior(supervisor).

%% API
-export([start_link/0, start_link_shell/0]).

-export([init/1]).


start_link_shell() ->
  {ok, Pid} = supervisor:start_link({global, ?MODULE}, ?MODULE, []),
  unlink(Pid).

start_link() ->
  supervisor:start_link({global, ?MODULE}, ?MODULE, []).

init([]) ->
  io:format("~p (~p) starting ... ~n", [{global, ?MODULE}, self()]),

  RestartStrategy = one_for_one,
  MaxRestarts = 3,
  MaxSecondsBetweenRestarts = 5,
  Flags = {RestartStrategy, MaxRestarts, MaxSecondsBetweenRestarts},

  %%  permanent - always restart
  %%  temporary - never restart
  %%  transient - restart if abnormally ends
  Restart = permanent,

  %%  brutal_kill - use exit(Child, kill) to terminate
  %%  integer - use exit(Child, shutdown) - milliseconds
  Shutdown = infinity,

  %%  worker
  %%  supervisor
  Type = worker,

  ChildSpecifications = {factorialServerId, {factorial_server, start_link, []}, Restart, Shutdown, Type, [factorial_server]},

  %%  tuple of restart strategy, max restarts and max time
  %%  child specification
  {ok, {Flags, [ChildSpecifications]}}.