defmodule CipherBoy.Matcher.WorkerManager do
	use GenServer.Behaviour

	def init(_) do
		{:ok, []}
	end
	
	def start() do
		:gen_server.start(__MODULE__, HashDict.new, [])
	end

	def handle_call({:get, n}, _from, state) do
		list = Dict.get(state, n)
		case list do
			nil -> {:reply, {:no_available}, state}
			[] -> {:reply, {:no_available}, state}
			[head|tail] -> {:reply, head, Dict.put(state, n, tail)}
		end
	end

	def handle_call({:add, worker, n}, _from, state) do
		current = Dict.get(state, n)
		case current do
			nil -> {:reply, :added, Dict.put(state, n, [worker])}
			list -> {:reply, :added, Dict.put(state, n, [worker|list])}
		end
	end
	
	def add(pid, worker, n) do
	  :gen_server.call(pid, {:add, worker, n})
	end

	def get(pid, n) do
		:gen_server.call(pid, {:get, n})
	end

	def terminate(pid) do
	end
end