defmodule RPNCalculator do
  @doc """
  Simple exercise around rescuing concepts, capturing exception cases
  and returning with appropriate message
  """


  @type verbose() :: {:ok, String.t()} | :error | {:error, String.t()}
  @type calculate() :: {:ok, String.t()} | :error

  @spec calculate!(stack :: [], operation :: (any -> String.t())) :: String.t()
  def calculate!(stack, operation) do
    operation.(stack)
  end

  @spec calculate(stack :: [], operation :: (-> String.t())) :: calculate()
  def calculate(stack, operation) do
    try do
      {:ok, operation.(stack)}
    rescue
      _ -> :error
    end
  end

  @spec calculate_verbose(stack :: [], operation :: (-> String.t())) :: verbose()
  def calculate_verbose(stack, operation) do
    try do
      {:ok, operation.(stack)}
    rescue
      e in ArgumentError -> {:error, e.message}
      _ -> :error
    end
  end
end
