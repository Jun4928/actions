# shellcheck disable=SC2148
# shellcheck disable=SC1091

TEST_STRING=( "camelSnakeKebab" "CamelSnakeKebab" "camel_snake_kebab" "Camel_Snake_Kebab" "CAMEL_SNAKE_KEBAB" "camel-snake-kebab" "Camel-Snake-Kebab" "CAMEL-SNAKE-KEBAB" "camel__snake_kebab" "camel___snake_kebab" "camel____snake_kebab" "camel--snake-kebab" "camel---snake-kebab" "camel----snake-kebab" )

test_kebab() {
  for string in "${TEST_STRING[@]}"; do
    actual=$(sh ./casbab.sh kebab "$string")
    expected="camel-snake-kebab"
    assertEquals "string: $string" "$expected" "$actual"
  done
}

. shunit2
