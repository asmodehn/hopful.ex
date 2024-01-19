defmodule Hopful.NEListTest do
  use ExUnit.Case, async: true

  alias Hopful.NEList

  use ExUnitProperties

  describe "equal?/2" do
    property "one element is equal to itself" do
      check all e <-
                  one_of([
                    atom(:alphanumeric),
                    integer(),
                    float()
                    # TODO : test more
                  ]) do
        # trivial equality check
        assert NEList.equal?(e, e)
      end
    end

    property "one element and the same in a NEList of one element are equal" do
      check all e <-
                  one_of([
                    atom(:alphanumeric),
                    integer(),
                    float()
                    # TODO : test more
                  ]) do
        assert NEList.equal?(%NEList{holder: [e]}, e)
      end
    end

    property "any list of length > 1 is equal to its NEList twin " do
      check all l <-
                  list_of(
                    one_of([
                      atom(:alphanumeric),
                      integer(),
                      float()
                      # TODO : test more
                    ]),
                    min_length: 1
                  ) do
        assert NEList.equal?(%NEList{holder: l}, l)
      end
    end

    property "two NEList fro the same element are equal" do
      check all e <-
                  one_of([
                    atom(:alphanumeric),
                    integer(),
                    float()
                    # TODO : test more
                  ]) do
        assert NEList.equal?(%NEList{holder: [e]}, %NEList{holder: [e]})
      end
    end

    property "two NEList from the same list are equal" do
      check all l <-
                  list_of(
                    one_of([
                      atom(:alphanumeric),
                      integer(),
                      float()
                      # TODO : test more
                    ]),
                    min_length: 1
                  ) do
        assert NEList.equal?(%NEList{holder: l}, %NEList{holder: l})
      end
    end
  end

  describe "new/1" do
    test "creates a NEList equal to the original data" do
      assert NEList.equal?(NEList.new(42), 42)
    end

    test "creates a NEList equal to the original non empty list" do
      assert NEList.equal?(NEList.new([1, 2, 3]), [1, 2, 3])
    end

    test "return an error when the list passed is empty" do
      assert_raise(
        Hopful.NEList.Empty,
        fn -> NEList.new([]) end
      )
    end
  end

  describe "Enumerable impl" do
    property "Enum.count/1 works as if a NEList was a list " do
      check all l <- list_of(integer(), min_length: 1),
                nel = NEList.new(l) do
        assert Enum.count(nel) == length(l)
      end
    end

    property "Enum.at/2 works as if a NEList was a list when index is inside the list" do
      check all l <- list_of(integer(), min_length: 1),
                nel = NEList.new(l),
                lcmi = min(length(l), Enum.count(nel)),
                idx <- integer(Range.new(1, lcmi, 1)) do
        assert Enum.at(l, idx) == Enum.at(nel, idx)
      end
    end

    property "Enum.at/2 works as if a NEList was a list when index is outside the list" do
      check all l <- list_of(integer(), min_length: 1),
                nel = NEList.new(l) do
        assert Enum.at(l, length(l) + 1) == nil
        assert Enum.at(nel, length(l) + 1) == nil
      end
    end
  end
end
