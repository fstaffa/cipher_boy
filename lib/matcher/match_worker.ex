defmodule CipherBoy.Matcher.Worker do
	use GenServer.Behaviour

	def start_link(list) do
		:gen_server.start_link(__MODULE__, list, [])
	end

	def start(list) do
		:gen_server.start(__MODULE__, list, [])
	end

	def search(pid, equivalency, regex) do
		:gen_server.call(pid, {equivalency, regex})
	end

	def send_search(pid, from, equivalency, regex, metadata) do
		:gen_server.cast(pid, {from, equivalency, regex, metadata})
	end

	def receive_search do
		receive  do
			{:result, {result, metadata}} -> {result, metadata}
			_ -> []
		after 1000 -> []
		end
	end

	def init(list) do
		{:ok, list}
	end

	def handle_cast({from, equivalency, regex, metadata}, list) do
		result = CipherBoy.Matcher.Implementation.match_word(regex, list, :czech)
		send(from, {:result, {result, metadata}})
		
		{:noreply, list}
	end

	def handle_call({equivalency, regex}, _from, list) do
		result = CipherBoy.Matcher.Implementation.match_word(regex, list, :czech)
		{:reply, result, list}
	end
end