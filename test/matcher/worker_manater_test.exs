defmodule CipherBoy.Matcher.WorkerManagerTest do
	import CipherBoy.Matcher.WorkerManager
	use Amrita.Sweet
	facts "sanity checks" do
		fact "can start" do
			{result, pid} = start()
			result |> :ok
			terminate(pid)
		end

		fact "can store pid" do
			{_, manager} = start()
			result = add(manager, "", 4)
			result |> :added
		end
	end

	facts "retrieving pids" do
		fact "can retrieve stored pid" do
			{:ok, manager} = start()
			{_, worker} = CipherBoy.Matcher.Worker.start(["test"])
			add(manager, worker, 4) |> :added
			get(manager, 4) |> worker

			terminate(manager)
		end
		
		fact "can't retrieve pid for different letter count" do
			{:ok, manager} = start()
			{_, worker} = CipherBoy.Matcher.Worker.start(["test"])
			add(manager, worker, 4) |> :added
			assert get(manager, 5) === {:no_available}

			terminate(manager)
		end

		fact "can't retrieve pid more times than it is added" do
			{:ok, manager} = start()
			{_, worker} = CipherBoy.Matcher.Worker.start(["test"])
			add(manager, worker, 4) |> :added
			get(manager, 4)
			assert get(manager, 4) === {:no_available}

			terminate(manager)
		end
		
		fact "can retrieve two workers if two were added" do
			{:ok, manager} = start()
			{_, worker1} = CipherBoy.Matcher.Worker.start(["test"])
			{_, worker2} = CipherBoy.Matcher.Worker.start(["test"])
			add(manager, worker1, 4) |> :added
			add(manager, worker2, 4) |> :added
			res = [get(manager, 4), get(manager, 4)]
			res |> contains worker1
			res |> contains worker2

			terminate(manager)
		end
	end
end