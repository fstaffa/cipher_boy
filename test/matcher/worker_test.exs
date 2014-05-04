defmodule CipheBoy.Matcher.WorkerTest do
	import CipherBoy.Matcher.Worker
	use Amrita.Sweet
	
	facts "searching" do
		fact "can search" do
			list = ["kotel", "kašel"]
			{_, pid} = start(list)
			result = search(pid, {letter_equivalency: :czech, "ko.el"})
			assert result === ["kotel"]
		end

		fact "async search" do
			list = ["kotel", "kašel"]
			{_, pid} = start(list)
			send_search(pid, self, :czech, "ko.el", {2})

			assert receive_search === {["kotel"], {2}}
		end
	end
end