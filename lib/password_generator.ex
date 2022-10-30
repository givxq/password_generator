defmodule PasswordGenerator do
  @moduledoc """
  Generates random password depending on parameters, Module main function is 'generate(options)'.
  That function takes the options map.
  Options example:
        options = %{
          "length" => "5",
          "numbers" => "false",
          "uppercase" => "fal"se",
          "symbols" => "false"
        }
  The options are only 4, 'length', 'numbers', 'uppercase', 'symbols'.
  """

  @allowed_options [:length, :numbers, :uppercase, :symbols]

  @doc """
  Hello world.

  ## Examples

  options = %{
          "length" => "5",
          "numbers" => "false",
          "uppercase" => "fal"se",
          "symbols" => "false"
        }

      iex> PasswordGenerator.generate(options)
      "ascdf"



  options = %{
          "length" => "5",
          "numbers" => "true",
          "uppercase" => "fal"se",
          "symbols" => "false"
        }

      iex> PasswordGenerator.generate(options)
      "ascd3"
  """

  @spec generate(options :: map()) :: {:ok, bitstring()} | {:error, bitstring()}
  def generate(options) do
    length = Map.has_key?(options, "length")
    validate_length(length, options)
  end

  defp validate_length(false, _options), do: {:error, "Please provide a length"}

  defp validate_length(true, options) do
    numbers = Enum.map(0..9, &Integer.to_string(&1))
    length = options["length"]
    length = String.contains?(length, numbers)
    validate_length_is_integer(length, options)
  end

  defp validate_length_is_integer(false, _options) do
    {:error, "Only Integers allowed for length."}
  end

  defp validate_length_is_integer(true, options) do
    length = options["length"] |> String.trim() |> String.to_integer()
    options_without_length = Map.delete(options, "length")
    options_values = Map.values(options_without_length)

    value =
      options_values
      |> Enum.all?(fn x -> String.to_atom(x) |> is_boolean() end)
  end
end
