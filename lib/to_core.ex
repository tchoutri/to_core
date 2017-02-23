defmodule ToCore do

  @version Mix.Project.config[:version]

  def main(args) do
    args |> parse |> process
  end

  def parse(args) do
    case OptionParser.parse(args, strict: [help: :boolean], aliases: [h: :help]) do
      {[help: true], _, _} -> help() ; System.halt(0)
      {_, [path], _}       -> path
      _                    -> help() ; System.halt(1)
    end
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

  def help do
    IO.puts """
    to_core v#{@version} by Théophile Choutri

    Description:
      This program outputs the Core Erlang representation of .beam (BEAM Bytecode) files

    Usage:
      $ to_core path/to/foo.beam
      {:c_module, [], {:c_literal, [], Foo},
        [{:c_var, [], {:__info__, 1}}, {:c_var, [], {:get_beam, 1}},
      ...

    Available Options
      --help | -h    Show this help command.
    """
  end
end
