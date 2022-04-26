defmodule RPNCalculatorInspection do

  @spec start_reliability_check((String.t() -> any), String.t()) :: %{input: String.t(), pid: pid()}
  def start_reliability_check(calculator, input) do
    pid = spawn_link(fn -> calculator.(input) end)
    %{input: input, pid: pid}
  end

  @spec await_reliability_check_result(%{:pid => pid(), :input => String.t()}, %{}) :: %{}
  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} -> Map.put(results, input, :ok)
      {:EXIT, ^pid, _} -> Map.put(results, input, :error)
    after
      100 -> Map.put(results, input, :timeout)
    end

  end

  def reliability_check(calculator, inputs) do
    flag = Process.flag(:trap_exit,true)

    return = Enum.map(inputs, &(start_reliability_check(calculator, &1)))
            |> Enum.reduce(%{}, fn compute, acc ->
                                  await_reliability_check_result(compute, acc)
                                end)
    Process.flag(:trap_exit, flag)
    return
  end

  def correctness_check(calculator, inputs) do
    Enum.map(inputs, fn x ->
                          Task.async(fn -> calculator.(x) end)
                        end)
    |> Task.await_many(100)
  end
end
