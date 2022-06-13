defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}


  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{data: data, left: nil, right: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(tree, data) do
    case tree[:data] do
      nil ->
        new(data)
      val when val < data ->
        %{tree | right: insert(tree[:right], data)}
      val when val >= data ->
        %{tree | left: insert(tree[:left], data)}
    end
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(tree) do
    do_order(tree) |> List.flatten()
  end

  defp do_order(tree) do
    case tree[:left] do
      nil ->
        if tree[:right], do: [tree[:data] | [do_order(tree[:right])] ] , else: [tree[:data]]
      val ->
        if tree[:right], do: [do_order(val) |  [tree[:data] | [ do_order(tree[:right])]]], else: [do_order(val) |  [tree[:data]]]
    end
  end
end
