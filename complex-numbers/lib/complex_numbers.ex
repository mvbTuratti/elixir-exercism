defmodule ComplexNumbers do
  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}` and
  the complex number `4+3i` is `{4, 3}'.
  """
  @type complex :: {float, float}

  @doc """
  Return the real part of a complex number
  """
  @spec real(a :: complex) :: float
  def real({real, _}) do
    real
  end
  def real(x), do: x

  @doc """
  Return the imaginary part of a complex number
  """
  @spec imaginary(a :: complex) :: float
  def imaginary({_, imaginary}) do
    imaginary
  end
  def imaginary(_), do: 0

  @doc """
  Multiply two complex numbers, or a real and a complex number
  """
  @spec mul(a :: complex | float, b :: complex | float) :: complex
  def mul(a, b) do
    real = real(a) * real(b) - imaginary(a) * imaginary(b)
    imaginary = imaginary(a) * real(b) + real(a) * imaginary(b)
    {real, imaginary}
  end

  @doc """
  Add two complex numbers, or a real and a complex number
  """
  @spec add(a :: complex | float, b :: complex | float) :: complex
  def add(a, b) do
    real = real(a) + real(b)
    imaginary = imaginary(a) + imaginary(b)
    {real, imaginary}
  end

  @doc """
  Subtract two complex numbers, or a real and a complex number
  """
  @spec sub(a :: complex | float, b :: complex | float) :: complex
  def sub(a, b) do
    real = real(a) - real(b)
    imaginary = imaginary(a) - imaginary(b)
    {real, imaginary}
  end

  @doc """
  Divide two complex numbers, or a real and a complex number
  """
  @spec div(a :: complex | float, b :: complex | float) :: complex
  def div(a, b) do
    divisor = :math.pow(real(b),2) + :math.pow(imaginary(b), 2)
    real = (real(a) * real(b) + imaginary(a) * imaginary(b)) / divisor
    imaginary = (imaginary(a) * real(b) - real(a) * imaginary(b)) / divisor
    {real, imaginary}
  end

  @doc """
  Absolute value of a complex number
  """
  @spec abs(a :: complex) :: float
  def abs({a, b}) do
    (:math.pow(a,2) + :math.pow(b,2))
    |> :math.sqrt()
  end

  @doc """
  Conjugate of a complex number
  """
  @spec conjugate(a :: complex) :: complex
  def conjugate({a, b}) do
    {a, b * -1}
  end

  @doc """
  Exponential of a complex number
  """
  @spec exp(a :: complex) :: complex
  def exp(a) do
    # imaginary = {:math.sin(imaginary(a)), :math.cos(imaginary(a))}
    real = :math.exp(real(a))
    imaginary = {:math.cos(imaginary(a)), :math.sin(imaginary(a))}
    mul(real, imaginary)
  end
end
