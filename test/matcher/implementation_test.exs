defmodule CipherBoy.Matcher.ImplementationTest do
	import CipherBoy.Matcher.Implementation
	use Amrita.Sweet
  facts "TestLoadFile" do
		
		fact "loads small file correctly" do
			load_words("test/inputs/two_lines") |> ["a", "se"]
		end
  end

	facts "TestRegexpMatching" do
		facts "simple matches" do
			fact "matches only item in list" do
			match_word("a", ["a"]) === ["a"]
			end
			fact "matches single item in list with multiple items" do
				match_word("a", ["a", "abc"]) |> ["a"]
			end

			fact "matches multiple items if they match", do:
				match_word("a.", ["az", "at", "aaa"]) |> ["az", "at"]
		end

		facts "matches words with czech letters" do
			fact "matches s" do
				match_word("..sel", ["sešel", "sysel", "nese"], :czech) |> ["sešel", "sysel"]
				match_word("..šel", ["sešel", "sysel", "nese"], :czech) |> ["sešel", "sysel"]
			end
			fact "matches a" do
				match_word(".a", ["ta", "má"], :czech) |> ["ta", "má"]
				match_word(".á", ["ta", "má"], :czech) |> ["ta", "má"]
			end
			fact "matches c" do
				match_word(".c", ["ac", "ač"], :czech) |> ["ac", "ač"] 
				match_word(".č", ["ac", "ač"], :czech) |> ["ac", "ač"] 
			end
			fact "matches d" do
				match_word(".d", ["aď", "ad"], :czech) |> ["aď", "ad"]
				match_word(".ď", ["aď", "ad"], :czech) |> ["aď", "ad"]
			end

			fact "matches e" do
				match_word(".e", ["ae", "aě", "aé"], :czech) |> ["ae", "aě", "aé"]
				match_word(".é", ["ae", "aě", "aé"], :czech) |> ["ae", "aě", "aé"]
				match_word(".ě", ["ae", "aě", "aé"], :czech) |> ["ae", "aě", "aé"]
			end

			fact "matches i" do
				match_word(".i", ["ai", "aí"], :czech) |> ["ai", "aí"]
				match_word(".í", ["ai", "aí"], :czech) |> ["ai", "aí"]
			end

			fact "matches o" do
				match_word(".o", ["ao", "aó"], :czech) |> ["ao", "aó"]
				match_word(".ó", ["ao", "aó"], :czech) |> ["ao", "aó"]
			end

			fact "matches r" do
				match_word(".r", ["ar", "ař"], :czech) |> ["ar", "ař"]
				match_word(".ř", ["ar", "ař"], :czech) |> ["ar", "ař"]
			end

			fact "matches s" do
				match_word(".s", ["as", "aš"], :czech) |> ["as", "aš"]
				match_word(".š", ["as", "aš"], :czech) |> ["as", "aš"]
			end

			fact "matches t" do
				match_word(".t", ["at", "ať"], :czech) |> ["at", "ať"]
				match_word(".ť", ["at", "ať"], :czech) |> ["at", "ať"]
			end

			fact "matches u" do
				match_word(".u", ["au", "aú"], :czech) |> ["au", "aú"]
				match_word(".ú", ["au", "aú"], :czech) |> ["au", "aú"]
			end

			fact "matches y" do
				match_word(".y", ["ay", "aý"], :czech) |> ["ay", "aý"]
				match_word(".ý", ["ay", "aý"], :czech) |> ["ay", "aý"]
			end

			fact "matches z" do
				match_word(".z", ["az", "až"], :czech) |> ["az", "až"]
				match_word(".ž", ["az", "až"], :czech) |> ["az", "až"]
			end
		end
	end
end