defmodule ToCore do

  def main(args) do
    args |> parse |> process
  end

  def parse(args) do
    {_, [path], _} = OptionParser.parse(args)
    path
  end

  def process(path) do
    translate(path)
  end

  def translate(path) do
    path
    |> get_beam
    |> to_abstract
    |> to_core
    |> IO.inspect
  end

  def get_beam(beam) when is_binary(beam) do
    IO.puts "conversion!"
    String.to_char_list(beam)
  end

  def get_beam(beam) when is_atom(beam) do
    {_, beam, _} = :code.get_object_code(beam)
    beam
  end

  def to_abstract(beam) do
    {:ok, {_, [abstract_code: {_, abstract_code}]}} = :beam_lib.chunks(beam, [:abstract_code])
    abstract_code
  end

  def to_core(abstract_code) do
    {:ok, _module, core_code} = :compile.forms(abstract_code, [:to_core])
    core_code
  end
end
