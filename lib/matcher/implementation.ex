defmodule CipherBoy.Matcher.Implementation do
  def load_words(path) do
		File.open!(path, [:utf8], fn(pid) ->
																	do_load_file(pid, [])
															end)
	end

	def do_load_file(file, acc) do
		case IO.read(file, :line) do
			:eof -> Enum.reverse(acc)
			x -> do_load_file(file, [parse_word(x)|acc])
		end
	end

	def match_word(regexp, list) do
		r = Regex.compile!("^" <> regexp <> "$")
		Enum.filter(list, &(Regex.match?(r, &1)))
	end

	def match_word(regexp, list, :czech) do
		similar = ["[aá]", "[cč]", "[dď]", "[eéě]", "[ií]", "[oó]", "[rř]", "[sš]",
							 "[tť]", "[uú]", "[yý]", "[zž]"]
		regexp = Enum.reduce(similar, regexp, fn(x, acc) -> Regex.replace(Regex.compile!(x), acc, x) end)
		match_word(regexp, list)

		end
	
	defp parse_word(line) do
		[_ , word | _] = String.rstrip(line) |> String.split("\t")
		word
  end

end