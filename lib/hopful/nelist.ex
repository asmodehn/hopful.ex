defmodule Hopful.NEList do
  defmodule Empty do
    defexception message: "The list is empty and it shouldn't be"
  end

  # TODO : struct necessary for protocol to differentiate with normal list...
  defstruct holder: []

  def new(elements) when is_list(elements) do
    if length(elements) >= 1 do
      %__MODULE__{holder: elements}
    else
      raise Empty
    end
  end

  def new(element) do
    %__MODULE__{holder: [element]}
  end

  def equal?(%__MODULE__{holder: hl}, %__MODULE__{holder: hr}) when hl == hr, do: true
  def equal?(%__MODULE__{holder: [hl]}, %__MODULE__{holder: [hr]}) when hl == hr, do: true

  def equal?(%__MODULE__{holder: h}, r) when h == r, do: true
  def equal?(%__MODULE__{holder: [h]}, r) when h == r, do: true
  def equal?(l, %__MODULE__{holder: h}) when h == l, do: true
  def equal?(l, %__MODULE__{holder: [h]}) when h == l, do: true

  def equal?(l, r), do: l == r

  # we can access a position in a list by reduce (called via Enum.at)
  defimpl Enumerable do
    # This cannot be done without enumerating the list (because of possible sublists)
    def count(nel), do: {:ok, length(nel.holder)}
    # This cannot be done without enumerating the list
    def member?(_nel, _e), do: {:error, __MODULE__}

    # This is duplicated from implementation for lists
    def reduce(_nelist, {:halt, acc}, _fun), do: {:halted, acc}
    def reduce(nelist, {:suspend, acc}, fun), do: {:suspended, acc, &reduce(nelist, &1, fun)}

    # Not possible with NEList
    # def reduce([], {:cont, acc}, _fun), do: {:done, acc}

    def reduce(%Hopful.NEList{holder: [last | []]}, {:cont, acc}, fun) do
      # ending early because we can
      case fun.(last, acc) do
        {:halt, nacc} -> {:done, nacc}
        {:suspend, nacc} -> {:done, nacc}
        {:cont, nacc} -> {:done, nacc}
      end
    end

    def reduce(%Hopful.NEList{holder: [head | tail]}, {:cont, acc}, fun),
      do: reduce(%Hopful.NEList{holder: tail}, fun.(head, acc), fun)

    def slice(_nelist), do: {:error, __MODULE__}
  end
end
